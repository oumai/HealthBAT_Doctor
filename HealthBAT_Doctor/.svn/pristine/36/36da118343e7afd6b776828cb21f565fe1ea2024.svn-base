//
//  BATPatientDetailViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATPatientDetailViewController.h"
#import "BATPatientInfoTableViewCell.h"
#import "BATPaitentCustomTableViewCell.h"
#import "BATMyPatientModel.h"
#import "BATPatientContentTableViewCell.h"

@interface BATPatientDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BATPatientItem *patientItem;

@end

@implementation BATPatientDetailViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.patientDetailView.tableView registerClass:[BATPatientInfoTableViewCell class] forCellReuseIdentifier:@"BATPatientInfoTableViewCell"];
    [self.patientDetailView.tableView registerClass:[BATPaitentCustomTableViewCell class] forCellReuseIdentifier:@"BATPaitentCustomTableViewCell"];
    [self.patientDetailView.tableView registerClass:[BATPatientContentTableViewCell class] forCellReuseIdentifier:@"BATPatientContentTableViewCell"];
    [self requestGetPatientDetail];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 65;
    }
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            BATPatientInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATPatientInfoTableViewCell" forIndexPath:indexPath];
            cell.marriageLabel.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self.patientItem) {
                [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.patientItem.PhotoPath] placeholderImage:[UIImage imageNamed:@"personalCenter_defaultAvator"]];
                cell.nameLabel.text = self.patientItem.TrueName;
                cell.ageLabel.text = [NSString stringWithFormat:@"%ld岁",self.patientItem.Age];
                
                
//                WEAK_SELF(self);
                cell.chatRecordBlock = ^(){
//                    STRONG_SELF(self);
                    
//                    KMChatViewController *chatVC = [[KMChatViewController alloc] init];
//                    chatVC.title = self.patientItem.TrueName;
//                    chatVC.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:chatVC animated:YES];
                    
                };
            }
            
            return cell;
            
        } else {
            
            BATPatientContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATPatientContentTableViewCell" forIndexPath:indexPath];
            
            if (self.patientItem) {
                if (indexPath.row == 1) {
                    cell.titleLabel.text = @"手机";
                    cell.contentLabel.text = self.patientItem.PhoneNumber;
                } else if (indexPath.row == 2) {
                    cell.titleLabel.text = @"性别";
                    cell.contentLabel.text = self.patientItem.Sex == 0 ? @"女" : @"男";
                    
                } else if (indexPath.row == 3) {
                    cell.titleLabel.text = @"身份证";
                    cell.contentLabel.text = self.patientItem.IDNumber;
                    
                }
            }
            
            return cell;
            
        }
    }
    
    BATPaitentCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATPaitentCustomTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        cell.titleLabel.text = @"地址";
        cell.contentLabel.text = self.patientItem.ContactAddress.length > 0 ? self.patientItem.ContactAddress : @"无";
    } else if (indexPath.section == 2) {
        cell.titleLabel.text = @"药物过敏史";
        cell.contentLabel.text = self.patientItem.Allergies.length > 0 ? self.patientItem.Allergies : @"无";
    }
    
    return cell;
    
}


#pragma mark - Net
- (void)requestGetPatientDetail
{
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/GetPatientDetail" parameters:@{@"patientID":@(self.patientID)} type:kGET success:^(id responseObject) {
        [self dismissProgress];
        
        self.patientItem = [BATPatientItem mj_objectWithKeyValues:[responseObject objectForKey:@"Data"]];
        
        [self.patientDetailView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.patientDetailView];
    
    WEAK_SELF(self);
    [self.patientDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATPatientDetailView *)patientDetailView
{
    if (_patientDetailView == nil) {
        _patientDetailView = [[BATPatientDetailView alloc] init];
        _patientDetailView.tableView.delegate = self;
        _patientDetailView.tableView.dataSource = self;
        _patientDetailView.tableView.estimatedRowHeight = 100;
    }
    return _patientDetailView;
}

@end
