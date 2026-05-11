import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { AuthModule } from './modules/auth/auth.module';
import { JobsModule } from './modules/jobs/jobs.module';
import { UsersModule } from './modules/users/users.module';
import { PrismaModule } from './modules/prisma/prisma.module';
import { HealthController } from './health.controller';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthModule,
    UsersModule,
    JobsModule,
  ],
  controllers: [HealthController],
})
export class AppModule {}
