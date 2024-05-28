import { JwtService } from '@nestjs/jwt';
import { XCResponse } from 'src/xc-response.model';
import { UsersService } from 'src/users/users.service';
import { AuthResponseDto } from './models/auth-response.dto';
import { MessagingQueueService } from 'src/smgs/messaging-queue.service';
export declare class AuthService {
    private readonly usersService;
    private readonly jwtService;
    private readonly smgsService;
    private readonly logger;
    constructor(usersService: UsersService, jwtService: JwtService, smgsService: MessagingQueueService);
    hashPassword: (password: string, salt: string) => string;
    verifyPassword(password: string, salt: string, hashedPassword: string): boolean;
    generateAuthToken(payload: any): Promise<{
        accessToken: string;
        refreshToken: string;
    }>;
    verifyOTP(username: string, otp: string): Promise<XCResponse<AuthResponseDto>>;
    getSerialNumberByUser(userId: string): Promise<void>;
}
