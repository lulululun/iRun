//
//  BleDeviceInfo.h
//  iRun
//
//  Created by izhangyb on 16/4/27.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BleDeviceInfo : NSObject<NSCoding>

@property(nonatomic,strong)NSString *deviceId;      //设备ID
@property(nonatomic,strong)NSString *deviceSn;      //设备SN
@property(nonatomic,strong)NSString *deviceName;    //设备名称
@property(nonatomic,strong)NSString *modelNumber;   //设备型号
@property(nonatomic,strong)NSString *password;      //密码
@property(nonatomic,strong)NSString *broadcastId;   //广播ID
@property(nonatomic,strong)NSString *protocolType;      //协议类型
@property(nonatomic,strong)NSString *preparePair;                 //是否处于配对状态，不用保存在数据库，只是临时变量
@property(nonatomic,strong)NSString *deviceType;          //设备类型
@property(nonatomic,strong)NSString *supportDownloadInfoFeature;//支持下载用户信息的类型
@property(nonatomic,strong)NSString *maxUserQuantity;          //最大用户数
@property(nonatomic,strong)NSString *softwareVersion;   //软件版本
@property(nonatomic,strong)NSString *hardwareVersion;   //硬件版本
@property(nonatomic,strong)NSString *firmwareVersion;   //固件版本
@property(nonatomic,strong)NSString *manufactureName;   //制造商名称
@property(nonatomic,strong)NSString *systemId;          //系统ID,暂时无值


//new change for version 1.1.1
@property(nonatomic,strong)NSString *peripheralIdentifier;//系统蓝牙设备的id,可以唯一表示一个设备
@property(nonatomic,strong)NSString *deviceUserNumber;

@end
