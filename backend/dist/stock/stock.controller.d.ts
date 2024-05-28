import { UsersService } from 'src/users/users.service';
import { StockService } from './stock.service';
import { msisdn as MsisdnModel } from 'prisma/prisma-client';
import { PaginatedOutputDto } from 'src/helpers/pagination.dto';
export declare class StockController {
    private readonly usersService;
    private readonly stockService;
    constructor(usersService: UsersService, stockService: StockService);
    getStocks(isDsa: string, page: number, req: any): Promise<PaginatedOutputDto<MsisdnModel>>;
}
