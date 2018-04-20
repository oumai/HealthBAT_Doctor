//
//  BATDoctorStudioViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioViewController.h"
#import "BATCustomSwitchTableViewCell.h"
#import "BATDoctorStudioMenuTableViewCell.h"
#import "BATMessageCenterViewController.h"
//#import "BATServiceSettingViewController.h"
#import "BATReservationManageViewController.h"
#import "BATDoctorInfoViewController.h"
#import "BATDoctorStudioConsultingRoomViewController.h"
#import "BATMyPatientViewController.h"
#import "BATDoctorDetailModel.h"
#import "WZLBadgeImport.h"
#import "BATDoctorStudioMessageModel.h"
#import "BATDoctorInfoTableViewCell.h"
#import "BATDoctorServiceInfoTableViewCell.h"
//#import "BATOrderManageViewController.h"
#import "BATListeninDoctorController.h"

@interface BATDoctorStudioViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIButton *messageBtn;

@property (nonatomic,strong) BATDoctorDetailModel *doctorDetailModel;

@end

@implementation BATDoctorStudioViewController

- (void)dealloc
{
    _doctorStudioView.tableView.delegate = nil;
    _doctorStudioView.tableView.dataSource = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
//    self.navigationItem.title = @"医生工作室";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.messageBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[Tools imageFromColor:UIColorFromHEX(0xf8f8f8, 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    if (LOGIN_STATION) {
        [self requestGetDoctorDetail];
        
        [self requestGetMessageLst];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:BASE_LINECOLOR]];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.doctorStudioView.tableView registerClass:[BATDoctorStudioMenuTableViewCell class] forCellReuseIdentifier:@"BATDoctorStudioMenuTableViewCell"];
    [self.doctorStudioView.tableView registerClass:[BATDoctorInfoTableViewCell class] forCellReuseIdentifier:@"BATDoctorInfoTableViewCell"];
    [self.doctorStudioView.tableView registerClass:[BATDoctorServiceInfoTableViewCell class] forCellReuseIdentifier:@"BATDoctorServiceInfoTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestGetMessageLst) name:@"DOCTOR_STUDIO_APNS_RELOAD" object:nil];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 1) {
//        return 60;
//    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return 10;
//    }
//    return CGFLOAT_MIN;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.row == 0) {
        BATCustomSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATCustomSwitchTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"在线";
        return cell;

    }*/
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            BATDoctorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorInfoTableViewCell" forIndexPath:indexPath];
//            if (self.doctorDetailModel != nil) {
//                [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"icon-nys"]];
//                cell.doctorNameLabel.text = self.doctorDetailModel.Data.DoctorName;
//                cell.doctorTitleAndHospitalNameLabel.text = [NSString stringWithFormat:@"%@  %@",self.doctorDetailModel.Data.DoctorTitle,self.doctorDetailModel.Data.HospitalName];
////                cell.doctorTitleLabel.text = self.doctorDetailModel.Data.DoctorTitle;
////                cell.hospitalAndDepartmentNameLabel.text = [NSString stringWithFormat:@"%@-%@",self.doctorDetailModel.Data.HospitalName,self.doctorDetailModel.Data.DepartmentName];
//            }
//            
//            return cell;
//        } else if (indexPath.row == 1) {
//            BATDoctorServiceInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorServiceInfoTableViewCell" forIndexPath:indexPath];
//            
//            cell.consultingButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.BeingConsultNum];
//            cell.consultFinishButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.SuccessConsultNum];
//            cell.myPatientButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.PatientNum];
//            
//            cell.consultingButton.doctorServiceInfoButtonBlock = ^{
//                //咨询中
//            };
//            
//            cell.consultFinishButton.doctorServiceInfoButtonBlock = ^{
//                //已咨询
//            };
//            
//            cell.myPatientButton.doctorServiceInfoButtonBlock = ^{
//                //我的患者
//            };
//            
//            return cell;
//        }
//
//    }
    
//    if (indexPath.row == 0) {
//        BATDoctorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorInfoTableViewCell" forIndexPath:indexPath];
//        if (self.doctorDetailModel != nil) {
//            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"home-img-tx_default"]];
//            cell.doctorNameLabel.text = self.doctorDetailModel.Data.DoctorName;
//            cell.doctorTitleAndHospitalNameLabel.text = [NSString stringWithFormat:@"%@  %@",self.doctorDetailModel.Data.DoctorTitle,self.doctorDetailModel.Data.HospitalName];
//            //                cell.doctorTitleLabel.text = self.doctorDetailModel.Data.DoctorTitle;
//            //                cell.hospitalAndDepartmentNameLabel.text = [NSString stringWithFormat:@"%@-%@",self.doctorDetailModel.Data.HospitalName,self.doctorDetailModel.Data.DepartmentName];
//        }
//        
//        return cell;
//    } else if (indexPath.row == 1) {
//        BATDoctorServiceInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorServiceInfoTableViewCell" forIndexPath:indexPath];
//        
//        cell.consultingButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.BeingConsultNum];
//        cell.consultFinishButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.SuccessConsultNum];
//        cell.myPatientButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.PatientNum];
//
//        cell.consultingButton.doctorServiceInfoButtonBlock = ^{
//            //咨询中
//        };
//        
//        cell.consultFinishButton.doctorServiceInfoButtonBlock = ^{
//            //已咨询
//        };
//        
//        cell.myPatientButton.doctorServiceInfoButtonBlock = ^{
//            //我的患者
//        };
//        
//        return cell;
//    }
    
    BATDoctorStudioMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATDoctorStudioMenuTableViewCell" forIndexPath:indexPath];
    WEAK_SELF(self);
    cell.clickMenuAction = ^(NSIndexPath *cellIndexPath){
        STRONG_SELF(self);
        
        if (self.doctorDetailModel != nil) {
            if (cellIndexPath.row == 0) {
                //我的诊室
                
                BATDoctorStudioConsultingRoomViewController *consultingRoomVC = [[BATDoctorStudioConsultingRoomViewController alloc] init];
                consultingRoomVC.doctorID = self.doctorDetailModel.Data.ID;
                consultingRoomVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:consultingRoomVC animated:YES];
                
            } else if (cellIndexPath.row == 1) {                
                //我的患者
                
                BATMyPatientViewController *myPatientVC = [[BATMyPatientViewController alloc] init];
                myPatientVC.DoctorID = self.doctorDetailModel.Data.ID;
                myPatientVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myPatientVC animated:YES];
                
            } else if (cellIndexPath.row == 2) {
                //预约管理
                
                BATReservationManageViewController *reservationManageVC = [[BATReservationManageViewController alloc] init];
                reservationManageVC.DoctorID = self.doctorDetailModel.Data.ID;
                reservationManageVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:reservationManageVC animated:YES];
                
            } else if (cellIndexPath.row == 3) {
                //医生圈
                BATListeninDoctorController *listeninDoctorVC = [[BATListeninDoctorController alloc] init];
                listeninDoctorVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:listeninDoctorVC animated:YES];                
            }
            /*
             else if (cellIndexPath.row == 4) {
             //我的诊室
             
             BATDoctorStudioConsultingRoomViewController *consultingRoomVC = [[BATDoctorStudioConsultingRoomViewController alloc] init];
             consultingRoomVC.doctorID = self.DoctorID;
             [self.navigationController pushViewController:consultingRoomVC animated:YES];
             
             } else if (cellIndexPath.row == 5) {
             //个人信息
             
             BATPersonalInformationViewController *personalInformationVC = [[BATPersonalInformationViewController alloc] init];
             personalInformationVC.doctorID = self.DoctorID;
             personalInformationVC.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:personalInformationVC animated:YES];
             }
             */
        }
    };
    return cell;
}

#pragma mark - Net
#pragma mark - 获取医生信息
- (void)requestGetDoctorDetail
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetDoctorDetail" parameters:nil type:kGET success:^(id responseObject) {
        
        self.doctorDetailModel = [BATDoctorDetailModel mj_objectWithKeyValues:responseObject];
        
        [self.doctorStudioView.headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorDetailModel.Data.DoctorPic] placeholderImage:[UIImage imageNamed:@"home-img-tx_default"]];
        
        self.doctorStudioView.headerView.doctorNameLabel.text = self.doctorDetailModel.Data.DoctorName;
        
        self.doctorStudioView.headerView.doctorTitleAndHospitalNameLabel.text = [NSString stringWithFormat:@"%@  %@",self.doctorDetailModel.Data.DoctorTitle,self.doctorDetailModel.Data.HospitalName];
        
        self.doctorStudioView.headerView.consultingButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.BeingConsultNum];
        self.doctorStudioView.headerView.consultFinishButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.SuccessConsultNum];
        self.doctorStudioView.headerView.myPatientButton.countLabel.text = [NSString stringWithFormat:@"%ld",self.doctorDetailModel.Data.PatientNum];

        
        [self.doctorStudioView.tableView.mj_header endRefreshing];
        [self.doctorStudioView.tableView reloadData];
        
        //保存个人信息
        [[BATRongCloudManager sharedBATRongCloudManager] bat_saveRongCloudCurrentUserInfo:self.doctorDetailModel.Data.ID name:self.doctorDetailModel.Data.DoctorName portraitUri:self.doctorDetailModel.Data.DoctorPic];
                
        //保存医生信息
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DoctorDetail.data"];
        [NSKeyedArchiver archiveRootObject:self.doctorDetailModel toFile:file];
        
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - 获取消息列表
- (void)requestGetMessageLst
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetMessageLst" parameters:@{@"pageIndex":@(0),@"pageSize":@(NSIntegerMax)} type:kGET success:^(id responseObject) {
        
        BATDoctorStudioMessageModel *doctorStudioMessageModel = [BATDoctorStudioMessageModel mj_objectWithKeyValues:responseObject];
        
        for (BATDoctorStudioMessageData *data in doctorStudioMessageModel.Data) {
            if (!data.IsRead) {
                [self.messageBtn.imageView showBadge];
                break;
            }
            
            if (data == doctorStudioMessageModel.Data.lastObject) {
                [self.messageBtn.imageView clearBadge];
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            }
        }
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
    
}


#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.doctorStudioView];
    
    WEAK_SELF(self);
    [self.doctorStudioView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATDoctorStudioView *)doctorStudioView
{
    if (_doctorStudioView == nil) {
        _doctorStudioView = [[BATDoctorStudioView alloc] init];
        _doctorStudioView.tableView.delegate = self;
        _doctorStudioView.tableView.dataSource = self;
        
//        WEAK_SELF(self);
//        _doctorStudioView.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//            STRONG_SELF(self);
//            [self requestGetDoctorDetail];
//        }];
//        
//        _doctorStudioView.tableView.mj_footer.hidden = YES;
        
        WEAK_SELF(self);
        _doctorStudioView.headerView.doctorAvatarClickBlock = ^(){
            STRONG_SELF(self);
            
            if (self.doctorDetailModel != nil) {
                BATDoctorInfoViewController *doctorInfoVC = [[BATDoctorInfoViewController alloc] init];
                doctorInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:doctorInfoVC animated:YES];
            }
        };
    }
    return _doctorStudioView;
}

- (UIButton *)messageBtn
{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom Title:nil titleColor:nil backgroundColor:nil backgroundImage:[UIImage imageNamed:@"ic-xx"] Font:nil];
        [_messageBtn setImage:[UIImage imageNamed:@"ic-xx"] forState:UIControlStateNormal];
        _messageBtn.imageView.badgeCenterOffset = CGPointMake(-4, 5);
        _messageBtn.imageView.clipsToBounds = NO;
        WEAK_SELF(self);
        [_messageBtn bk_whenTapped:^{
            
            STRONG_SELF(self);
            BATMessageCenterViewController *messageCenterVC = [[BATMessageCenterViewController alloc] init];
            messageCenterVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageCenterVC animated:YES];
        }];
    }
    return _messageBtn;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom Title:nil titleColor:nil backgroundColor:nil backgroundImage:[UIImage imageNamed:@"home-ic-wd"] Font:nil];
//        [_leftBtn addTarget:self action:@selector(presentLeftMenuViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [_leftBtn bk_whenTapped:^{
            BATAppDelegate *appDelegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate.sideMenuViewController presentLeftMenuViewController];
        }];
        
    }
    return _leftBtn;
}

@end
