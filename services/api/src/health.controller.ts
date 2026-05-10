import { Controller, Get } from '@nestjs/common';

@Controller('health')
export class HealthController {
  @Get()
  health() {
    return { status: 'ok', service: 'mechzo-api', time: new Date().toISOString() };
  }
}
