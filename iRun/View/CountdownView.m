//
//  CountdownView.m
//  iRun
//
//  Created by izhangyb on 16/4/7.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "CountdownView.h"

@implementation CountdownView

- (void)awakeFromNib {
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"CountdownView" owner:self options:nil] lastObject];
    [self addSubview:self.view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)countdownWithView:(UIView *)view completion:(void (^)(BOOL finished))completion {
    
    [UIView animateWithDuration:1 animations:^{
        [self.countdownImageView setAlpha:0];
        self.countdownImageViewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.countdownImageViewWidth.constant = 60;
        [self.countdownImageView setAlpha:1];
        [self.countdownImageView setImage:[UIImage imageNamed:@"icon_sport_countdown_2"]];
        [view layoutIfNeeded];
        
        [UIView animateWithDuration:1 animations:^{
            [self.countdownImageView setAlpha:0];
            self.countdownImageViewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
            [view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            self.countdownImageViewWidth.constant = 60;
            [self.countdownImageView setAlpha:1];
            [self.countdownImageView setImage:[UIImage imageNamed:@"icon_sport_countdown_1"]];
            [view layoutIfNeeded];
            
            [UIView animateWithDuration:1 animations:^{
                [self.countdownImageView setAlpha:0];
                self.countdownImageViewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
                [view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                completion(YES);
            }];
        }];
    }];
    
}

@end
