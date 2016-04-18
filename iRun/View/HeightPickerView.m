//
//  HeightPickerView.m
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "HeightPickerView.h"

@interface HeightPickerView() {
    NSMutableArray *meterArray;
    NSMutableArray *decimeterArray;
    NSMutableArray *centimeterArray;
    UIPickerView *weightPicker;
}

@end

@implementation HeightPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        weightPicker = [[UIPickerView alloc] init];
        [weightPicker setFrame:frame];
        [weightPicker setDelegate:self];
        [weightPicker setDataSource:self];
        
        meterArray = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", nil];
        decimeterArray = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
        centimeterArray = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
        [self addSubview:weightPicker];
    }
    
    return self;
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 3;
            break;
            
        default:
            return 10;
            break;
    }
}

#pragma mark - UIPickerViewDelegate

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str;
    
    switch (component) {
        case 0:
            str = (NSString *)[meterArray objectAtIndex:row];
            break;
            
        case 1:
            str = (NSString *)[decimeterArray objectAtIndex:row];
            break;
            
        default:
            str = (NSString *)[centimeterArray objectAtIndex:row];
            break;
    }
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, attributedStr.length)];
    
    return attributedStr;
}// NS_AVAILABLE_IOS(6_0)

- (void)setCurrentValue:(NSString *)currentValue {
    [weightPicker selectRow:[currentValue substringWithRange:NSMakeRange(0, 1)].intValue inComponent:0 animated:YES];
    [weightPicker selectRow:[currentValue substringWithRange:NSMakeRange(1, 1)].intValue inComponent:1 animated:YES];
    [weightPicker selectRow:[currentValue substringWithRange:NSMakeRange(2, 1)].intValue inComponent:2 animated:YES];
}

- (NSString *)getSelectedValue {
    NSString *selectedValue = [NSString stringWithFormat:@"%ld%ld%ld", [weightPicker selectedRowInComponent:0], [weightPicker selectedRowInComponent:1], [weightPicker selectedRowInComponent:2]];
    
    return selectedValue;
}

@end
