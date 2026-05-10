import { Injectable, Logger } from '@nestjs/common';
import { createHash, randomInt } from 'crypto';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class OtpService {
  private readonly log = new Logger(OtpService.name);

  constructor(private readonly prisma: PrismaService) {}

  async issue(phone: string): Promise<string> {
    const code = String(randomInt(100000, 999999));
    const codeHash = createHash('sha256').update(code).digest('hex');
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

    const req = await this.prisma.otpRequest.create({
      data: { phone, codeHash, expiresAt },
    });

    if (process.env.NODE_ENV === 'development') {
      this.log.warn(`[DEV OTP] phone=${phone} code=${code}`);
    } else {
      // TODO: send via MSG91
    }

    return req.id;
  }

  async verify(requestId: string, code: string): Promise<string | null> {
    const req = await this.prisma.otpRequest.findUnique({ where: { id: requestId } });
    if (!req) return null;
    if (req.consumedAt) return null;
    if (req.expiresAt < new Date()) return null;
    if (req.attempts >= 5) return null;

    const codeHash = createHash('sha256').update(code).digest('hex');
    if (codeHash !== req.codeHash) {
      await this.prisma.otpRequest.update({
        where: { id: requestId },
        data: { attempts: req.attempts + 1 },
      });
      return null;
    }

    await this.prisma.otpRequest.update({
      where: { id: requestId },
      data: { consumedAt: new Date() },
    });
    return req.phone;
  }
}
