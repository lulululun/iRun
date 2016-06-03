//
//  SportViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportViewController.h"
#import "SportDataLogic.h"
#import "SportDataDto.h"
#import "SportResultViewController.h"

@interface SportViewController () {
    NSTimer *_sportTimer;
    NSDate *_startSportDate;
    CLLocationDistance distance;
    NSInteger deltaTime;
    CLLocation *oldLocation;
    CLLocation *nowLocation;
    SportDataDto *data;
    CLLocationSpeed maxSpeed;
    
    CLLocationDistance startAltitude;
    CLLocationDistance endAltitude;
    
    NSMutableArray *locationArr;
}

@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sportStateViewHidden = NO;
    [self.sportStateView setHidden:YES];
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    [self mapViewInit];
    [self controlViewInit];
    
    maxSpeed = 0;
    
    UIPanGestureRecognizer *unlockRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(unlockAction:)];
    [self.unlockView addGestureRecognizer:unlockRecognizer];
    
    NSTimer *locationTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(loadLocationDataSource) userInfo:nil repeats:YES];
    NSRunLoop *run = [NSRunLoop currentRunLoop];
    [run addTimer:locationTimer forMode:NSDefaultRunLoopMode];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.countdownView countdownWithView:self.view completion:^(BOOL finished) {
        [self.mapView setHidden:NO];
        [self.sportStateView setHidden:NO];
        
        _startSportDate = [NSDate date];
        
        _sportTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadSportTime:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_sportTimer forMode:NSDefaultRunLoopMode];
    }];
}

// 更新画面约束
- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.sportStateViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewTop.constant = -CURREN_SCREEN_HEIGHT*0.4;
    self.bottomViewHeight.constant = CURREN_SCREEN_HEIGHT*0.2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SportResultViewController *destinationViewController = [segue destinationViewController];
    [destinationViewController setSportType:self.sportType];
    [destinationViewController setData:data];
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    // 获取速度
    CLLocationSpeed moveSpeed = userLocation.location.speed;
    
    if (moveSpeed > maxSpeed) {
        maxSpeed = moveSpeed;
    }
    
    // 获取移动距离
    nowLocation = userLocation.location;
    
    if (moveSpeed > 0) {
        if (oldLocation) {
            distance += [nowLocation distanceFromLocation:oldLocation];
        } else {
            distance = 0;
        }
        
        oldLocation = userLocation.location;
        nowLocation = nil;
    }
    
    if (distance <= 0) {
        startAltitude = userLocation.location.altitude;
        endAltitude = userLocation.location.altitude;
    } else {
        endAltitude = userLocation.location.altitude;
    }

    // 加载运动状态数据
    switch (self.sportType) {
        case SportTypeRun:
            if (distance > 0) {
                [self.sportMainArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
                [self.bottomLeftArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
            }
            
            if (moveSpeed <= 0) {
                [self.sportRightAuxiliaryArg setText:@"--"];
            } else {
                [self.sportRightAuxiliaryArg setText:[NSString stringWithFormat:@"%0.2f", moveSpeed]];
            }
            break;
            
        case SportTypeClimb:
            if (distance > 0) {
                [self.sportLeftAuxiliaryArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
                [self.bottomLeftArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
            }
            
            [self.sportRightAuxiliaryArg setText:[NSString stringWithFormat:@"%0.0f", userLocation.location.altitude]];
            break;
            
        default:
            if (distance > 0) {
                [self.sportMainArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
                [self.bottomLeftArg setText:[NSString stringWithFormat:@"%0.2f", distance/1000]];
            }
            
            if (moveSpeed <= 0) {
                [self.sportRightAuxiliaryArg setText:@"--"];
            } else {
                [self.sportRightAuxiliaryArg setText:[NSString stringWithFormat:@"%0.2f", moveSpeed*3.6]];
            }
            break;
    }
}

- (MAOverlayView*)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay {
    // 自定义定位精度对应的MACircleView
    if (overlay == mapView.userLocationAccuracyCircle) {
        
        MACircleView *accuracyCircleView = [[MACircleView alloc]initWithCircle:overlay];
        accuracyCircleView.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        accuracyCircleView.fillColor =[UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        return accuracyCircleView;
    } else if([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 5.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineView.lineJoinType = kMALineJoinRound;//连接类型
        polylineView.lineCapType = kMALineCapRound;//端点类型
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark - Action

- (void)mapTapAction:(id)sender {
    
    if (self.sportStateViewHidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sportStateViewBottom.constant = 0;
            self.mapViewTop.constant = -CURREN_SCREEN_HEIGHT*0.4;
            [self.bottomView setAlpha:0];
            [self.dataDisplayView setAlpha:1];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = NO;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.sportStateViewBottom.constant = -CURREN_SCREEN_HEIGHT*0.6;
            self.mapViewTop.constant = -64;
            [self.bottomView setAlpha:1];
            [self.dataDisplayView setAlpha:0];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = YES;
        }];
    }
}

- (IBAction)unlockAction:(UIPanGestureRecognizer *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.unlockButtonBottom.constant = 20;
        [self.doubleClickLabel setAlpha:0];
        [self.cameraButton setAlpha:1];
        [self.setting setAlpha:1];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.stopButton setAlpha:1];
    }];
}

- (IBAction)sportStopAction:(id)sender {
    
    if (distance <= 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"运动时间太短，是否结束？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"继续运动" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *stopAction = [UIAlertAction actionWithTitle:@"结束" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [_sportTimer invalidate];
            oldLocation = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:stopAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确定要结束本次运动吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"继续运动" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *stopAction = [UIAlertAction actionWithTitle:@"结束" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [_sportTimer invalidate];
            oldLocation = nil;
            
            data = [[SportDataDto alloc] init];
            [data setSportType:self.sportType];
            [data setStartDate:_startSportDate];
            [data setDistance:[NSNumber numberWithFloat:distance]];
            [data setTimer:[NSNumber numberWithInteger:deltaTime]];
            [data setMaxSpeed:[NSNumber numberWithFloat:maxSpeed/3.6]];
            [data setAltitude:[NSNumber numberWithFloat:endAltitude-startAltitude]];
            
            [data setSportType:self.sportType];
            [data setStartDate:_startSportDate];
            
            NSDate *tempDate = [NSDate date];
            
            NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:tempDate];
            tempDate = [tempDate dateByAddingTimeInterval:interval];
            
            [data setEndDate:tempDate];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [SportDataLogic updateSportData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"toSportResultSegue" sender:self];
                });
            });
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:stopAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

}

- (IBAction)lockAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.unlockButtonBottom.constant = 140;
        [self.doubleClickLabel setAlpha:1];
        [self.cameraButton setAlpha:0];
        [self.setting setAlpha:0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.stopButton setAlpha:0];
    }];
}

#pragma mark - Private Method

- (void)mapViewInit {
    if (self.mapView) {
        [self.mapView setHidden:YES];
        [self.mapView setDelegate:self];
        [self.mapView setShowsCompass:NO];
        [self.mapView setScaleOrigin:CGPointMake(self.mapView.compassOrigin.x, 22.f)];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setShowsScale:NO];
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow];
        [self.mapView setCustomizeUserLocationAccuracyCircleRepresentation:YES];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapAction:)];
        [self.mapView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)controlViewInit {
    switch (self.sportType) {
        case SportTypeRun:
            [self.sportMainArgTip setText:@"距离(公里)"];
            [self.bottomLeftArgTip setText:@"距离(公里)"];
            [self.sportLeftAuxiliaryArgTip setText:@"时长"];
            [self.sportRightAuxiliaryArgTip setText:@"配速(分钟/公里)"];
            
            break;
            
        case SportTypeClimb:
            [self.sportMainArgTip setText:@"时长"];
            [self.sportLeftAuxiliaryArgTip setText:@"距离(公里)"];
            [self.sportRightAuxiliaryArgTip setText:@"海拔(米)"];
            
            break;
            
        default:
            [self.sportMainArgTip setText:@"距离(公里)"];
            [self.sportLeftAuxiliaryArgTip setText:@"时长"];
            [self.sportRightAuxiliaryArgTip setText:@"配速(分钟/公里)"];
            
            break;
    }
}

// 生成计时器
- (void)loadSportTime:(NSTimer *)sender {
    deltaTime = [sender.fireDate timeIntervalSinceDate:_startSportDate];
    NSString *clockStr = [[NSString stringWithFormat:@"%2.ld:%2.ld:%2.ld", deltaTime/3600, (deltaTime%3600)/60, deltaTime%60] stringByReplacingOccurrencesOfString:@" " withString:@"0"];
    
    [self.bottomRightArg setText:clockStr];
    switch (self.sportType) {
        case SportTypeRun:
            [self.sportLeftAuxiliaryArg setText:clockStr];
            break;
            
        case SportTypeClimb:
            [self.sportMainArg setText:clockStr];
            break;
            
        default:
            [self.sportLeftAuxiliaryArg setText:clockStr];
            break;
    }
}

- (void)loadLocationDataSource {
    if (locationArr == nil) {
        locationArr = [[NSMutableArray alloc] init];
    }
    
    [locationArr addObject:nowLocation];
    
    CLLocationCoordinate2D *locations;
    locations = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D)*locationArr.count);
    
    for (int i=0; i<locationArr.count; i++) {
        locations[i] = ((CLLocation *)locationArr[i]).coordinate;
    }
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:locations count:locationArr.count];
    //在地图上添加折线对象
    [self.mapView addOverlay: commonPolyline];
    
    free(locations);
}

@end
