//
//  BATOrderManageViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATOrderManageViewController.h"
#import "BATOrderListViewController.h"

@interface BATOrderManageViewController () <DLTabedSlideViewDelegate>

@end

@implementation BATOrderManageViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"订单管理";
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
    return 3;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index
{
    switch (index) {
        case 0: {
            //家庭医生
            BATOrderListViewController *orderListVC = [[BATOrderListViewController alloc] init];
            orderListVC.doctorID = self.doctorID;
            orderListVC.orderType = BATOrderType_Family;
            return orderListVC;
        }
        case 1: {
            //图文咨询
            BATOrderListViewController *orderListVC = [[BATOrderListViewController alloc] init];
            orderListVC.doctorID = self.doctorID;
            orderListVC.orderType = BATOrderType_TextAndImage;
            return orderListVC;
        }
        case 2: {
            //视频咨询
            BATOrderListViewController *orderListVC = [[BATOrderListViewController alloc] init];
            orderListVC.doctorID = self.doctorID;
            orderListVC.orderType = BATOrderType_Audio;
            return orderListVC;
        }
            
        default:
            return nil;
    }
}

#pragma mark - pageLayout
- (void)pageLayout
{    
    [self.view addSubview:self.orderManageView];
    
    WEAK_SELF(self);
    [self.orderManageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATOrderManageView *)orderManageView
{
    if (_orderManageView == nil) {
        _orderManageView = [[BATOrderManageView alloc] init];
        _orderManageView.topSlideView.delegate = self;
        _orderManageView.topSlideView.baseViewController = self;
        _orderManageView.topSlideView.selectedIndex = 0;
    }
    return _orderManageView;
}

@end
