import { PrismaService } from 'src/prisma/prisma.service';
import { UsersService } from 'src/users/users.service';
export declare class StockService {
    private readonly prisma;
    private readonly usersService;
    constructor(prisma: PrismaService, usersService: UsersService);
    getStocks(): Promise<void>;
    getStockByUsers(listOfPos: number[], page: number, isDsa?: boolean, perPage?: number): Promise<import("prisma-pagination").PaginatedResult<{
        msisdn: number;
        user_id: number;
        sim_pack_id: bigint;
        brand_id: number;
        sim: bigint;
        imsi: bigint;
        imported_at: Date;
        updated_at: Date;
        sold_at: Date;
        cutoff_at: Date;
        sold: number;
        cutoff: number;
        isDsa: boolean;
        brand_dsa_id: number;
        offre_dsa_id: number;
    }>>;
}
