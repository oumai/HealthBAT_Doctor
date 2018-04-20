//
//  BATServiceSettingViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATServiceSettingViewController.h"
#import "BATFeeTableViewCell.h"
#import "BATCustomSwitchTableViewCell.h"
#import "BATServiceTableViewCell.h"
#import "BATServiceSettingModel.h"

@interface BATServiceSettingViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BATServiceSettingModel *serviceSettingModel;

@end

@implementation BATServiceSettingViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"服务设置";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.serviceSettingView.tableView registerClass:[BATFeeTableViewCell class] forCellReuseIdentifier:@"BATFeeTableViewCell"];
    [self.serviceSettingView.tableView registerClass:[BATCustomSwitchTableViewCell class] forCellReuseIdentifier:@"BATCustomSwitchTableViewCell"];
    [self.serviceSettingView.tableView registerClass:[BATServiceTableViewCell class] forCellReuseIdentifier:@"BATServiceTableViewCell"];
    
    [self initData];
    
    [self requestGetServiceSetting];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.serviceSettingModel.Data.IsVideoConsult ? 2 : 1;
    } else if (section == 1) {
        return self.serviceSettingModel.Data.IsVoiceConsult ? 2 : 1;
    } else if (section == 2) {
        return self.serviceSettingModel.Data.IsWordConsult ? 2 : 1;
    }
    return self.serviceSettingModel.Data.IsFamilyDoctor ? 7 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }
    
    if (indexPath.section == 3) {
        
        if (indexPath.row == 6) {
            return 100;
        }
        
    }
    return 46;
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

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        BATCustomSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATCustomSwitchTableViewCell" forIndexPath:indexPath];
        
        
        [cell setBottomBorderWithColor:UIColorFromHEX(0xeeeeee, 1) width:SCREEN_WIDTH height:0.5 leftOffset:10 rightOffset:10];
        
        cell.switchOn.hidden = NO;
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"视频咨询";
            cell.switchOn.on = self.serviceSettingModel.Data.IsVideoConsult;
            
            WEAK_SELF(self);
            cell.switchAction = ^(BOOL flag) {
                STRONG_SELF(self);
                self.serviceSettingModel.Data.IsVideoConsult = flag;
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        } else if (indexPath.section == 1) {
            
            cell.titleLabel.text = @"语音咨询";
            cell.switchOn.on = self.serviceSettingModel.Data.IsVoiceConsult;
            
            WEAK_SELF(self);
            cell.switchAction = ^(BOOL flag) {
                STRONG_SELF(self);
                self.serviceSettingModel.Data.IsVoiceConsult = flag;
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
        } else if (indexPath.section == 2) {
            
            cell.titleLabel.text = @"图文咨询";
            cell.switchOn.on = self.serviceSettingModel.Data.IsWordConsult;
            
            WEAK_SELF(self);
            cell.switchAction = ^(BOOL flag) {
                STRONG_SELF(self);
                self.serviceSettingModel.Data.IsWordConsult = flag;
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
        } else if (indexPath.section == 3) {
            
            cell.titleLabel.text = @"家庭医生";
            cell.switchOn.on = self.serviceSettingModel.Data.IsFamilyDoctor;
            
            WEAK_SELF(self);
            cell.switchAction = ^(BOOL flag) {
                STRONG_SELF(self);
                self.serviceSettingModel.Data.IsFamilyDoctor = flag;
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
        }
//        else if (indexPath.section == 4) {
//            
//            if (indexPath.row == 5) {
//                cell.titleLabel.text = @"提供服务";
//                cell.switchOn.hidden = YES;
//            }
//            
//        }
        

        
        return cell;
    } else {
        
//        if (indexPath.section == 4) {
//            //提供服务
//            BATServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATServiceTableViewCell" forIndexPath:indexPath];
//            
//            if (self.serviceSettingModel.Data.FamilyServiceList.count > 0) {
//                [cell configData:self.serviceSettingModel];
//            }
//            
//            WEAK_SELF(self);
//            cell.familyServiceClick = ^(NSInteger index,NSString *key,BOOL value){
//                STRONG_SELF(self);
//                BATFamilyServiceItem *serviceItem = self.serviceSettingModel.Data.FamilyServiceList[index];
//                if ([serviceItem.TKey isEqualToString:key]) {
//                    serviceItem.TValue = value;
//                }
//                
//                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
//
//            };
//            
//            return cell;
//        }
        
        if (indexPath.section == 3) {
            if (indexPath.row == 5) {
                
                BATCustomSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATCustomSwitchTableViewCell" forIndexPath:indexPath];
                
                [cell setTopBorderWithColor:UIColorFromHEX(0xeeeeee, 1) width:SCREEN_WIDTH height:0];
                [cell setBottomBorderWithColor:UIColorFromHEX(0xeeeeee, 1) width:SCREEN_WIDTH height:0];
                
                cell.titleLabel.text = @"提供服务";
                cell.switchOn.hidden = YES;
                
                return cell;
                
            } else if (indexPath.row == 6) {
                
                //提供服务
                BATServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATServiceTableViewCell" forIndexPath:indexPath];
                
                if (self.serviceSettingModel.Data.FamilyServiceList.count > 0) {
                    [cell configData:self.serviceSettingModel];
                }
                
                WEAK_SELF(self);
                cell.familyServiceClick = ^(NSInteger index,NSString *key,BOOL value){
                    STRONG_SELF(self);
                    BATFamilyServiceItem *serviceItem = self.serviceSettingModel.Data.FamilyServiceList[index];
                    if ([serviceItem.TKey isEqualToString:key]) {
                        serviceItem.TValue = value;
                    }
                    
                    [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                    
                };
                
                return cell;
                
                
            }
        }
        
        
        BATFeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATFeeTableViewCell" forIndexPath:indexPath];
        
        cell.titleLabel.text = @"费用";
        cell.textField.placeholder = @"请输入价格";
        cell.indexPath = indexPath;
        
        if (indexPath.section == 0) {
            //视频咨询
            cell.unitLabel.text = @"元/次";
            cell.textField.text = self.serviceSettingModel.Data.VideoConsultCost;
            WEAK_SELF(self);
            cell.feeInput = ^(NSString *fee,NSIndexPath *cellIndexPath) {
                DDLogDebug(@"free %@ indexPath %@",fee,cellIndexPath);
                STRONG_SELF(self);
                self.serviceSettingModel.Data.VideoConsultCost = [self changeFee:fee];
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            };
            
        } else if (indexPath.section == 1) {
            //语音咨询
            cell.unitLabel.text = @"元/次";
            cell.textField.text = self.serviceSettingModel.Data.VoiceConsultCost;
            
            WEAK_SELF(self);
            cell.feeInput = ^(NSString *fee,NSIndexPath *cellIndexPath) {
                DDLogDebug(@"free %@ indexPath %@",fee,cellIndexPath);
                STRONG_SELF(self);
                self.serviceSettingModel.Data.VoiceConsultCost = [self changeFee:fee];
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            
        } else if (indexPath.section == 2) {
            //图文咨询
            cell.unitLabel.text = @"元/次";
            cell.textField.text = self.serviceSettingModel.Data.WordConsultCost;
            
            WEAK_SELF(self);
            cell.feeInput = ^(NSString *fee,NSIndexPath *cellIndexPath) {
                DDLogDebug(@"free %@ indexPath %@",fee,cellIndexPath);
                STRONG_SELF(self);
                self.serviceSettingModel.Data.WordConsultCost = [self changeFee:fee];
                [self.serviceSettingView.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            };
            
        } else if (indexPath.section == 3) {
            //家庭医生
            if (self.serviceSettingModel.Data.FamilyDoctorCostList.count > 0) {
                BATFamilyDoctorCostItem *familyDoctorCostItem = self.serviceSettingModel.Data.FamilyDoctorCostList[indexPath.row - 1];
                
                cell.unitLabel.text = [NSString stringWithFormat:@"元/%@个月",familyDoctorCostItem.TKey];
                cell.textField.text = familyDoctorCostItem.TValue;
                
                WEAK_SELF(self);
                cell.feeInput = ^(NSString *fee,NSIndexPath *cellIndexPath) {
                    DDLogDebug(@"free %@ indexPath %@",fee,cellIndexPath);
                    STRONG_SELF(self);
                    BATFamilyDoctorCostItem *item = self.serviceSettingModel.Data.FamilyDoctorCostList[cellIndexPath.row - 1];
                    item.TValue = [self changeFee:fee];
                    [self.serviceSettingModel.Data.FamilyDoctorCostList replaceObjectAtIndex:cellIndexPath.row - 1 withObject:item];
                    [self.serviceSettingView.tableView reloadRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                };
            }
        }

        return cell;
    }
    
    return nil;

}

#pragma mark - private
- (void)initData
{
    BATServiceSettingData *data = [[BATServiceSettingData alloc] init];
    data.ID = @"";
    data.IsVideoConsult = NO;
    data.VideoConsultCost = @"";
    
    data.IsVoiceConsult = NO;
    data.VoiceConsultCost = @"";
    
    data.IsWordConsult = NO;
    data.WordConsultCost = @"";
    
    data.IsFamilyDoctor = NO;
    
    
    NSMutableArray *familyDoctorCostList = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        BATFamilyDoctorCostItem *costItem = [[BATFamilyDoctorCostItem alloc] init];
        if (i == 0) {
            costItem.TKey = @"1";
        } else if (i == 1) {
            costItem.TKey = @"3";
        } else if (i == 2) {
            costItem.TKey = @"6";
        } else if (i == 3) {
            costItem.TKey = @"12";
        }
        costItem.TValue = @"";
        
        [familyDoctorCostList addObject:costItem];
    }
    
    NSMutableArray *FamilyServiceList = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        BATFamilyServiceItem *serviceItem = [[BATFamilyServiceItem alloc] init];
        if (i == 0) {
            serviceItem.TKey = @"1";
        } else if (i == 1) {
            serviceItem.TKey = @"2";
        } else if (i == 2) {
            serviceItem.TKey = @"3";
        } else if (i == 3) {
            serviceItem.TKey = @"4";
        }
        serviceItem.TValue = NO;
        
        [FamilyServiceList addObject:serviceItem];
    }
    
    data.FamilyDoctorCostList = familyDoctorCostList;
    data.FamilyServiceList = FamilyServiceList;
    
    
    self.serviceSettingModel = [[BATServiceSettingModel alloc] init];
    self.serviceSettingModel.Data = data;
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string
{

    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    
    if ([scan scanInt:&val] && [scan isAtEnd]) {
        if (string.length > 1) {
            if ([[string substringToIndex:1] isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    
    return YES;
}

//判断是否为浮点形
- (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)checkFee:(NSString *)string
{
    if ([string rangeOfString:@"."].location == NSNotFound) {
        return YES;
    }
    
    NSRange range = [string rangeOfString:@"."];
    
    if ((string.length - (range.location + range.length)) > 2) {
        return NO;
    }
    return YES;
    
}

- (NSString *)changeFee:(NSString *)fee
{
    if ([fee isEqualToString:@"0.0"]) {
        return @"0";
    }
    return fee;
}

- (void)goBack
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - Net

#pragma mark - 获取医生服务设置
- (void)requestGetServiceSetting
{
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/GetServiceSetting" parameters:@{@"doctorID":self.DoctorID} type:kGET success:^(id responseObject) {
        [self dismissProgress];
        
        NSDictionary *dic = responseObject;
        
        if ([[dic objectForKey:@"Data"] isKindOfClass:[NSDictionary class]]) {
            self.serviceSettingModel = [BATServiceSettingModel mj_objectWithKeyValues:responseObject];
        }
        
        
        [self.serviceSettingView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self dismissProgress];
    }];
}

#pragma mark - 设置服务设置
- (void)requestServiceSetting
{
    
    [self.view endEditing:YES];
    
    
    if (self.serviceSettingModel.Data.IsVideoConsult) {
        if (self.serviceSettingModel.Data.VideoConsultCost.length > 0) {
            
            if (![self isPureInt:self.serviceSettingModel.Data.VideoConsultCost]) {
                [self showErrorWithText:@"视频咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (![self isPureFloat:self.serviceSettingModel.Data.VideoConsultCost]) {
                [self showErrorWithText:@"视频咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (self.serviceSettingModel.Data.VideoConsultCost.length > 11) {
                [self showErrorWithText:@"请输入合理的视频咨询费用"];
                [self goBack];
                return;
            }
            
            if (![self checkFee:self.serviceSettingModel.Data.VideoConsultCost]) {
                [self showErrorWithText:@"视频咨询费用只能是两位小数"];
                [self goBack];
                return;
            }
            
            if ([self.serviceSettingModel.Data.VideoConsultCost isEqualToString:@"0"]) {
                [self showErrorWithText:@"视频咨询费用不能为0"];
                [self goBack];
                return;
            }
            
        } else {
            [self showErrorWithText:@"视频咨询费用不能为空"];
            [self goBack];
            return;
        }
    }
    
    if (self.serviceSettingModel.Data.IsVoiceConsult) {
        
        
        
        if (self.serviceSettingModel.Data.VoiceConsultCost.length > 0) {
            
            if (![self isPureInt:self.serviceSettingModel.Data.VoiceConsultCost]) {
                [self showErrorWithText:@"语音咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (![self isPureFloat:self.serviceSettingModel.Data.VoiceConsultCost]) {
                [self showErrorWithText:@"语音咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (self.serviceSettingModel.Data.VoiceConsultCost.length > 11) {
                [self showErrorWithText:@"请输入合理的语音咨询费用"];
                [self goBack];
                return;
            }
            
            if (![self checkFee:self.serviceSettingModel.Data.VoiceConsultCost]) {
                [self showErrorWithText:@"语音咨询费用只能是两位小数"];
                [self goBack];
                return;
            }
            
            if ([self.serviceSettingModel.Data.VoiceConsultCost isEqualToString:@"0"]) {
                [self showErrorWithText:@"语音咨询费用不能为0"];
                [self goBack];
                return;
            }
            
        } else {
            [self showErrorWithText:@"语音咨询费用不能为空"];
            [self goBack];
            return;
        }
    }
    
    if (self.serviceSettingModel.Data.IsWordConsult) {
        if (self.serviceSettingModel.Data.WordConsultCost.length > 0) {
            
            if (![self isPureInt:self.serviceSettingModel.Data.WordConsultCost]) {
                [self showErrorWithText:@"图文咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (![self isPureFloat:self.serviceSettingModel.Data.WordConsultCost]) {
                [self showErrorWithText:@"图文咨询费用输入不正确"];
                [self goBack];
                return;
            }
            
            if (self.serviceSettingModel.Data.WordConsultCost.length > 11) {
                [self showErrorWithText:@"请输入合理的图文咨询费用"];
                [self goBack];
                return;
            }
            
            if (![self checkFee:self.serviceSettingModel.Data.WordConsultCost]) {
                [self showErrorWithText:@"图文咨询费用只能是两位小数"];
                [self goBack];
                return;
            }
            
            if ([self.serviceSettingModel.Data.WordConsultCost isEqualToString:@"0"]) {
                [self showErrorWithText:@"图文咨询费用不能为0"];
                [self goBack];
                return;
            }
            
            
        } else {
            [self showErrorWithText:@"图文咨询费用不能为空"];
            [self goBack];
            return;
        }
    }
    
    if (self.serviceSettingModel.Data.IsFamilyDoctor) {
        
        for (int i = 0; i < self.serviceSettingModel.Data.FamilyDoctorCostList.count; i++) {
            BATFamilyDoctorCostItem *familyDoctorCostItem = self.serviceSettingModel.Data.FamilyDoctorCostList[i];
            if (familyDoctorCostItem.TValue.length > 0) {
                
                if (![self isPureInt:familyDoctorCostItem.TValue]) {
                    [self showErrorWithText:@"家庭医生费用输入不正确"];
                    [self goBack];
                    return;
                }
                
                if (![self isPureFloat:familyDoctorCostItem.TValue]) {
                    [self showErrorWithText:@"家庭医生费用输入不正确"];
                    [self goBack];
                    return;
                }
                
                if (familyDoctorCostItem.TValue.length > 11) {
                    [self showErrorWithText:@"请输入合理的家庭医生费用"];
                    [self goBack];
                    return;
                }
                
                if (![self checkFee:familyDoctorCostItem.TValue]) {
                    [self showErrorWithText:@"家庭医生费用只能是两位小数"];
                    [self goBack];
                    return;
                }
                
                if ([familyDoctorCostItem.TValue isEqualToString:@"0"]) {
                    [self showErrorWithText:@"家庭医生费用不能为0"];
                    [self goBack];
                    return;
                }
                
            } else {
                [self showErrorWithText:@"家庭医生费用不能为空"];
                [self goBack];
                return;
            }
        }
    }
    
    
    NSMutableArray *familyDoctorCostList = [NSMutableArray array];
    for (int i = 0; i < self.serviceSettingModel.Data.FamilyDoctorCostList.count; i++) {
        BATFamilyDoctorCostItem *costItem = self.serviceSettingModel.Data.FamilyDoctorCostList[i];
        [familyDoctorCostList addObject:@{@"TKey":costItem.TKey,@"TValue":costItem.TValue}];
    }
    
    BOOL flag = NO;
    
    NSMutableArray *familyServiceList = [NSMutableArray array];
    for (int i = 0; i < self.serviceSettingModel.Data.FamilyServiceList.count; i++) {
        BATFamilyServiceItem *serviceItem = self.serviceSettingModel.Data.FamilyServiceList[i];
        [familyServiceList addObject:@{@"TKey":serviceItem.TKey,@"TValue":serviceItem.TValue ? @"1" : @"0"}];
        
        if (serviceItem.TValue) {
            flag = YES;
        }
    }
    
    if (!flag && self.serviceSettingModel.Data.IsFamilyDoctor) {
        [self showErrorWithText:@"请选择家庭医生提供的服务"];
        [self goBack];
        return;
    }
    
    [self showProgress];
    
    [HTTPTool requestWithURLString:@"/api/Doctor/ServiceSetting"
                        parameters:@{@"ID":self.serviceSettingModel.Data.ID,
                                     @"DoctorID":self.DoctorID,
                                     @"IsVideoConsult":@(self.serviceSettingModel.Data.IsVideoConsult),
                                     @"IsVoiceConsult":@(self.serviceSettingModel.Data.IsVoiceConsult),
                                     @"IsWordConsult":@(self.serviceSettingModel.Data.IsWordConsult),
                                     @"IsFamilyDoctor":@(self.serviceSettingModel.Data.IsFamilyDoctor),
                                     @"VideoConsultCost":self.serviceSettingModel.Data.VideoConsultCost,
                                     @"VoiceConsultCost":self.serviceSettingModel.Data.VoiceConsultCost,
                                     @"WordConsultCost":self.serviceSettingModel.Data.WordConsultCost,
                                     @"FamilyDoctorCostList":familyDoctorCostList,
                                     @"FamilyServiceList":familyServiceList}
     
                              type:kPOST success:^(id responseObject) {
                                  
                                  [self showSuccessWithText:@"设置成功"];
                                  
                                  [self goBack];

    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
        [self goBack];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.serviceSettingView];
    
    WEAK_SELF(self);
    [self.serviceSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATServiceSettingView *)serviceSettingView
{
    if (_serviceSettingView == nil) {
        _serviceSettingView = [[BATServiceSettingView alloc] init];
        _serviceSettingView.tableView.delegate = self;
        _serviceSettingView.tableView.dataSource = self;
        
        WEAK_SELF(self);
        _serviceSettingView.footerView.confirmClickBlock = ^(){
            STRONG_SELF(self);
            [self requestServiceSetting];
        };
    }
    return _serviceSettingView;
}

@end
