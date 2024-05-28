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
exports.StockService = void 0;
const common_1 = require("@nestjs/common");
const prisma_pagination_1 = require("prisma-pagination");
const prisma_service_1 = require("../prisma/prisma.service");
const users_service_1 = require("../users/users.service");
let StockService = class StockService {
    constructor(prisma, usersService) {
        this.prisma = prisma;
        this.usersService = usersService;
    }
    async getStocks() {
        const userId = 51;
        const user = await this.usersService.user({ id: userId, enabled: true });
        if (!user)
            return;
        const listOfPos = this.usersService.getListOfPos(user);
    }
    async getStockByUsers(listOfPos, page, isDsa = true, perPage = 10) {
        const paginate = (0, prisma_pagination_1.createPaginator)({ perPage });
        const msisdns = await paginate(this.prisma.msisdn, {
            where: {
                sold: 0,
                user_id: {
                    in: listOfPos
                },
                isDsa: isDsa
            },
            orderBy: {
                updated_at: 'desc'
            }
        }, { page });
        return msisdns;
    }
};
exports.StockService = StockService;
exports.StockService = StockService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService, users_service_1.UsersService])
], StockService);
//# sourceMappingURL=stock.service.js.map