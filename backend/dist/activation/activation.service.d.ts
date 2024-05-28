import { PrismaService } from 'src/prisma/prisma.service';
import { historiqueDto } from './historique.dto';
export declare class ActivationService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    startOfMonth(date: Date): Date;
    getRecentOperationActivationByUsers(userId: number, page: number, perPage: number): Promise<import("prisma-pagination").PaginatedResult<{
        id: number;
        user_id: number;
        msisdn: number;
        created_at: Date;
        updated_at: Date;
        status: number;
        text_status: string;
        sim: bigint;
        channel: string;
        piece_identif: string;
        cin_pp: string;
        pays: string;
        dirnum: number;
        brand_id: number;
        offre_id: number;
        isDsa: boolean;
        brand_dsa_id: number;
        isEma: boolean;
        syncBscs: boolean;
        longitude: number;
        latitude: number;
        zone: string;
    }>>;
    getOldOperationActivationByUsers(userId: number, page: number, perPage: number): Promise<import("prisma-pagination").PaginatedResult<historiqueDto>>;
}
