import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { IsArray, IsEnum, IsOptional, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

import { JobsService } from './jobs.service';

class GeoPointDto {
  @IsString() lat!: string;
  @IsString() lng!: string;
}

class PickupDto {
  @IsString() line!: string;
  @ValidateNested() @Type(() => GeoPointDto) point!: GeoPointDto;
  @IsOptional() @IsString() landmark?: string;
}

class CreateJobDto {
  @IsString() vehicleId!: string;
  @IsEnum([
    'flat_tire',
    'battery_dead',
    'fuel_empty',
    'engine_noise',
    'overheating',
    'brakes',
    'electrical',
    'accident',
    'key_locked_in',
    'other',
  ])
  category!: string;
  @ValidateNested() @Type(() => PickupDto) pickup!: PickupDto;
  @IsOptional() @IsString() description?: string;
  @IsOptional() @IsArray() photoUrls?: string[];
}

@Controller('jobs')
export class JobsController {
  constructor(private readonly jobs: JobsService) {}

  @Post()
  create(@Body() dto: CreateJobDto) {
    return this.jobs.create(dto);
  }

  @Get(':id')
  byId(@Param('id') id: string) {
    return this.jobs.byId(id);
  }

  @Post(':id/cancel')
  cancel(@Param('id') id: string, @Body() body: { reason?: string }) {
    return this.jobs.cancel(id, body?.reason);
  }
}
