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
#import "BleDeviceInfo.h"

@interface PedometerViewController ()

@end

@implementation PedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
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
    
    if (!self.deviceManager) {
        self.deviceManager = [LSBLEDeviceManager defaultLsBleManager];
    }
    
    // 如果已经绑定了设备，则将该设备添加到管理对象中；如果添加失败，则回到没有添加设备的状态
    if ([USERDEFAULT stringForKey:BROAD_CAST_ID]) {
        LSDeviceInfo *deviceInfo = (LSDeviceInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:[USERDEFAULT objectForKey:LS_DEVICE_INFO]];
        BOOL addDeviceResult = [self.deviceManager addMeasureDevice:deviceInfo];
        
        if (addDeviceResult) {
            [self.scanAndBundButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        } else {
            [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
            [USERDEFAULT removeObjectForKey:BROAD_CAST_ID];
            [USERDEFAULT removeObjectForKey:LS_DEVICE_INFO];
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
    [self.rightSignalImageView setImage:[[UIImage imageNamed:@"icon_menu_signal_right_three"] imageWithTintColor:[UIColor colorWithRed:0.973 green:0.980 blue:0.976 alpha:1]]];
    [self.leftSignalImageView setImage:[[UIImage imageNamed:@"icon_menu_signal_left_three"] imageWithTintColor:[UIColor colorWithRed:0.973 green:0.980 blue:0.976 alpha:1]]];
    [self.rightSignalImageView stopAnimating];
    [self.leftSignalImageView stopAnimating];
    
    UIAlertController *alertController;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self.scanAndBundButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.263 blue:0.749 alpha:1]];
        [self.scanAndBundButton setEnabled:YES];
        
        if (pairStatus == 1) {
            [self.scanAndBundButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        } else {
            [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
        }
    }];
    
    if (pairStatus == 1) {
        [USERDEFAULT setObject:lsDevice.broadcastId forKey:BROAD_CAST_ID];
        alertController = [UIAlertController alertControllerWithTitle:@"绑定结果" message:@"绑定成功" preferredStyle:UIAlertControllerStyleAlert];
        
        NSData *deviceInfoData = [NSKeyedArchiver archivedDataWithRootObject:[self convertDeviceInfo:lsDevice]];
        
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
        [self.deviceManager searchLsBleDevice:@[@(LS_PEDOMETER)] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice) {
            [self.deviceManager stopSearch];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果" message:@"扫描到手环，是否绑定？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self.scanAndBundButton setEnabled:YES];
                [self.scanAndBundButton setTitle:@"点击扫描" forState:UIControlStateNormal];
                [self.scanAndBundButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.263 blue:0.749 alpha:1]];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.scanAndBundButton setTitle:@"配对中..." forState:UIControlStateNormal];
                [self.deviceManager pairWithLsDeviceInfo:lsDevice pairedDelegate:self];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
}

- (BleDeviceInfo *)convertDeviceInfo:(LSDeviceInfo *)deviceInfo {
    BleDeviceInfo *bleDeviceInfo = [[BleDeviceInfo alloc] init];
    
    bleDeviceInfo.deviceId = deviceInfo.deviceId;
    bleDeviceInfo.deviceSn = deviceInfo.deviceSn;
    bleDeviceInfo.deviceName = deviceInfo.deviceName;
    bleDeviceInfo.modelNumber = deviceInfo.modelNumber;
    bleDeviceInfo.password = deviceInfo.password;
    bleDeviceInfo.broadcastId = deviceInfo.broadcastId;
    bleDeviceInfo.protocolType = deviceInfo.protocolType;
    bleDeviceInfo.preparePair = [NSString stringWithFormat:@"%d", deviceInfo.preparePair?1:0];
    bleDeviceInfo.deviceType = [NSString stringWithFormat:@"%d", deviceInfo.deviceType];
    bleDeviceInfo.supportDownloadInfoFeature = [NSString stringWithFormat:@"%ld", deviceInfo.supportDownloadInfoFeature];
    bleDeviceInfo.maxUserQuantity = [NSString stringWithFormat:@"%ld", deviceInfo.maxUserQuantity];
    bleDeviceInfo.softwareVersion = deviceInfo.softwareVersion;
    bleDeviceInfo.hardwareVersion = deviceInfo.hardwareVersion;
    bleDeviceInfo.firmwareVersion = deviceInfo.firmwareVersion;
    bleDeviceInfo.manufactureName = deviceInfo.manufactureName;
    bleDeviceInfo.systemId = deviceInfo.systemId;
    bleDeviceInfo.peripheralIdentifier = deviceInfo.peripheralIdentifier;
    bleDeviceInfo.deviceUserNumber = [NSString stringWithFormat:@"%ld", deviceInfo.deviceUserNumber];
    
    return bleDeviceInfo;
}

@end
