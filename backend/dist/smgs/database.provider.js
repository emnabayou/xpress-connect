"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.databaseProvider = void 0;
const sequelize_typescript_1 = require("sequelize-typescript");
const k_messaging_queue_model_1 = require("./models/k-messaging-queue.model");
exports.databaseProvider = {
    provide: 'SEQUELIZE',
    useFactory: async () => {
        const sequelize = new sequelize_typescript_1.Sequelize({
            dialect: 'mysql',
            host: process.env.SMGS_DB_HOST,
            port: parseInt(process.env.SMGS_DB_PORT),
            username: process.env.SMGS_DB_USERNAME,
            password: process.env.SMGS_DB_PASSWORD,
            database: process.env.SMGS_DB_NAME,
            define: {
                timestamps: false
            }
        });
        sequelize.addModels([k_messaging_queue_model_1.KMessagingQueues]);
        await sequelize.sync();
        return sequelize;
    },
};
//# sourceMappingURL=database.provider.js.map