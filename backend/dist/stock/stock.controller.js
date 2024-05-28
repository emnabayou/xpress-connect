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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.StockController = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const stock_service_1 = require("./stock.service");
const swagger_1 = require("@nestjs/swagger");
const auth_guard_1 = require("../auth/auth.guard");
const json_serialize_1 = require("../helpers/json-serialize");
const pagination_dto_1 = require("../helpers/pagination.dto");
let StockController = class StockController {
    constructor(usersService, stockService) {
        this.usersService = usersService;
        this.stockService = stockService;
    }
    async getStocks(isDsa, page, req) {
        const userId = req.user.id;
        const user = await this.usersService.getUserWithChildrenAndGroup(userId);
        const userGroup = user?.fos_user_user_group[0]?.fos_group ?? null;
        let listOfPos = await this.usersService.getListOfPosFaster(userId);
        if (listOfPos) {
            const parentLevel = userGroup?.parent_stocks;
            if (parentLevel === 1) {
                const parentId = user.parent_user_id;
                if (parentId)
                    listOfPos = [...listOfPos, parentId];
            }
            if (parentLevel === 2) {
                const parent = user.parent;
                if (parent) {
                    const grandParentId = parent.parent_user_id;
                    if (grandParentId)
                        listOfPos = [...listOfPos, grandParentId];
                }
            }
        }
        const stocks = await this.stockService.getStockByUsers(listOfPos, page, isDsa === 'true');
        return (0, json_serialize_1.default)(stocks);
    }
};
exports.StockController = StockController;
__decorate([
    (0, common_1.Get)('/'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, swagger_1.ApiOkResponse)({ type: (pagination_dto_1.PaginatedOutputDto) }),
    (0, swagger_1.ApiQuery)({ name: 'page', example: 1, required: false }),
    (0, swagger_1.ApiQuery)({ name: 'dsa', example: true, required: true }),
    __param(0, (0, common_1.Query)('dsa')),
    __param(1, (0, common_1.Query)('page')),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Number, Object]),
    __metadata("design:returntype", Promise)
], StockController.prototype, "getStocks", null);
exports.StockController = StockController = __decorate([
    (0, common_1.Controller)('stocks'),
    (0, swagger_1.ApiTags)('StockController'),
    __metadata("design:paramtypes", [users_service_1.UsersService, stock_service_1.StockService])
], StockController);
//# sourceMappingURL=stock.controller.js.map