//
//  SettingViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/15.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingWithSwitchTableViewCell.h"
#import "SettingAgeWeightSexCell.h"
#import "Define.h"
#import "DateUtil.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    
    [self.settingTableView setBackgroundColor:[UIColor clearColor]];
    [self.settingTableView setDelegate:self];
    [self.settingTableView setDataSource:self];
    [self.settingTableView setTableFooterView:[[UIView alloc] init]];
    
    UIEdgeInsets edgeInset = {20, 20, 20, 20};
    
    if ([self.settingTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.settingTableView setSeparatorInset:edgeInset];
    }
    
    if ([self.settingTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.settingTableView setLayoutMargins:edgeInset];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
            
        default:
            return 3;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"爱跑";
            break;
            
        default:
            return @"身体指数";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 22.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, CURREN_SCREEN_WIDTH-20, 22);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = TABLEVIEW_TEXT_COLOR;
    label.font = [UIFont fontWithName:@"Helvetica" size:14];
    label.text = sectionTitle;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 22, CURREN_SCREEN_WIDTH-40, 0.5)];
    [lineView setBackgroundColor:TABLEVIEW_LINE_COLOR];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    [sectionView setBackgroundColor:[UIColor clearColor]];
    [sectionView addSubview:label];
    [sectionView addSubview:lineView];
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, tableView.bounds.size.width, 21)];
    [sectionView setBackgroundColor:[UIColor clearColor]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, CURREN_SCREEN_WIDTH-40, 0.5)];
    [lineView setBackgroundColor:TABLEVIEW_LINE_COLOR];
    [sectionView addSubview:lineView];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *settingCellIndentifier = @"settingCellIndentifier";
    static NSString *bodyIndexCellIndentifier = @"bodyIndexCellIndentifier";
    SettingWithSwitchTableViewCell *settingCell;
    SettingAgeWeightSexCell *bodyIndexCell;
    
    if (indexPath.section == 0) {
        settingCell = [tableView dequeueReusableCellWithIdentifier:settingCellIndentifier];
        
        if (!settingCell) {
            settingCell = (SettingWithSwitchTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"SettingWithSwitchTableViewCell" owner:self options:nil] lastObject];
            [settingCell setBackgroundColor:[UIColor clearColor]];
            [settingCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [settingCell.textLabel setTextColor:[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1]];
        }
        
        switch (indexPath.row) {
            case 0:
                [settingCell.textLabel setText:@"屏幕长亮"];
                break;
                
            default:
                [settingCell.textLabel setText:@"每日提醒"];
                break;
        }
        
        return settingCell;
    } else {
        bodyIndexCell = [tableView dequeueReusableCellWithIdentifier:bodyIndexCellIndentifier];
        
        if (!bodyIndexCell) {
            bodyIndexCell = (SettingAgeWeightSexCell *)[[[NSBundle mainBundle] loadNibNamed:@"SettingAgeWeightSexCell" owner:self options:nil] lastObject];
            [bodyIndexCell setBackgroundColor:[UIColor clearColor]];
            bodyIndexCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [bodyIndexCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [bodyIndexCell.textLabel setTextColor:[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1]];
        }
        
        switch (indexPath.row) {
            case 0:
                [bodyIndexCell.textLabel setText:@"年龄(岁)"];
                if ([USERDEFAULT stringForKey:USER_SETTING_AGE]) {
                    [bodyIndexCell.valueLabel setText:[USERDEFAULT stringForKey:USER_SETTING_AGE]];
                } else {
                    [bodyIndexCell.valueLabel setText:@""];
                }
                break;
                
            case 1:
                [bodyIndexCell.textLabel setText:@"体重(kg)"];
//                if ([USERDEFAULT stringForKey:USER_SETTING_AGE]) {
//                    [bodyIndexCell.valueLabel setText:[USERDEFAULT stringForKey:USER_SETTING_AGE]];
//                } else {
//                    [bodyIndexCell.valueLabel setText:@""];
//                }
                break;
                
            default:
                [bodyIndexCell.textLabel setText:@"性别"];
                
                if ([USERDEFAULT stringForKey:USER_SETTING_SEX]) {
                    [bodyIndexCell.valueLabel setText:[USERDEFAULT stringForKey:USER_SETTING_SEX]];
                } else {
                    [bodyIndexCell.valueLabel setText:@""];
                }

                break;
        }
        
        return bodyIndexCell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0: {
            NSString *title = @"\n\n\n\n";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIDatePicker *inputDatePicker = [[UIDatePicker alloc] init];
            
            [inputDatePicker setMaximumDate:[NSDate date]];
            [inputDatePicker setMinimumDate:[DateUtil getFormattedDateFromStr:@"1900-01-01 00:00:00"]];
            
            if ([USERDEFAULT objectForKey:USER_SETTING_BIRTHDAY] != nil) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSDate *destDate = [dateFormatter dateFromString:[USERDEFAULT objectForKey:USER_SETTING_BIRTHDAY]];
                NSLog(@"USER_SETTING_BIRTHDAY:%@", [USERDEFAULT objectForKey:USER_SETTING_BIRTHDAY]);
                if (destDate != nil) {
                    [inputDatePicker setDate:destDate];
                } else {
                    [inputDatePicker setDate:[NSDate date]];
                }
            } else {
                [inputDatePicker setDate:[NSDate date]];
            }
            
            [inputDatePicker setDatePickerMode:UIDatePickerModeDate];
            [inputDatePicker setFrame:CGRectMake(0, 0, CURREN_SCREEN_WIDTH-20, 100)];
            
            [alertController.view addSubview:inputDatePicker];
            [self presentViewController:alertController animated:YES completion:nil];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *ageStr = [NSString stringWithFormat:@"%lu", (long)[DateUtil ageWithDateOfBirth:inputDatePicker.date]];
                [USERDEFAULT setObject:ageStr forKey:USER_SETTING_AGE];
                [USERDEFAULT setObject:[DateUtil getFormattedStrFromDate:inputDatePicker.date] forKey:USER_SETTING_BIRTHDAY];
                
                [tableView reloadData];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
        }
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"toPedometerVCSegue" sender:self];
            break;
            
        default: {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [USERDEFAULT setObject:@"男" forKey:USER_SETTING_SEX];
                [tableView reloadData];
            }];
            
            UIAlertAction *womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [USERDEFAULT setObject:@"女" forKey:USER_SETTING_SEX];
                [tableView reloadData];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:manAction];
            [alertController addAction:womanAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edgeInset = {20, 20, 20, 20};
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:edgeInset];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:edgeInset];
    }
}

- (IBAction)switchAction:(id)sender {
}

- (IBAction)backToMenuAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
