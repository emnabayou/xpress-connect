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
var AuthService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const jwt_1 = require("@nestjs/jwt");
const users_service_1 = require("../users/users.service");
const crypto = require("crypto");
const speakeasy = require("speakeasy");
const messaging_queue_service_1 = require("../smgs/messaging-queue.service");
let AuthService = AuthService_1 = class AuthService {
    constructor(usersService, jwtService, smgsService) {
        this.usersService = usersService;
        this.jwtService = jwtService;
        this.smgsService = smgsService;
        this.logger = new common_1.Logger(AuthService_1.name);
        this.hashPassword = (password, salt) => {
            let salted = password + '{' + salt + '}';
            let digest = crypto.createHash('sha512').update(salted).digest('binary');
            for (let i = 1; i < 5000; i++) {
                digest = crypto.createHash('sha512').update(Buffer.concat([Buffer.from(digest, 'binary'), Buffer.from(salted, 'utf8')])).digest('binary');
            }
            return (Buffer.from(digest, 'binary')).toString('base64');
        };
    }
    verifyPassword(password, salt, hashedPassword) {
        const hashedInputPassword = this.hashPassword(password, salt);
        return hashedInputPassword === hashedPassword;
    }
    async generateAuthToken(payload) {
        const accessToken = await this.jwtService.signAsync(payload, {
            secret: process.env.JWT_SECRET,
            algorithm: 'HS256',
            expiresIn: process.env.TOKEN_EXPIRATION
        });
        const refreshToken = await this.jwtService.signAsync(payload, { secret: process.env.REFRESH_TOKEN_SECRET, expiresIn: process.env.REFRESH_TOKEN_EXPIRATION });
        return { accessToken, refreshToken };
    }
    async verifyOTP(username, otp) {
        const user = await this.usersService.user({ username: username });
        const { otp_attempts } = await this.usersService.updateUser({
            where: { username: username },
            data: { otp_attempts: user.otp_attempts + 1 }
        });
        if (!user) {
            throw new common_1.HttpException("user not found", common_1.HttpStatus.BAD_REQUEST);
        }
        if (!user.enabled || user.locked || !user.digitalised) {
            throw new common_1.HttpException("user not UNAUTHORIZED", common_1.HttpStatus.UNAUTHORIZED);
        }
        if (otp_attempts > parseInt(process.env.OTP_MAX_ATTEMPTS)) {
            throw new common_1.HttpException("too many attempts", common_1.HttpStatus.UNAUTHORIZED);
        }
        const tokenValidates = speakeasy.totp.verify({
            secret: user.otp_secret ?? "",
            encoding: 'base32',
            token: otp,
            window: 2,
        });
        if (tokenValidates === false) {
            throw new common_1.HttpException("incorect otp", common_1.HttpStatus.UNAUTHORIZED);
        }
        const payload = { id: user.id, username: user.username };
        const { accessToken, refreshToken } = await this.generateAuthToken(payload);
        return {
            success: true,
            data: {
                accessToken,
                refreshToken
            }
        };
    }
    async getSerialNumberByUser(userId) {
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = AuthService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        jwt_1.JwtService,
        messaging_queue_service_1.MessagingQueueService])
], AuthService);
//# sourceMappingURL=auth.service.js.map