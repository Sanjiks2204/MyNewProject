import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class JobsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: any) {
    // TODO: wire to authenticated customer; pickup geometry via raw SQL
    // for now this is a placeholder that returns a stub id
    return { jobId: 'stub-' + Date.now().toString(36) };
  }

  async byId(id: string) {
    const job = await this.prisma.job.findUnique({ where: { id } });
    if (!job) throw new NotFoundException();
    return job;
  }

  async cancel(id: string, reason?: string) {
    await this.prisma.job.update({
      where: { id },
      data: { status: 'cancelled', cancelledAt: new Date(), cancelReason: reason },
    });
    return { ok: true };
  }
}
