//
//  SportAccumulationView.h
//  iRun
//
//  Created by izhangyb on 16/4/5.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportAccumulationView : UIView

@property (nonatomic, strong) UIView *view;
//@property (strong, nonatomic) IBOutlet UIView *testView;
@property (strong, nonatomic) IBOutlet UILabel *accumulationLabel;
@property (strong, nonatomic) IBOutlet UILabel *accumulationUnits;

- (void)loadViewData:(id)data;

@end
