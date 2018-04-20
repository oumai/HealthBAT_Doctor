//
//  BATMeViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATMeViewController.h"
#import "BATMeTableViewCell.h"
#import "BATDoctorInfoViewController.h"
#import "BATMyAccountViewController.h"
#import "BATServiceSettingViewController.h"
#import "BATDoctorDetailModel.h"
#import "BATSettingViewController.h"
#import "BATOrderManageViewController.h"

@interface BATMeViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation BATMeViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    [self pageLayout];
    self.title = @"我的";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.meView.tableView registerClass:[BATMeTableViewCell class] forCellReuseIdentifier:@"BATMeTableViewCell"];
    
    BATDoctorDetailModel *doctorDetailModel = DoctorDetail_INFO;
    
    [self.meView.headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"home-img-tx_default"]];
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
//    if (section == 0) {
//        return 4;
//    }
    return 4;
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
    BATMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATMeTableViewCell" forIndexPath:indexPath];
    
//    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.iconImageView.image = [UIImage imageNamed:@"Personal-ic-wdzh"];
            cell.titleLabel.text = @"我的账户";
        }
//        else if (indexPath.row == 1) {
//            cell.iconImageView.image = [UIImage imageNamed:@"Personal-ic-wdewm"];
//            cell.titleLabel.text = @"我的二维码";
//        }
        else if (indexPath.row == 1) {
            cell.iconImageView.image = [UIImage imageNamed:@"Personal-fwsz"];
            cell.titleLabel.text = @"服务设置";
        } else if (indexPath.row == 2) {
            cell.iconImageView.image = [UIImage imageNamed:@"Personal-ic-ddgl"];
            cell.titleLabel.text = @"订单管理";
        } else if (indexPath.row == 3) {
            cell.iconImageView.image = [UIImage imageNamed:@"Personal-ic-sz"];
            cell.titleLabel.text = @"设置";
        }
//    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            cell.iconImageView.image = [UIImage imageNamed:@"ic-sz"];
//            cell.titleLabel.text = @"设置";
//        }
//    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //我的账户
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该功能开发中" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                
            }];
        }
//        else if (indexPath.row == 1) {
//            //我的二维码
//            
//        }
        else if (indexPath.row == 1) {
            //服务设置
            BATDoctorDetailModel *doctorDetailModel = DoctorDetail_INFO;
            
            BATServiceSettingViewController *serviceSettingVC = [[BATServiceSettingViewController alloc] init];
            serviceSettingVC.DoctorID = doctorDetailModel.Data.ID;
            serviceSettingVC.hidesBottomBarWhenPushed = YES;
            
            UINavigationController *navVC = (UINavigationController *)self.sideMenuViewController.contentViewController;
            
            [navVC pushViewController:serviceSettingVC animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if (indexPath.row == 2) {
            //订单管理
            
            BATDoctorDetailModel *doctorDetailModel = DoctorDetail_INFO;
            
            BATOrderManageViewController *orderManageVC = [[BATOrderManageViewController alloc] init];
            orderManageVC.doctorID = doctorDetailModel.Data.ID;
            orderManageVC.hidesBottomBarWhenPushed = YES;
            
            UINavigationController *navVC = (UINavigationController *)self.sideMenuViewController.contentViewController;
            
            [navVC pushViewController:orderManageVC animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        } else if (indexPath.row == 3) {
            //设置
            BATSettingViewController *settingVC = [[BATSettingViewController alloc] init];
            settingVC.hidesBottomBarWhenPushed = YES;
            
            UINavigationController *navVC = (UINavigationController *)self.sideMenuViewController.contentViewController;
            
            [navVC pushViewController:settingVC animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
        }
//    } else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            //设置
//            BATSettingViewController *settingVC = [[BATSettingViewController alloc] init];
//            settingVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:settingVC animated:YES];
//        }
//    }
}

#pragma mark - Action
#pragma mark - 刷新头像
- (void)refreshAvatar
{
    BATDoctorDetailModel *doctorDetailModel = DoctorDetail_INFO;
    
    [self.meView.headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"home-img-tx_default"]];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.meView];
    
    WEAK_SELF(self);
    [self.meView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATMeView *)meView
{
    if (_meView == nil) {
        _meView = [[BATMeView alloc] init];
        _meView.tableView.delegate = self;
        _meView.tableView.dataSource = self;
        WEAK_SELF(self);
        _meView.headerView.avatarBlock = ^{
            STRONG_SELF(self);
            
            //医生信息
            BATDoctorInfoViewController *doctorInfoVC = [[BATDoctorInfoViewController alloc] init];
            doctorInfoVC.hidesBottomBarWhenPushed = YES;
            
            UINavigationController *navVC = (UINavigationController *)self.sideMenuViewController.contentViewController;
            
            [navVC pushViewController:doctorInfoVC animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            

        };
    }
    return _meView;
}


@end
