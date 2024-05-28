"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ActivationService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const prisma_pagination_1 = require("prisma-pagination");
let ActivationService = class ActivationService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    startOfMonth(date) {
        return new Date(date.getFullYear(), date.getMonth(), 1);
    }
    async getRecentOperationActivationByUsers(userId, page, perPage) {
        const date = this.startOfMonth(new Date());
        const paginate = (0, prisma_pagination_1.createPaginator)({ perPage });
        const operations = await paginate(this.prisma.operation_activation, {
            select: {
                id: true,
                sim: true,
                msisdn: true,
                piece_identif: true,
                cin_pp: true,
                created_at: true,
                status: true,
                text_status: true,
                user: {
                    select: {
                        username: true,
                    },
                },
                latitude: true,
                longitude: true,
                channel: true,
                isDsa: true
            },
            where: {
                AND: [
                    {
                        created_at: { gte: date }
                    },
                    { user_id: userId }
                ]
            },
            orderBy: {
                created_at: 'desc'
            },
        }, { page });
        return operations;
    }
    async getOldOperationActivationByUsers(userId, page, perPage) {
        const date = this.startOfMonth(new Date());
        const paginate = (0, prisma_pagination_1.createPaginator)({ perPage });
        const operations = await paginate(this.prisma.operation_activation, {
            select: {
                id: true,
                sim: true,
                msisdn: true,
                piece_identif: true,
                cin_pp: true,
                created_at: true,
                status: true,
                text_status: true,
                user: {
                    select: {
                        username: true,
                    },
                },
                latitude: true,
                longitude: true,
                channel: true,
                isDsa: true
            },
            where: {
                AND: [
                    {
                        created_at: { lte: date }
                    },
                    { user_id: userId }
                ]
            },
            orderBy: {
                created_at: 'desc'
            },
        }, { page });
        return operations;
    }
};
exports.ActivationService = ActivationService;
exports.ActivationService = ActivationService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ActivationService);
//# sourceMappingURL=activation.service.js.map