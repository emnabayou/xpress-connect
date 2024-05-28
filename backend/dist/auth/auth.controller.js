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
var AuthController_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const auth_request_dto_1 = require("./models/auth-request.dto");
const auth_service_1 = require("./auth.service");
const xc_response_model_1 = require("../xc-response.model");
const auth_guard_1 = require("./auth.guard");
const users_service_1 = require("../users/users.service");
const auth_verify_otp_dto_1 = require("./models/auth-verify-otp.dto");
const jwt_1 = require("@nestjs/jwt");
const change_password_dto_1 = require("./models/change-password.dto");
const crypto = require("crypto");
const speakeasy = require("speakeasy");
const messaging_queue_service_1 = require("../smgs/messaging-queue.service");
class refreshTokenRequestDto {
}
__decorate([
    (0, swagger_1.ApiProperty)(),
    __metadata("design:type", String)
], refreshTokenRequestDto.prototype, "refreshToken", void 0);
let AuthController = AuthController_1 = class AuthController {
    constructor(authService, usersService, jwtService, smgsService) {
        this.authService = authService;
        this.usersService = usersService;
        this.jwtService = jwtService;
        this.smgsService = smgsService;
        this.logger = new common_1.Logger(AuthController_1.name);
    }
    async login(body) {
        const { username, password, } = body;
        const inputSerialNumber = body.serialNumber;
        const user = await this.usersService.user({ username: username });
        if (!user) {
            throw new common_1.HttpException("user not found", common_1.HttpStatus.BAD_REQUEST);
        }
        if (!user.enabled || user.locked || !user.digitalised) {
            console.log({
                enabled: user.enabled,
                locked: user.locked,
                digitalised: user.digitalised,
            });
            throw new common_1.HttpException("user not UNAUTHORIZED", common_1.HttpStatus.UNAUTHORIZED);
        }
        const serialNumber = await this.usersService.getSerialNumberByUser(user.id);
        if (!serialNumber) {
            this.logger.debug(`adding serial number ${inputSerialNumber} to ${user.fullname}`);
            await this.usersService.addSerialNumber(user.id, inputSerialNumber);
        }
        if (serialNumber && serialNumber?.serial_number !== inputSerialNumber) {
            throw new common_1.HttpException("user with a different sim loggedin", common_1.HttpStatus.BAD_REQUEST);
        }
        if (!this.authService.verifyPassword(password, user.salt, user.password)) {
            throw new common_1.HttpException("wrong password", common_1.HttpStatus.BAD_REQUEST);
        }
        if (!user.otp) {
            const payload = { id: user.id, username: user.username };
            const { accessToken, refreshToken } = await this.authService.generateAuthToken(payload);
            return {
                success: true,
                data: {
                    withOTP: false,
                    accessToken,
                    refreshToken
                }
            };
        }
        const secret = speakeasy.generateSecret({ length: 20 });
        const otp = speakeasy.totp({
            secret: secret.base32,
            encoding: 'base32',
            step: 30
        });
        await this.usersService.updateUser({
            where: { username: username },
            data: { otp_attempts: 0 }
        });
        console.log("generated otp: ", otp);
        console.log("otp secret: ", secret.base32);
        const kmessaging = await this.smgsService.add("+21621016270", "56614706", `votre otp : ${otp}`, "smscid");
        this.logger.log(`inserted kmessaging :${kmessaging}`);
        await this.usersService.updateUser({
            where: { username: username },
            data: { otp_secret: secret.base32 }
        });
        return {
            success: true,
            message: "otp sent success",
            data: {
                withOTP: true,
            }
        };
    }
    async refreshToken(body) {
        const refreshToken = body.refreshToken;
        try {
            const payload = await this.jwtService.verifyAsync(refreshToken, { secret: process.env.REFRESH_TOKEN_SECRET, });
            if (!payload || !payload.hasOwnProperty("id")) {
                throw new common_1.UnauthorizedException();
            }
            const user = await this.usersService.user({ id: payload.id });
            if (!user) {
                throw new common_1.UnauthorizedException();
            }
            const newPayload = { id: user.id, username: user.username };
            const tokens = await this.authService.generateAuthToken(newPayload);
            return {
                success: true,
                data: {
                    accessToken: tokens.accessToken,
                    refreshToken: tokens.refreshToken
                }
            };
        }
        catch (error) {
            if (error instanceof jwt_1.TokenExpiredError) {
                throw new common_1.UnauthorizedException();
            }
            this.logger.error(error);
            return {
                success: true,
                message: "something wen wrong"
            };
        }
    }
    async me(inputSerialNumber, req) {
        const user = await this.usersService.user({ id: req.user.id });
        const serialNumber = await this.usersService.getSerialNumberByUser(user.id);
        if (!serialNumber || serialNumber.serial_number !== inputSerialNumber) {
            throw new common_1.HttpException("User with a different SIM logged in", common_1.HttpStatus.UNAUTHORIZED);
        }
        return {
            success: true,
            data: user
        };
    }
    async verifyOTP(body) {
        const { otp, username } = body;
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
        const { accessToken, refreshToken } = await this.authService.generateAuthToken(payload);
        return {
            success: true,
            data: {
                accessToken,
                refreshToken
            }
        };
    }
    async changePassword(req, body) {
        const { oldPassword, newPassword, confirm } = body;
        if (!oldPassword || !newPassword || !confirm) {
            throw new common_1.HttpException("missing fields", common_1.HttpStatus.BAD_REQUEST);
        }
        const user = await this.usersService.user({ id: req.user.id });
        if (!user) {
            throw new common_1.UnauthorizedException();
        }
        if (newPassword !== confirm) {
            throw new common_1.HttpException("Les mots de passe ne correspondent pas", common_1.HttpStatus.BAD_REQUEST);
        }
        const isOldPasswordValid = this.authService.verifyPassword(oldPassword, user.salt, user.password);
        if (!isOldPasswordValid) {
            throw new common_1.HttpException("Mot de passe incorrect, veuillez réessayer", common_1.HttpStatus.BAD_REQUEST);
        }
        const isNewPasswordValid = this.authService.verifyPassword(newPassword, user.salt, user.password);
        if (isNewPasswordValid) {
            throw new common_1.HttpException("Votre nouveau mot de passe doit être différent de l'ancien", common_1.HttpStatus.BAD_REQUEST);
        }
        const newSalt = crypto.randomBytes(16).toString('hex');
        const hashedNewPassword = this.authService.hashPassword(newPassword, newSalt);
        const updated = await this.usersService.updateUser({ where: { id: user.id }, data: { password: hashedNewPassword, salt: newSalt } });
        return {
            success: true,
            message: "Mot de passe changé avec succès"
        };
    }
};
exports.AuthController = AuthController;
__decorate([
    (0, common_1.Post)('/login'),
    (0, swagger_1.ApiOkResponse)({ type: (xc_response_model_1.XCResponse) }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [auth_request_dto_1.AuthRequestDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "login", null);
__decorate([
    (0, common_1.Post)('/refresh-token'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [refreshTokenRequestDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "refreshToken", null);
__decorate([
    (0, common_1.Get)('/me/:serialNumber'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __param(0, (0, common_1.Param)('serialNumber')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "me", null);
__decorate([
    (0, common_1.Post)('/verifyOTP'),
    (0, swagger_1.ApiOkResponse)({ type: (xc_response_model_1.XCResponse) }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [auth_verify_otp_dto_1.VerifyOtpDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "verifyOTP", null);
__decorate([
    (0, common_1.Post)('/change-password'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, swagger_1.ApiOkResponse)({ type: (xc_response_model_1.XCResponse) }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, change_password_dto_1.ChangePasswordDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "changePassword", null);
exports.AuthController = AuthController = AuthController_1 = __decorate([
    (0, common_1.Controller)('auth'),
    (0, swagger_1.ApiTags)('AuthController'),
    __metadata("design:paramtypes", [auth_service_1.AuthService,
        users_service_1.UsersService,
        jwt_1.JwtService,
        messaging_queue_service_1.MessagingQueueService])
], AuthController);
//# sourceMappingURL=auth.controller.js.map