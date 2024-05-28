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
exports.ActivationController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const activation_service_1 = require("./activation.service");
const auth_guard_1 = require("../auth/auth.guard");
const json_serialize_1 = require("../helpers/json-serialize");
const pagination_dto_1 = require("../helpers/pagination.dto");
let ActivationController = class ActivationController {
    constructor(activationService) {
        this.activationService = activationService;
    }
    async getRecentHistory(page, perPage, req) {
        const operations = await this.activationService.getRecentOperationActivationByUsers(req.user.id, page, perPage);
        return (0, json_serialize_1.default)(operations);
    }
    async getOldHistory(page, perPage, req) {
        const operations = await this.activationService.getOldOperationActivationByUsers(req.user.id, page, perPage);
        return (0, json_serialize_1.default)(operations);
    }
};
exports.ActivationController = ActivationController;
__decorate([
    (0, common_1.Get)('/history/recent'),
    (0, swagger_1.ApiOkResponse)({ type: (pagination_dto_1.PaginatedOutputDto) }),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiQuery)({ name: 'page', example: 1, required: false }),
    (0, swagger_1.ApiQuery)({ name: 'perPage', example: 10, required: false }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('perPage')),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, Object]),
    __metadata("design:returntype", Promise)
], ActivationController.prototype, "getRecentHistory", null);
__decorate([
    (0, common_1.Get)('/history/old'),
    (0, swagger_1.ApiOkResponse)({ type: (pagination_dto_1.PaginatedOutputDto) }),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiQuery)({ name: 'page', example: 1, required: false }),
    (0, swagger_1.ApiQuery)({ name: 'perPage', example: 10, required: false }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('perPage')),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, Object]),
    __metadata("design:returntype", Promise)
], ActivationController.prototype, "getOldHistory", null);
exports.ActivationController = ActivationController = __decorate([
    (0, common_1.Controller)('activation'),
    (0, swagger_1.ApiTags)('ActivationController'),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [activation_service_1.ActivationService])
], ActivationController);
//# sourceMappingURL=activation.controller.js.map