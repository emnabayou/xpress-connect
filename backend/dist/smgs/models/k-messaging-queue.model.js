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
exports.KMessagingQueues = void 0;
const sequelize_1 = require("sequelize");
const sequelize_typescript_1 = require("sequelize-typescript");
let KMessagingQueues = class KMessagingQueues extends sequelize_typescript_1.Model {
};
exports.KMessagingQueues = KMessagingQueues;
__decorate([
    sequelize_typescript_1.PrimaryKey,
    (0, sequelize_typescript_1.Column)({ autoIncrement: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "sql_id", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    (0, sequelize_typescript_1.Column)(sequelize_1.DataTypes.ENUM('MO', 'MT')),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "momt", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "sender", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "receiver", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)(sequelize_1.DataTypes.BLOB),
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "udhdata", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "msgdata", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "time", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "smsc_id", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "service", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "account", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true, defaultValue: null }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "id", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "sms_type", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "mclass", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "mwi", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "coding", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "compress", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "validity", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "deferred", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "dlr_mask", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "dlr_url", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "pid", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "alt_dcs", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", Number)
], KMessagingQueues.prototype, "rpi", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "charset", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "boxc_id", void 0);
__decorate([
    (0, sequelize_typescript_1.Column)({ allowNull: true }),
    __metadata("design:type", String)
], KMessagingQueues.prototype, "binfo", void 0);
exports.KMessagingQueues = KMessagingQueues = __decorate([
    (0, sequelize_typescript_1.Table)({ tableName: "k_messagingqueues" })
], KMessagingQueues);
//# sourceMappingURL=k-messaging-queue.model.js.map