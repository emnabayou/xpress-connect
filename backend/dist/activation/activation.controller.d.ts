import { ActivationService } from './activation.service';
import { historiqueDto } from './historique.dto';
import { PaginatedOutputDto } from 'src/helpers/pagination.dto';
export declare class ActivationController {
    private readonly activationService;
    constructor(activationService: ActivationService);
    getRecentHistory(page: number, perPage: number, req: any): Promise<PaginatedOutputDto<historiqueDto>>;
    getOldHistory(page: number, perPage: number, req: any): Promise<PaginatedOutputDto<historiqueDto>>;
}
