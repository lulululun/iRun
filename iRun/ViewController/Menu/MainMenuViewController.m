//
//  MainMenuViewController.m
//  iRun
//
//  Created by izhangyb on 16/4/8.
//  Copyright © 2016年 izhangyb. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MenuAppLogoTableViewCell.h"
#import "PedometerViewController.h"
#import "Define.h"

@interface MainMenuViewController() {
    NSMutableArray *dataSource;
}

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:self.bgImage]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.menuTableView setBackgroundColor:[UIColor clearColor]];
    [self.menuTableView setDelegate:self];
    [self.menuTableView setDataSource:self];
    [self.menuTableView setTableFooterView:[[UIView alloc] init]];
    
    UIEdgeInsets edgeInset = {20, 20, 20, 20};
    
    if ([self.menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.menuTableView setSeparatorInset:edgeInset];
    }
    
    if ([self.menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.menuTableView setLayoutMargins:edgeInset];
    }
    
    MenuTableViewData setData = {@"icon_menu_setting", @"设置"};
    MenuTableViewData pedmeterData = {@"icon_menu_setting", @"配件"};
    MenuTableViewData recodData = {@"icon_menu_setting", @"运动记录"};
    MenuTableViewData shareData = {@"icon_menu_setting", @"分享"};
    MenuTableViewData aboutData = {@"icon_menu_setting", @"关于"};
    
    dataSource = [[NSMutableArray alloc] init];
    [dataSource addObject:[NSData dataWithBytes:&setData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&pedmeterData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&recodData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&shareData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&aboutData length:sizeof(MenuTableViewData)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     PedometerViewController *pedometerVC = segue.destinationViewController;
     [pedometerVC setBgImage:self.bgImage];
 }


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cellIndentifier";
    static NSString *logoCellIndentifier = @"logoCellIndentifier";
    UITableViewCell *cell;
    MenuAppLogoTableViewCell *logoCell;
    
    if (indexPath.row == 0) {
        logoCell = [tableView dequeueReusableCellWithIdentifier:logoCellIndentifier];
        
        if (!logoCell) {
            logoCell = (MenuAppLogoTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"MenuAppLogoTableViewCell" owner:self options:nil] lastObject];
            [logoCell setBackgroundColor:[UIColor clearColor]];
            [logoCell.appLogo.layer setMasksToBounds:YES];
            [logoCell.appLogo.layer setCornerRadius:15];
            [logoCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return logoCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.textLabel setTextColor:[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1]];
        }
        
        MenuTableViewData cellData;
        [[dataSource objectAtIndex:indexPath.row-1] getBytes:&cellData length:sizeof(MenuTableViewData)];
        
        [cell.imageView setImage:[UIImage imageNamed:cellData.imageName]];
        [cell.textLabel setText:cellData.itemName];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 2:
            [self performSegueWithIdentifier:@"toPedometerVCSegue" sender:self];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CURREN_SCREEN_HEIGHT*0.5;
    } else {
        return 49.f;
    }
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

- (IBAction)closeAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
