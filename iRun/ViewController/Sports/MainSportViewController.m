//
//  MainSportViewController.m
//  iRun
//
//  Created by izhangyb on 16/3/31.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "MainSportViewController.h"
#import "MainMenuViewController.h"
#import "SportViewController.h"
#import "UIImage+TintColor.h"
#import "SportHistoryViewController.h"
#import "SportDataLogic.h"
#import "SportDataDto.h"

@interface MainSportViewController () {
    SportTypes sportType;
    int signalType;
}

@end

@implementation MainSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.sportChooseScrollView setDelegate:self];
    [self.startSportButton.layer setCornerRadius:20.f];
    sportType = SportTypeRun;
    
    [self.runView setDelegate:self];
    [self.climbView setDelegate:self];
    [self.bikeView setDelegate:self];
    
    [self loadDataSource];
    
    self.gpsSignalAccuracy = [[UILabel alloc] init];
    [self.gpsSignalAccuracy setFrame:CGRectMake(20, CURREN_SCREEN_HEIGHT - 35.f, 100, 21)];
    [self.gpsSignalAccuracy setTextAlignment:NSTextAlignmentLeft];
    [self.gpsSignalAccuracy setTextColor:[UIColor grayColor]];
    NSMutableAttributedString *gpsText = [[NSMutableAttributedString alloc] initWithString:@"GPS 定位中..."];
    [gpsText addAttribute:(NSString *)NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, gpsText.string.length-4)];
    [self.gpsSignalAccuracy setAttributedText:gpsText];
    [self.gpsSignalAccuracy setFont:[UIFont fontWithName:FONT_NAME size:13]];
    [self.gpsSignalAccuracy sizeToFit];
    [self.view addSubview:self.gpsSignalAccuracy];
    signalType = -1;
    
    [self getGpsSignal];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkPedometer];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if ([USERDEFAULT stringForKey:BROAD_CAST_ID]) {
        BOOL stop = [self.deviceManager stopDataReceiveService];
        if (!stop) {
            NSLog(@"停止接收数据失败");
        }
//        [self.deviceManager deleteMeasureDevice:[USERDEFAULT stringForKey:BROAD_CAST_ID]];
    }
    
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentViewConstraint.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 3;
    self.climbViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.bikeViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CURREN_SCREEN_WIDTH, CURREN_SCREEN_HEIGHT), NO, 1);
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, CURREN_SCREEN_WIDTH, CURREN_SCREEN_HEIGHT) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([segue.identifier isEqualToString:@"toMenuViewControllerSegue"]) {
        UINavigationController *destinationVC = segue.destinationViewController;
        MainMenuViewController *menuVC = destinationVC.viewControllers[0];
        [menuVC setBgImage:snapshot];
        
    } else if([segue.identifier isEqualToString:@"toSportViewControllerSegue"]) {
        SportViewController *sportVC = segue.destinationViewController;
        [sportVC setBgImage:snapshot];
        [sportVC setSportType:sportType];
        
    } else if([segue.identifier isEqualToString:@"toSportHistoryFromMainSport"]) {
        SportHistoryViewController *sportHistoryVC = segue.destinationViewController;
        [sportHistoryVC setBgImage:snapshot];
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.startSportButton setEnabled:NO];
    
    CGFloat pageWidth = scrollView.frame.size.width;
    float currentContentX= scrollView.contentOffset.x ;
    
    if (currentContentX <= pageWidth) {
        float climbAlpha = currentContentX/pageWidth*0.6;
        [self.climbBackgroundImageView setAlpha:climbAlpha];
        [self.runBackgroundImageView setAlpha:0.6-climbAlpha];
        [self.bikeBackgroundImageView setAlpha:0];
    } else {
        float bikeAlpha = (currentContentX/pageWidth-1)*0.6;
        [self.bikeBackgroundImageView setAlpha:bikeAlpha];
        [self.climbBackgroundImageView setAlpha:0.6-bikeAlpha];
        [self.runBackgroundImageView setAlpha:0];
    }
    
    int currentPage = floor((currentContentX - pageWidth / 2) / pageWidth) + 1;
    self.sportPageControl.currentPage = currentPage;
    switch (currentPage) {
        case 0:
            [self.startSportButton setTitle:@"开始跑步" forState:UIControlStateNormal];
            sportType = SportTypeRun;
            break;
        case 1:
            [self.startSportButton setTitle:@"开始爬山" forState:UIControlStateNormal];
            sportType = SportTypeClimb;
            break;
        default:
            [self.startSportButton setTitle:@"开始骑行" forState:UIControlStateNormal];
            sportType = SportTypeBike;
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.startSportButton setEnabled:YES];
}

#pragma mark - SportAccumulationDelegate

- (void)accumulationViewTap:(SportAccumulationView *)view {
//    [self performSegueWithIdentifier:@"toSportHistoryFromMainSport" sender:self];
}

#pragma mark - LSBleDataReceiveDelegate

//接收计步器测量数据
-(void)bleManagerDidReceivePedometerMeasuredData:(LSPedometerData*)data {
    
    [self.runView.accumulationLabel setText:[NSString stringWithFormat:@"%0.2f", self.runView.accumulationLabel.text.floatValue + data.distance/1000.f]];
    
    SportDataDto *dto = [[SportDataDto alloc] init];
    [dto setSportType:SportTypePedometer];
    
    NSDate *date = [NSDate date];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    [dto setEndDate:date];
    [dto setDistance:[NSNumber numberWithFloat:data.distance/1000.0f]];
    [dto setCalorie:[NSNumber numberWithDouble:data.calories]];
    
    [SportDataLogic updatePedemoterData:dto];
    
}

#pragma mark - Action & Private method

// 点击菜单按钮事件
- (IBAction)menuAction:(id)sender {
    [self performSegueWithIdentifier:@"toMenuViewControllerSegue" sender:self];
}

// 点击开始运动按钮事件
- (IBAction)startSportAction:(id)sender {
    
    if (signalType == 0) {
        UIAlertController *alertController;
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续运动" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self performSegueWithIdentifier:@"toSportViewControllerSegue" sender:self];
        }];
        
        alertController = [UIAlertController alertControllerWithTitle:@"定位信息" message:@"GPS信号不好，是否继续运动？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:cancelAction];
        [alertController addAction:continueAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (signalType == -1) {
        UIAlertController *alertController;
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        alertController = [UIAlertController alertControllerWithTitle:@"定位信息" message:@"GPS定位中，请稍后..." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"toSportViewControllerSegue" sender:self];
    }

}

// 加载首页运动数据
- (void)loadDataSource {
    MonthSportDataInfo *dataInfo = [[MonthSportDataInfo alloc] init];
    [SportDataLogic loadMonthData:&dataInfo];
    
    NSMutableDictionary *runDic = [[NSMutableDictionary alloc] init];
    [runDic setValue:dataInfo.runDistanceTip forKey:@"units"];
    [runDic setValue:[NSString stringWithFormat:@"%0.2f", dataInfo.runDistance] forKey:@"accumulation"];
    
    NSMutableDictionary *climbDic = [[NSMutableDictionary alloc] init];
    [climbDic setValue:dataInfo.climbAltitudeTip forKey:@"units"];
    [climbDic setValue:[NSString stringWithFormat:@"%0.2f", dataInfo.climbAltitude] forKey:@"accumulation"];
    
    NSMutableDictionary *bikeDic = [[NSMutableDictionary alloc] init];
    [bikeDic setValue:dataInfo.bikeDistanceTip forKey:@"units"];
    [bikeDic setValue:[NSString stringWithFormat:@"%0.2f", dataInfo.bikeDistance] forKey:@"accumulation"];
    
    [self.runView loadViewData:runDic];
    [self.climbView loadViewData:climbDic];
    [self.bikeView loadViewData:bikeDic];
}

// 检测手环

- (void)checkPedometer {
    if (!self.deviceManager) {
        self.deviceManager = [LSBLEDeviceManager defaultLsBleManager];
    }
    
    if ([USERDEFAULT stringForKey:BROAD_CAST_ID]) {
        LSDeviceInfo *deviceInfo = (LSDeviceInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:[USERDEFAULT objectForKey:LS_DEVICE_INFO]];

        BOOL addDeviceResult = [self.deviceManager addMeasureDevice:deviceInfo];
        
        if (addDeviceResult) {
            [self.deviceManager setIsBluetoothPowerOn:YES];
            [self.deviceManager startDataReceiveService:self];
        } else {
            UIAlertController *alertController;
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [USERDEFAULT removeObjectForKey:BROAD_CAST_ID];
                [USERDEFAULT removeObjectForKey:LS_DEVICE_INFO];
            }];
            
            alertController = [UIAlertController alertControllerWithTitle:@"手环异常" message:@"手环异常解除绑定，请重新扫描绑定" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)getGpsSignal {
    [[AMapLocationServices sharedServices] setApiKey:MAMAP_API_KEY];
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        [self.startSportButton setEnabled:YES];
        NSMutableAttributedString *gpsTextStr;
        
        if (error) {
            signalType = 0;
            
            gpsTextStr = [[NSMutableAttributedString alloc] initWithString:@"GPS 定位失败"];
            [gpsTextStr addAttribute:(NSString *)NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, gpsTextStr.string.length-4)];
        } else {
            
            if (location.horizontalAccuracy < 10 && location.verticalAccuracy < 10) {
                signalType = 2;
                
                gpsTextStr = [[NSMutableAttributedString alloc] initWithString:@"GPS 良好"];
                [gpsTextStr addAttribute:(NSString *)NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, gpsTextStr.string.length-4)];
            } else if ((location.horizontalAccuracy > 20 && location.verticalAccuracy > 20) || (location.horizontalAccuracy + location.verticalAccuracy) > 40) {
                signalType = 0;
                
                gpsTextStr = [[NSMutableAttributedString alloc] initWithString:@"GPS 弱"];
                [gpsTextStr addAttribute:(NSString *)NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, gpsTextStr.string.length-4)];
            } else {
                signalType = 1;
                
                gpsTextStr = [[NSMutableAttributedString alloc] initWithString:@"GPS 中"];
                [gpsTextStr addAttribute:(NSString *)NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, gpsTextStr.string.length-4)];
            }
            
            [self.gpsSignalAccuracy setAttributedText:gpsTextStr];
        }
    }];
    
}

@end
