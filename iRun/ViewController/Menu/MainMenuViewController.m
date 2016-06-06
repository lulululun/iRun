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
#import "SettingViewController.h"
#import "SportHistoryViewController.h"
#import "ShareViewController.h"
#import "AboutViewController.h"

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
    MenuTableViewData pedmeterData = {@"icon_menu_pedometer", @"配件"};
    MenuTableViewData recodData = {@"icon_menu_history", @"运动记录"};
    MenuTableViewData sendMailData = {@"icon_menu_advertisment", @"意见反馈"};
    MenuTableViewData shareData = {@"icon_menu_share", @"分享"};
    MenuTableViewData aboutData = {@"icon_menu_about", @"关于"};
    
    dataSource = [[NSMutableArray alloc] init];
    [dataSource addObject:[NSData dataWithBytes:&setData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&pedmeterData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&recodData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&sendMailData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&aboutData length:sizeof(MenuTableViewData)]];
    [dataSource addObject:[NSData dataWithBytes:&shareData length:sizeof(MenuTableViewData)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"toSettingViewControllerSegue"]) {
         SettingViewController *settingVC = segue.destinationViewController;
         [settingVC setBgImage:self.bgImage];
         
     } else if([segue.identifier isEqualToString:@"toPedometerVCSegue"]) {
         PedometerViewController *pedometerVC = segue.destinationViewController;
         [pedometerVC setBgImage:self.bgImage];
         
     } else if ([segue.identifier isEqualToString:@"toSportHistoryFromMainMenu"]) {
         SportHistoryViewController *historyVC = segue.destinationViewController;
         [historyVC setBgImage:self.bgImage];
     }
 }


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 1:
            [self performSegueWithIdentifier:@"toSettingViewControllerSegue" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"toPedometerVCSegue" sender:self];
            break;
        
        case 3:
            [self performSegueWithIdentifier:@"toSportHistoryFromMainMenu" sender:self];
            break;
            
        case 4:
            [self displayMailView];
            break;
            
        case 5: {
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            [aboutVC setBgImage:[self getCurrentScreen]];
            [self presentViewController:aboutVC animated:YES completion:nil];
        }
            break;
            
        default: {
            ShareViewController *shareVC = [[ShareViewController alloc] init];
            [shareVC setBgImage:[self getCurrentScreen]];
            [self presentViewController:shareVC animated:YES completion:nil];
        }
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

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    
    NSLog(@"%@", msg);
}

#pragma mark - Action

- (IBAction)closeAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private method

- (void)displayMailView {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见反馈"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"izhangyb@icloud.com"];
    [mailPicker setToRecipients: toRecipients];
    
    //手机系统版本
    NSString *phoneVersion = [NSString stringWithFormat:@"手机系统版本: %@", [[UIDevice currentDevice] systemVersion]];
    
    //手机型号
    NSString *phoneModel = [NSString stringWithFormat:@"手机型号: %@", [[UIDevice currentDevice] model]];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [NSString stringWithFormat:@"当前应用名称: %@", [infoDictionary objectForKey:@"CFBundleDisplayName"]];
    
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [NSString stringWithFormat:@"当前应用软件版本: %@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    
    NSString *emailBody = [NSString stringWithFormat:@"<br><br><br><br><font color='gray'>%@<br>%@<br>%@<br>%@</font>", appCurName, appCurVersion, phoneModel, phoneVersion];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
    
}

- (UIImage *)getCurrentScreen {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CURREN_SCREEN_WIDTH, CURREN_SCREEN_HEIGHT), NO, 1);
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, CURREN_SCREEN_WIDTH, CURREN_SCREEN_HEIGHT) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
