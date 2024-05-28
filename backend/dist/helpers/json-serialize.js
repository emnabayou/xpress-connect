"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const JSONSerialize = (param) => {
    return JSON.parse(JSON.stringify(param, (key, value) => (typeof value === "bigint" ? value.toString() : value)));
};
exports.default = JSONSerialize;
//# sourceMappingURL=json-serialize.js.map