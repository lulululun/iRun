//
//  SportViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportViewController.h"

@interface SportViewController () {
    NSTimer *_sportTimer;
    NSDate *_startSportDate;
    CLLocationDistance altitude;
}

@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.sportType == SportTypeClimb) {
        altitude = 0;
    }
    
    self.sportStateViewHidden = NO;
    [self.sportStateView setHidden:YES];
    [self mapViewInit];
    [self controlViewInit];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.countdownView countdownWithView:self.view completion:^(BOOL finished) {
        [self.mapView setHidden:NO];
        [self.sportStateView setHidden:NO];
        
        [self loadSportData];
        
        _startSportDate = [NSDate date];
        
        _sportTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadSportTime:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_sportTimer forMode:NSDefaultRunLoopMode];
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.sportStateViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewTop.constant = -CURREN_SCREEN_HEIGHT*0.3;
    self.bottomViewHeight.constant = CURREN_SCREEN_HEIGHT*0.2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    CLLocationSpeed moveSpeed = userLocation.location.speed;
    
    switch (self.sportType) {
        case SportTypeRun: {
            if (moveSpeed <= 0) {
                [self.sportRightAuxiliaryArg setText:@"--"];
            } else {
                [self.sportRightAuxiliaryArg setText:[NSString stringWithFormat:@"%0.2f", moveSpeed*60]];
            }
        }
            break;
            
        case SportTypeClimb: {
            [self.sportRightAuxiliaryArg setText:[NSString stringWithFormat:@"%0.0f", userLocation.location.altitude]];
            NSLog(@"altitude:%@", [NSString stringWithFormat:@"%0.0f", userLocation.location.altitude]);
        }
            break;
            
        default:
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
    }   
    
    return nil;
}

#pragma mark - Action

- (void)mapTapAction:(id)sender {
    
    if (self.sportStateViewHidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sportStateViewBottom.constant = 0;
            self.mapViewTop.constant = -CURREN_SCREEN_HEIGHT*0.3;
            [self.bottomView setAlpha:0];
            [self.dataDisplayView setAlpha:1];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = NO;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.sportStateViewBottom.constant = -CURREN_SCREEN_HEIGHT*0.6;
            self.mapViewTop.constant = -20;
            [self.bottomView setAlpha:1];
            [self.dataDisplayView setAlpha:0];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = YES;
        }];
    }
}

- (IBAction)sportStopAction:(id)sender {
    [_sportTimer invalidate];
    [self dismissViewControllerAnimated:NO completion:nil];
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
        
        //#ifdef iOS9
        //        self.mapView.pausesLocationUpdatesAutomatically = NO;
        //        self.mapView.allowsBackgroundLocationUpdates = YES;
        //#endif
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapAction:)];
        [self.mapView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)controlViewInit {
    switch (self.sportType) {
        case SportTypeRun:
            [self.sportMainArgTip setText:@"距离(公里)"];
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
            [self.sportRightAuxiliaryArgTip setText:@"配速(公里/时)"];
            
            break;
    }
}

- (void)loadSportData {
    switch (self.sportType) {
        case SportTypeRun:
            break;
            
        case SportTypeClimb:
            break;
            
        default:
            break;
    }
}

// 生成计时器
- (void)loadSportTime:(NSTimer *)sender {
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_startSportDate];
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

@end
