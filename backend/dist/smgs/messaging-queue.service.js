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
exports.MessagingQueueService = void 0;
const common_1 = require("@nestjs/common");
let MessagingQueueService = class MessagingQueueService {
    constructor(kmqRepository) {
        this.kmqRepository = kmqRepository;
    }
    async findAll() {
        return this.kmqRepository.findAll();
    }
    async add(simFrom, phone, content, smscId) {
        return await this.kmqRepository.create({
            'momt': "MT",
            'sender': simFrom,
            'receiver': `+216${phone}`,
            'udhdata': null,
            'msgdata': content,
            'time': 0,
            'smsc_id': smscId,
            'mclass': '-1',
            'mwi': '-1',
            'compress': '-1',
            'validity': '-1',
            'deferred': '-1',
            'coding': '0',
            'dlr_mask': '31',
        });
    }
};
exports.MessagingQueueService = MessagingQueueService;
exports.MessagingQueueService = MessagingQueueService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, common_1.Inject)('KMQ_REPOSITORY')),
    __metadata("design:paramtypes", [Object])
], MessagingQueueService);
//# sourceMappingURL=messaging-queue.service.js.map