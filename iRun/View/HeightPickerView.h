//
//  HeightPickerView.h
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeightPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

- (void)setCurrentValue:(NSString *)currentValue;

- (NSString *)getSelectedValue;

@end
