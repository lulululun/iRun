//
//  PedometerViewController.h
//  iRun
//
//  Created by izhangyb on 16/4/13.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LifesenseBluetooth/LSBLEDeviceManager.h>

typedef struct {
    __unsafe_unretained NSString *deviceId;            //设备ID
    __unsafe_unretained NSString *deviceSn;            //设备SN
    __unsafe_unretained NSString *deviceName;          //设备名称
    __unsafe_unretained NSString *modelNumber;         //设备型号
    __unsafe_unretained NSString *password;            //密码
    __unsafe_unretained NSString *broadcastId;         //广播ID
    __unsafe_unretained NSString *protocolType;        //协议类型
    BOOL preparePair;                                  //是否处于配对状态，不用保存在数据库，只是临时变量
    int deviceType;                                    //设备类型
    int supportDownloadInfoFeature;                    //支持下载用户信息的类型
    int maxUserQuantity;                               //最大用户数
    __unsafe_unretained NSString *softwareVersion;     //软件版本
    __unsafe_unretained NSString *hardwareVersion;     //硬件版本
    __unsafe_unretained NSString *firmwareVersion;     //固件版本
    __unsafe_unretained NSString *manufactureName;     //制造商名称
    __unsafe_unretained NSString *systemId;            //系统ID,暂时无值
    __unsafe_unretained NSString *peripheralIdentifier;//系统蓝牙设备的id,可以唯一表示一个设备
    int deviceUserNumber;
} LSDeviceInfoStruct;

@interface PedometerViewController : UIViewController<LSBlePairingDelegate>

// 背景图（做毛玻璃效果用）
@property (strong, nonatomic) UIImage *bgImage;
// 乐心设备管理
@property (retain, nonatomic) LSBLEDeviceManager *deviceManager;
@property (strong, nonatomic) IBOutlet UIButton *scanAndBundButton;
@property (weak, nonatomic) IBOutlet UIImageView *leftSignalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightSignalImageView;

- (IBAction)backToMenuAction:(id)sender;
- (IBAction)scanAndBindAction:(id)sender;

@end
