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
exports.UsersService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const constants_1 = require("../stock/constants");
let UsersService = class UsersService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async user(postWhereUniqueInput) {
        return this.prisma.fos_user.findUnique({
            where: postWhereUniqueInput,
        });
    }
    async getSerialNumberByUser(userId) {
        return this.prisma.user_serial_number.findUnique({
            where: {
                user_id: userId
            },
        });
    }
    async addSerialNumber(userId, serialNumber) {
        const created = await this.prisma.user_serial_number.create({
            data: {
                user_id: userId,
                serial_number: serialNumber,
            }
        });
        if (!created) {
            throw new common_1.HttpException("unable to add serial number", common_1.HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return created;
    }
    async users(params) {
        const { skip, take, cursor, where, orderBy } = params;
        return this.prisma.fos_user.findMany({
            skip,
            take,
            cursor,
            where,
            orderBy,
        });
    }
    async create(data) {
        return this.prisma.fos_user.create({
            data: data
        });
    }
    async updateUser(params) {
        const { where, data } = params;
        return this.prisma.fos_user.update({
            data,
            where,
        });
    }
    async deleteUser(where) {
        return this.prisma.fos_user.delete({
            where,
        });
    }
    async getUserGroups(userId) {
        const user_groups = await this.prisma.fos_user_user_group.findMany({
            where: { user_id: userId },
            include: {
                fos_group: {
                    include: {
                        type_group: true
                    },
                },
            },
        });
        return user_groups.map((item) => item.fos_group);
    }
    async getCodeTypeGroup(user) {
        const groups = await this.getUserGroups(user.id);
        if (groups.length !== 0) {
            return groups[0].type_group?.code ?? null;
        }
        return null;
    }
    async getCodeTypeGroupFaster(userGroups) {
        if (userGroups.length !== 0) {
            return userGroups[0].type_group?.code ?? null;
        }
        return null;
    }
    async getUserChildren(userId) {
        const user = await this.prisma.fos_user.findUnique({
            where: { id: userId, enabled: true },
            include: {
                children: true
            }
        });
        return user.children;
    }
    async getUserWithChildrenAndGroup(userId) {
        const user = await this.prisma.fos_user.findUnique({
            where: { id: userId, enabled: true },
            select: {
                id: true,
                username: true,
                parent_user_id: true,
                parent: true,
                fos_user_user_group: {
                    select: {
                        fos_group: {
                            select: {
                                parent_stocks: true,
                                type_group: { select: { code: true } }
                            }
                        }
                    }
                },
                children: {
                    select: {
                        id: true,
                        username: true,
                        parent_user_id: true,
                        children: {
                            select: {
                                id: true,
                                username: true,
                                children: true,
                            }
                        }
                    }
                }
            }
        });
        return user;
    }
    async getListOfPos(user, childOnly = false) {
        const code = await this.getCodeTypeGroup(user);
        const listPos = [];
        if (![constants_1.TypeGroup.CODE_SUPER_ADMIN, constants_1.TypeGroup.CODE_ADMIN, constants_1.TypeGroup.CODE_DR_DISTRIBUTEUR, constants_1.TypeGroup.CODE_HELP_DESK].includes(code)) {
            if (!childOnly) {
                listPos.push(user.id);
            }
            const sons = await this.getUserChildren(user.id);
            for (let i = 0; i < sons.length; i++) {
                const son = sons[i];
                listPos.push(son.id);
                if (![constants_1.TypeGroup.CODE_REGION, constants_1.TypeGroup.CODE_DVD, constants_1.TypeGroup.CODE_DVI].includes(code)) {
                    return;
                }
                const grandsons = await this.getUserChildren(son.id);
                if (!grandsons)
                    return;
                for (let j = 0; j < grandsons.length; j++) {
                    const grandson = grandsons[j];
                    listPos.push(grandson.id);
                    if (code == constants_1.TypeGroup.CODE_DVD) {
                        const grandson_sons = await this.getUserChildren(grandson.id);
                        for (let k = 0; k < grandson_sons.length; k++) {
                            const grandson_son = grandson_sons[k];
                            listPos.push(grandson_son.id);
                        }
                    }
                }
            }
        }
        const listPosStr = listPos.join(',');
        return listPosStr;
    }
    async getListOfPosFaster(userId, childOnly = false) {
        const user = await this.getUserWithChildrenAndGroup(userId);
        const code = await this.getCodeTypeGroupFaster(user.fos_user_user_group);
        let listPos = [];
        if (!childOnly) {
            listPos = [...listPos, user.id];
        }
        const sons = user.children;
        for (let i = 0; i < sons.length; i++) {
            const son = sons[i];
            listPos = [...listPos, son.id];
            const grandsons = son.children;
            for (let j = 0; j < grandsons.length; j++) {
                const grandson = grandsons[j];
                listPos = [...listPos, grandson.id];
                const grandson_sons = grandson.children;
                for (let k = 0; k < grandson_sons.length; k++) {
                    const grandson_son = grandson_sons[k];
                    listPos = [...listPos, grandson_son.id];
                }
            }
        }
        return listPos;
    }
};
exports.UsersService = UsersService;
exports.UsersService = UsersService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], UsersService);
//# sourceMappingURL=users.service.js.map