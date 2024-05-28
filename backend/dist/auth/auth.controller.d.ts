import { AuthRequestDto } from './models/auth-request.dto';
import { AuthResponseDto } from './models/auth-response.dto';
import { AuthService } from './auth.service';
import { XCResponse } from 'src/xc-response.model';
import { UsersService } from 'src/users/users.service';
import { VerifyOtpDto } from './models/auth-verify-otp.dto';
import { JwtService } from '@nestjs/jwt';
import { ChangePasswordDto } from './models/change-password.dto';
import { MessagingQueueService } from 'src/smgs/messaging-queue.service';
declare class refreshTokenRequestDto {
    refreshToken: string;
}
export declare class AuthController {
    private readonly authService;
    private readonly usersService;
    private readonly jwtService;
    private readonly smgsService;
    private readonly logger;
    constructor(authService: AuthService, usersService: UsersService, jwtService: JwtService, smgsService: MessagingQueueService);
    login(body: AuthRequestDto): Promise<XCResponse<any>>;
    refreshToken(body: refreshTokenRequestDto): Promise<XCResponse<AuthResponseDto>>;
    me(inputSerialNumber: string, req: any): Promise<XCResponse<any>>;
    verifyOTP(body: VerifyOtpDto): Promise<XCResponse<AuthResponseDto>>;
    changePassword(req: any, body: ChangePasswordDto): Promise<XCResponse<string>>;
}
export {};
