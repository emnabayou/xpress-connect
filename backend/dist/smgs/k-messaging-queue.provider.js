"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.kMessagingQueuesProviders = void 0;
const k_messaging_queue_model_1 = require("./models/k-messaging-queue.model");
exports.kMessagingQueuesProviders = [
    {
        provide: 'KMQ_REPOSITORY',
        useValue: k_messaging_queue_model_1.KMessagingQueues,
    },
];
//# sourceMappingURL=k-messaging-queue.provider.js.map