//
//  BATReservationManageViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATReservationManageViewController.h"
#import "BATScheduleModel.h"

@interface BATReservationManageViewController ()

@property (nonatomic,strong) BATScheduleModel *scheduleModel;

@end

@implementation BATReservationManageViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"预约管理";
    
    [self pageLayout];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(0, 0, 60, 40)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = saveBarButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestGetSchedule];
    
//    [self.reservationManageView configrationData:@{
//                                                   @"weeks":@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"],
//                                                   @"times":@[@"08:00",@"09:00",@"10:00",@"11:00",@"12:00"],
//                                                   }];
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

#pragma mark - Action
- (void)saveBtnAction
{
    if (self.reservationManageView.saveData.count > 0) {
        
        [self requestSetSchedule];
    }

}

#pragma mark - Net
- (void)requestGetSchedule
{
    [self showProgress];
    [HTTPTool requestWithURLString:@"/api/Doctor/GetSchedule" parameters:@{@"doctorId":self.DoctorID} type:kGET success:^(id responseObject) {
        [self dismissProgress];
        
        self.scheduleModel = [BATScheduleModel mj_objectWithKeyValues:responseObject];
        
        [self.reservationManageView configrationData:self.scheduleModel];
        
    } failure:^(NSError *error) {
        [self dismissProgress];
    }];
}

- (void)requestSetSchedule
{
    [self showProgress];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (BATScheduleItem *item in self.reservationManageView.saveData) {
        [array addObject:@{@"ScheduleID":item.ScheduleID,@"YueYueMax":@(item.YueYueMax)}];
    }
    
    [HTTPTool requestWithURLString:@"/api/Doctor/SetSchedule" parameters:array type:kPOST success:^(id responseObject) {        
        [self showSuccessWithText:@"保存成功"];

    } failure:^(NSError *error) {
        [self dismissProgress];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.reservationManageView];
    
    WEAK_SELF(self);
    [self.reservationManageView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATReservationManageView *)reservationManageView
{
    if (_reservationManageView == nil) {
        _reservationManageView = [[BATReservationManageView alloc] init];
    }
    return _reservationManageView;
}

@end
