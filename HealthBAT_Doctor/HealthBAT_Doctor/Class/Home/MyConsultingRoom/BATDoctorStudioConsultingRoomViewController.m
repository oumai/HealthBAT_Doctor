//
//  BATDoctorStudioConsultingRoomViewController.m
//  HealthBAT_Pro
//
//  Created by Skybrim on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioConsultingRoomViewController.h"
#import "BATDoctorStudioConsultListViewController.h"

@interface BATDoctorStudioConsultingRoomViewController () <DLTabedSlideViewDelegate>


@end

@implementation BATDoctorStudioConsultingRoomViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"我的诊室";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - DLTabedSlideViewDelegate
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender
{
    return 2;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index
{
    switch (index) {
        case 0: {
            //咨询中
            BATDoctorStudioConsultListViewController *doctorStudioConsultListVC = [[BATDoctorStudioConsultListViewController alloc] init];
            doctorStudioConsultListVC.doctorID = self.doctorID;
            doctorStudioConsultListVC.consultState = BATDoctorStudioConsultState_Consulting;
            return doctorStudioConsultListVC;
        }
        case 1: {
            //已咨询
            BATDoctorStudioConsultListViewController *doctorStudioConsultListVC = [[BATDoctorStudioConsultListViewController alloc] init];
            doctorStudioConsultListVC.doctorID = self.doctorID;
            doctorStudioConsultListVC.consultState = BATDoctorStudioConsultState_ConsultFinish;
            return doctorStudioConsultListVC;
        }

        default:
            return nil;
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.doctorStudioConsultingRoomView];
    
    WEAK_SELF(self);
    [self.doctorStudioConsultingRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATDoctorStudioConsultingRoomView *)doctorStudioConsultingRoomView
{
    if (_doctorStudioConsultingRoomView == nil) {
        _doctorStudioConsultingRoomView = [[BATDoctorStudioConsultingRoomView alloc] init];
        _doctorStudioConsultingRoomView.topSlideView.delegate = self;
        _doctorStudioConsultingRoomView.topSlideView.baseViewController = self;
        _doctorStudioConsultingRoomView.topSlideView.selectedIndex = 0;
    }
    return _doctorStudioConsultingRoomView;
}


@end
