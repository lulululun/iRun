//
//  SportViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SportViewController.h"

@interface SportViewController ()

@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sportStateViewHidden = NO;
    [self.sportStateView setHidden:YES];
    [self mapViewInit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.countdownView countdownWithView:self.view completion:^(BOOL finished) {
        [self.mapView setHidden:NO];
        [self.sportStateView setHidden:NO];
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.sportStateViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewHeight.constant = CURREN_SCREEN_HEIGHT*0.8;
    self.mapViewTop.constant = -CURREN_SCREEN_HEIGHT*0.3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {

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
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = NO;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.sportStateViewBottom.constant = -CURREN_SCREEN_HEIGHT*0.6;
            self.mapViewTop.constant = -20;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.sportStateViewHidden = YES;
        }];
    }
}

- (IBAction)sportStopAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Init

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

@end
