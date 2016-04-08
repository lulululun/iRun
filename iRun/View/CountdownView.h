//
//  CountdownView.h
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownView : UIView

@property (nonatomic, strong) UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *countdownImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *countdownImageViewWidth;

- (void)countdownWithView:(UIView *)view completion:(void (^)(BOOL finished))completion;

@end
