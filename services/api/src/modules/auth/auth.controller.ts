import { Body, Controller, Post } from '@nestjs/common';
import { IsString, Length, Matches } from 'class-validator';

import { AuthService } from './auth.service';

class OtpRequestDto {
  @Matches(/^[6-9]\d{9}$/, { message: 'Must be a valid Indian mobile number' })
  phone!: string;
}

class OtpVerifyDto {
  @IsString()
  requestId!: string;

  @Length(6, 6)
  @Matches(/^\d{6}$/)
  code!: string;
}

@Controller('auth')
export class AuthController {
  constructor(private readonly auth: AuthService) {}

  @Post('otp/request')
  async requestOtp(@Body() dto: OtpRequestDto) {
    return this.auth.requestOtp(dto.phone);
  }

  @Post('otp/verify')
  async verifyOtp(@Body() dto: OtpVerifyDto) {
    return this.auth.verifyOtp(dto.requestId, dto.code);
  }

  @Post('logout')
  logout() {
    // TODO: revoke session by refresh token
    return { ok: true };
  }
}
