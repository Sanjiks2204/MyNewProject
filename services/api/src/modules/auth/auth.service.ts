import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { randomUUID } from 'crypto';

import { PrismaService } from '../prisma/prisma.service';
import { OtpService } from './otp.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly otp: OtpService,
    private readonly jwt: JwtService,
  ) {}

  async requestOtp(phone: string) {
    const requestId = await this.otp.issue(phone);
    return { requestId, resendInSeconds: 30 };
  }

  async verifyOtp(requestId: string, code: string) {
    const phone = await this.otp.verify(requestId, code);
    if (!phone) throw new UnauthorizedException('Invalid or expired code');

    let user = await this.prisma.user.findUnique({ where: { phone } });
    const isNewUser = !user;

    if (!user) {
      user = await this.prisma.user.create({
        data: {
          phone,
          role: 'customer',
          customer: { create: {} },
        },
      });
    }

    const accessToken = await this.signAccess(user.id, user.role);
    const refreshToken = randomUUID();

    await this.prisma.session.create({
      data: {
        userId: user.id,
        refreshHash: refreshToken, // TODO: hash before storage
      },
    });

    return { accessToken, refreshToken, isNewUser };
  }

  private signAccess(userId: string, role: string) {
    // TODO: load RS256 keys from disk per env config
    return this.jwt.signAsync(
      { sub: userId, role },
      { secret: process.env.JWT_SECRET ?? 'dev-secret', expiresIn: '15m' },
    );
  }
}
