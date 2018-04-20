//
//  BATSettingViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATSettingViewController.h"
#import "BATChangePasswordViewController.h"
#import "BATOpinionViewController.h"
#import "BATAppDelegate+BATResetLogin.h"

@interface BATSettingViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation BATSettingViewController

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
//    [self.settingView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = UIColorFromHEX(0x333333, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = UIColorFromHEX(0x333333, 1);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    
    [cell setBottomBorderWithColor:UIColorFromHEX(0xe0e0e0, 1) width:SCREEN_WIDTH height:0];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"版本信息";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[Tools getLocalVersion]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"意见反馈";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"修改密码";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        //意见反馈
        
        BATOpinionViewController * opinionVC = [[BATOpinionViewController alloc] init];
        [self.navigationController pushViewController:opinionVC animated:YES];
        
    } else if (indexPath.row == 2) {
        //修改密码
        
        BATChangePasswordViewController *changePasswordVC = [[BATChangePasswordViewController alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:changePasswordVC] animated:YES completion:nil];
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.settingView];
    
    WEAK_SELF(self);
    [self.settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATSettingView *)settingView
{
    if (_settingView == nil) {
        _settingView = [[BATSettingView alloc] init];
        _settingView.tableView.delegate = self;
        _settingView.tableView.dataSource = self;
        
        WEAK_SELF(self);
        _settingView.logoutBlock = ^{
            STRONG_SELF(self);
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate bat_logout];
                
            }];
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        };

    }
    return _settingView;
}

@end
