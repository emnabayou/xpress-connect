import { KMessagingQueues } from './models/k-messaging-queue.model';
export declare class MessagingQueueService {
    private kmqRepository;
    constructor(kmqRepository: typeof KMessagingQueues);
    findAll(): Promise<KMessagingQueues[]>;
    add(simFrom: string, phone: string, content: string, smscId: string): Promise<KMessagingQueues>;
}
