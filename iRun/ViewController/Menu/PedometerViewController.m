//
//  PedometerViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/13.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "PedometerViewController.h"
#import "UIImage+TintColor.h"
#import "Define.h"

@interface PedometerViewController ()

@end

@implementation PedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.scanAndBundButton.layer setMasksToBounds:YES];
    [self.scanAndBundButton.layer setCornerRadius:17];
    
    [self.rightSignalImageView setImage:[[UIImage imageNamed:@"icon_menu_signal_right_three"] imageWithTintColor:[UIColor colorWithRed:0.973 green:0.980 blue:0.976 alpha:1]]];
    [self.leftSignalImageView setImage:[[UIImage imageNamed:@"icon_menu_signal_left_three"] imageWithTintColor:[UIColor colorWithRed:0.973 green:0.980 blue:0.976 alpha:1]]];
    
    UIColor *animationImageColor = [UIColor colorWithRed:0.620 green:0.863 blue:0.922 alpha:1];
    // 信号动画
    [self.leftSignalImageView setAnimationImages:[NSArray arrayWithObjects:
                                                 [[UIImage imageNamed:@"icon_menu_signal_left_one"]imageWithTintColor:animationImageColor],
                                                 [[UIImage imageNamed:@"icon_menu_signal_left_two"] imageWithTintColor:animationImageColor],
                                                  [[UIImage imageNamed:@"icon_menu_signal_left_three"]imageWithTintColor:animationImageColor],
                                                 [[UIImage imageNamed:@"icon_menu_signal_none"] imageWithTintColor:animationImageColor],nil]];
    [self.leftSignalImageView setAnimationDuration:1];
    [self.leftSignalImageView setAnimationRepeatCount:0];
    
    [self.rightSignalImageView setAnimationImages:[NSArray arrayWithObjects:
                                                  [[UIImage imageNamed:@"icon_menu_signal_right_one"] imageWithTintColor:animationImageColor],
                                                  [[UIImage imageNamed:@"icon_menu_signal_right_two"] imageWithTintColor:animationImageColor],
                                                  [[UIImage imageNamed:@"icon_menu_signal_right_three"] imageWithTintColor:animationImageColor],
                                                  [[UIImage imageNamed:@"icon_menu_signal_none"] imageWithTintColor:animationImageColor], nil]];
    [self.rightSignalImageView setAnimationDuration:1];
    [self.rightSignalImageView setAnimationRepeatCount:0];
    
    self.deviceManager = [LSBLEDeviceManager defaultLsBleManager];
    
    // 如果已经绑定了设备，则将该设备添加到管理对象中；如果添加失败，则回到没有添加设备的状态
    if ([USERDEFAULT stringForKey:BROAD_CAST_ID]) {
        BOOL addDeviceResult = [self.deviceManager addMeasureDevice:[self convertStruct:[USERDEFAULT objectForKey:LS_DEVICE_INFO]]];
        
        if (addDeviceResult) {
            [self.scanAndBundButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        } else {
            [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
            [USERDEFAULT removeObjectForKey:BROAD_CAST_ID];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - LSBlePairingDelegate

- (void)bleManagerDidDiscoverUserList:(NSDictionary *)userlist {
    NSLog(@"%@", userlist);
}

- (void)bleManagerDidDiscoveredDeviceInfo:(LSDeviceInfo *)deviceInfo {
    NSLog(@"%@", deviceInfo);
}

- (void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(int)pairStatus {
    UIAlertController *alertController;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (pairStatus == 1) {
            [self.scanAndBundButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.263 blue:0.749 alpha:1]];
            [self.scanAndBundButton setTitle:@"解除绑定" forState:UIControlStateNormal];
            [self.scanAndBundButton setEnabled:YES];
        } else {
            [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
        }
    }];
    
    if (pairStatus == 1) {
        [USERDEFAULT setObject:lsDevice.broadcastId forKey:BROAD_CAST_ID];
        alertController = [UIAlertController alertControllerWithTitle:@"绑定结果" message:@"绑定成功" preferredStyle:UIAlertControllerStyleAlert];
        
        LSDeviceInfoStruct deviceInfo = {lsDevice.deviceId, lsDevice.deviceSn, lsDevice.deviceName, lsDevice.modelNumber, lsDevice.password, lsDevice.broadcastId, lsDevice.protocolType, lsDevice.preparePair, lsDevice.deviceType, lsDevice.supportDownloadInfoFeature, lsDevice.maxUserQuantity, lsDevice.softwareVersion, lsDevice.hardwareVersion, lsDevice.firmwareVersion, lsDevice.manufactureName, lsDevice.systemId, lsDevice.peripheralIdentifier, lsDevice.deviceUserNumber};
        NSData *deviceInfoData = [NSData dataWithBytes:&deviceInfo length:sizeof(LSDeviceInfoStruct)];
        [USERDEFAULT setObject:deviceInfoData forKey:LS_DEVICE_INFO];
        
        [self.deviceManager addMeasureDevice:lsDevice];
    } else {
        alertController = [UIAlertController alertControllerWithTitle:@"绑定结果" message:@"绑定失败，请重新扫描绑定" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Action

- (IBAction)backToMenuAction:(id)sender {
    [self.deviceManager stopSearch];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scanAndBindAction:(id)sender {
    
    if ([USERDEFAULT stringForKey:BROAD_CAST_ID]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认操作" message:@"确定解绑手环吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.deviceManager deleteMeasureDevice:[USERDEFAULT stringForKey:BROAD_CAST_ID]];
            [USERDEFAULT removeObjectForKey:BROAD_CAST_ID];
            [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [self.scanAndBundButton setEnabled:NO];
        [self.scanAndBundButton setTitle:@"扫描中..." forState:UIControlStateNormal];
        [self.scanAndBundButton setBackgroundColor:[UIColor lightGrayColor]];
        
        [self.rightSignalImageView startAnimating];
        [self.leftSignalImageView startAnimating];
//        [self.deviceManager searchLsBleDevice:@[@(LS_PEDOMETER)] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice) {
//            [self.deviceManager stopSearch];
//            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"扫描到手环，是否绑定？" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                [self.scanAndBundButton setEnabled:YES];
//                [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
//                [self.scanAndBundButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.263 blue:0.749 alpha:1]];
//            }];
//            
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                [self.scanAndBundButton setTitle:@"配对中..." forState:UIControlStateNormal];
//                [self.deviceManager pairWithLsDeviceInfo:lsDevice pairedDelegate:self];
//            }];
//            
//            [alertController addAction:cancelAction];
//            [alertController addAction:okAction];
//            
//            [self presentViewController:alertController animated:YES completion:nil];
//        }];
    }
}

- (LSDeviceInfo *)convertStruct:(NSData *)deviceInfoData {
    LSDeviceInfo *deviceInfo = [[LSDeviceInfo alloc] init];
    LSDeviceInfoStruct deviceInfoStruct;
    
    [deviceInfoData getBytes:&deviceInfoStruct length:sizeof(LSDeviceInfoStruct)];
    
    deviceInfo.deviceId = deviceInfoStruct.deviceId;
    deviceInfo.deviceSn = deviceInfoStruct.deviceSn;
    deviceInfo.deviceName = deviceInfoStruct.deviceName;
    deviceInfo.modelNumber = deviceInfoStruct.modelNumber;
    deviceInfo.password = deviceInfoStruct.password;
    deviceInfo.broadcastId = deviceInfoStruct.broadcastId;
    deviceInfo.protocolType = deviceInfoStruct.protocolType;
    deviceInfo.preparePair = deviceInfoStruct.preparePair;
    deviceInfo.deviceType = deviceInfoStruct.deviceType;
    deviceInfo.supportDownloadInfoFeature = deviceInfoStruct.supportDownloadInfoFeature;
    deviceInfo.maxUserQuantity = deviceInfoStruct.maxUserQuantity;
    deviceInfo.softwareVersion = deviceInfoStruct.softwareVersion;
    deviceInfo.hardwareVersion = deviceInfoStruct.hardwareVersion;
    deviceInfo.firmwareVersion = deviceInfoStruct.firmwareVersion;
    deviceInfo.manufactureName = deviceInfoStruct.manufactureName;
    deviceInfo.systemId = deviceInfoStruct.systemId;
    deviceInfo.peripheralIdentifier = deviceInfoStruct.peripheralIdentifier;
    deviceInfo.deviceUserNumber = deviceInfoStruct.deviceUserNumber;
    
    return deviceInfo;
}

@end
