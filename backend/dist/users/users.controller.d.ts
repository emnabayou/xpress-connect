import { UsersService } from './users.service';
import { fos_user as UserModel } from '@prisma/client';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    getUsers(searchString?: string): Promise<UserModel[]>;
    getUserById(id: string): Promise<UserModel>;
}
