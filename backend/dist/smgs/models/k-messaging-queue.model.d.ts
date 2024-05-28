import { Model } from 'sequelize-typescript';
export declare class KMessagingQueues extends Model {
    sql_id: number;
    momt: string;
    sender: string;
    receiver: string;
    udhdata: string;
    msgdata: string;
    time: number;
    smsc_id: string;
    service: string;
    account: string;
    id: number;
    sms_type: number;
    mclass: number;
    mwi: number;
    coding: number;
    compress: number;
    validity: number;
    deferred: number;
    dlr_mask: number;
    dlr_url: string;
    pid: number;
    alt_dcs: number;
    rpi: number;
    charset: string;
    boxc_id: string;
    binfo: string;
}
