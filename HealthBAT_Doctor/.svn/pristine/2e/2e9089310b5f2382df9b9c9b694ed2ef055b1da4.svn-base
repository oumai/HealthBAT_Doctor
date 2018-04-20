//
//  BATOrderListViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATOrderListViewController.h"
#import "BATFamilyOrderCell.h"
#import "BATTextImageOrderCell.h"
#import "BATAudioOrderCell.h"
#import "BATOrderModel.h"
#import "BATContractDetailViewController.h"
#import "BATChatViewController.h"
#import "BATVideoOrderCell.h"

@interface BATOrderListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) BATDefaultView *defaultView;

/**
 判断数据请求完成
 */
@property (nonatomic,assign) BOOL isCompleteRequest;


@end

@implementation BATOrderListViewController

- (void)dealloc
{
    DDLogDebug(@"%s",__func__);
    
    if (self.orderType == BATOrderType_TextAndImage) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.orderType == BATOrderType_TextAndImage) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateConsultStatus:) name:@"BATUpdateConsultStatusNotification" object:nil];
    }
    
    _dataSource = [NSMutableArray array];
    _pageIndex = 0;
    _pageSize = 10;
    
    [self.orderListView.tableView registerClass:[BATFamilyOrderCell class] forCellReuseIdentifier:@"BATFamilyOrderCell"];
    [self.orderListView.tableView registerClass:[BATTextImageOrderCell class] forCellReuseIdentifier:@"BATTextImageOrderCell"];
    [self.orderListView.tableView registerClass:[BATAudioOrderCell class] forCellReuseIdentifier:@"BATAudioOrderCell"];
    [self.orderListView.tableView registerClass:[BATVideoOrderCell class] forCellReuseIdentifier:@"BATVideoOrderCell"];
    
    [self.orderListView.tableView.mj_header beginRefreshing];

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
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.orderType == BATOrderType_Family) {
//        return UITableViewAutomaticDimension;
//    } else if (self.orderType == BATOrderType_TextAndImage) {
//        return UITableViewAutomaticDimension;
//    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderType == BATOrderType_Family) {
        
        BATFamilyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATFamilyOrderCell" forIndexPath:indexPath];
        
        if (_dataSource.count > 0) {
            
            BATOrderData *orderData = _dataSource[indexPath.section];
            
            cell.orderPayTimeLabel.text = orderData.CreatedTime;
            cell.partyALabel.text = [NSString stringWithFormat:@"甲方：%@",orderData.Name];
            cell.serviceTimeLabel.text = [NSString stringWithFormat:@"时间：包月%ld个月",orderData.OrderServerTime];
            cell.serviceContentLabel.text = [NSString stringWithFormat:@"服务内容：%@",orderData.OrderServerName];;
            
            
        }
        
        return cell;
        
    } else if (self.orderType == BATOrderType_TextAndImage) {
        BATTextImageOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATTextImageOrderCell" forIndexPath:indexPath];
        
        if (_dataSource.count > 0) {
            
            BATOrderData *orderData = _dataSource[indexPath.section];
            
            cell.nameLabel.text = [NSString stringWithFormat:@"就诊人：%@",orderData.Name];
            cell.consultTimeLabel.text = [NSString stringWithFormat:@"咨询时间：%@",orderData.ConsultTime];
            cell.descLabel.text = [NSString stringWithFormat:@"病症描述：%@",orderData.IllnessDescription];
//            if (orderData.ConsultStatus == 4) {
//                cell.statusLabel.text = @"未咨询";
//            } else if (orderData.ConsultStatus == 1) {
//                cell.statusLabel.text = @"咨询中";
//            } else if (orderData.ConsultStatus == 2) {
//                cell.statusLabel.text = @"咨询完成";
//            }
            
            if (orderData.ConsultStatus == 1) {
                cell.statusLabel.text = @"咨询中";
            } else if (orderData.ConsultStatus == 2) {
                cell.statusLabel.text = @"咨询完成";
            } else if (orderData.ConsultStatus == 3) {
                cell.statusLabel.text = @"待支付";
            } else if (orderData.ConsultStatus == 4) {
                cell.statusLabel.text = @"未回复";
            } else if (orderData.ConsultStatus == 5) {
                cell.statusLabel.text = @"咨询取消";
            } else if (orderData.ConsultStatus == 6) {
                cell.statusLabel.text = @"咨询结束";
            }
            
            [cell resetUI:orderData.ConsultStatus];
            
            WEAK_SELF(self);
            cell.replyBlock = ^{
                STRONG_SELF(self);
                
                
                //设置融云个人信息
                [[BATRongCloudManager sharedBATRongCloudManager] bat_saveRongCloudUserInfoWithUserId:[NSString stringWithFormat:@"%ld",orderData.AccountID] name:orderData.Name portraitUri:orderData.PhotoPath];
                
                BATChatViewController *chatVC = [[BATChatViewController alloc] initWithConversationType:ConversationType_GROUP targetId:orderData.RoomID];
                chatVC.title = orderData.Name;
                chatVC.orderNo = orderData.OrderNo;
                chatVC.IllnessDescription = orderData.IllnessDescription;
                
                NSMutableArray *images = [NSMutableArray array];
                
                if (orderData.Images.length > 0) {
                    [images addObjectsFromArray:[orderData.Images componentsSeparatedByString:@","]];
                }
                
                chatVC.images = images;
                chatVC.ConsultStatus = orderData.ConsultStatus;
                chatVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:chatVC animated:YES];
                
            };
        }
        
        return cell;
    } else if (self.orderType == BATOrderType_Audio) {
        BATAudioOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATAudioOrderCell" forIndexPath:indexPath];
        
        if (_dataSource.count > 0) {
            
            BATOrderData *orderData = _dataSource[indexPath.section];
            
            cell.nameLabel.text = [NSString stringWithFormat:@"就诊人：%@",orderData.Name];
            cell.orderType.text = [NSString stringWithFormat:@"服务类型：%@",@"语音咨询"];
            cell.timeLabel.text = [NSString stringWithFormat:@"预约时间：%@ %@-%@",orderData.SDate,orderData.StartTime,orderData.EndTime];
            if (orderData.ConsultStatus == 0) {
                cell.statusLabel.text = @"未咨询";
            } else if (orderData.ConsultStatus == 1) {
                cell.statusLabel.text = @"咨询中";
            } else if (orderData.ConsultStatus == 2) {
                cell.statusLabel.text = @"咨询完成";
            }
        }

        
        return cell;
    } else if (self.orderType == BATOrderType_Video) {
        BATVideoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATVideoOrderCell" forIndexPath:indexPath];
        return cell;
    }
    
    return nil;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.orderType == BATOrderType_Family) {
        if (_dataSource.count > 0) {
            
            BATOrderData *orderData = _dataSource[indexPath.section];
            
            BATContractDetailViewController *contractDetailVC = [[BATContractDetailViewController alloc] init];
            contractDetailVC.orderNO = orderData.OrderNo;
            contractDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:contractDetailVC animated:YES];
            
        }
    }
}

#pragma mark - Action
- (void)updateConsultStatus:(NSNotification *)notif
{
    NSDictionary *dic = [notif object];
    NSString *orderNo = dic[@"orderNo"];
    NSInteger consultStatus = [dic[@"consultStatus"] integerValue];
    
    for (BATOrderData *data in _dataSource) {
        if ([data.OrderNo isEqualToString:orderNo]) {
            data.ConsultStatus = consultStatus;
            break;
        }
    }
    
    [self.orderListView.tableView reloadData];
    
}

#pragma mark - Net
- (void)requestGetOrderLst
{
    [HTTPTool requestWithURLString:@"/api/Order/GetDoctorStudioOrder" parameters:@{@"orderType":@(self.orderType),@"doctorId":self.doctorID,@"pageIndex":@(_pageIndex),@"pageSize":@(_pageSize)} type:kGET success:^(id responseObject) {
        WEAK_SELF(self);
        [self.orderListView.tableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.orderListView.tableView reloadData];
        }];
        [self.orderListView.tableView.mj_footer endRefreshing];
        
        if (_pageIndex == 0) {
            [_dataSource removeAllObjects];
        }
        
        BATOrderModel *orderModel = [BATOrderModel mj_objectWithKeyValues:responseObject];
        
//        for (BATOrderData *data in orderModel.Data) {
//            //设置融云个人信息
//            [[BATRongCloudManager sharedBATRongCloudManager] bat_saveRongCloudUserInfoWithUserId:[NSString stringWithFormat:@"%ld",data.AccountID] name:data.Name portraitUri:data.PhotoPath];
//        }
        
        [_dataSource addObjectsFromArray:orderModel.Data];
        
        if (orderModel.RecordsCount > 0) {
            self.orderListView.tableView.mj_footer.hidden = NO;
        } else {
            self.orderListView.tableView.mj_footer.hidden = YES;
        }
        
        if (_dataSource.count == orderModel.RecordsCount) {
            //            [self.batOnlineLearningView.tableView.mj_footer endRefreshingWithNoMoreData];
            self.orderListView.tableView.mj_footer.hidden = YES;
        }
        
        [self.orderListView.tableView reloadData];
        
        
        if(_dataSource.count == 0){
            [self.defaultView showDefaultView];
        }
        
        
    } failure:^(NSError *error) {
        
        [self showErrorWithText:error.localizedDescription];
        
        WEAK_SELF(self);
        [self.orderListView.tableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.orderListView.tableView reloadData];
        }];
        [self.orderListView.tableView.mj_footer endRefreshing];
        _pageIndex--;
        if (_pageIndex < 0) {
            _pageIndex = 0;
        }
        
        [self.defaultView showDefaultView];
    }];
}


#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.orderListView];
    [self.view addSubview:self.defaultView];
    
    WEAK_SELF(self);
    [self.orderListView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.bottom.right.left.top.equalTo(self.view);
    }];

}

#pragma mark - get & set
- (BATOrderListView *)orderListView
{
    if (_orderListView == nil) {
        _orderListView = [[BATOrderListView alloc] init];
        _orderListView.tableView.delegate = self;
        _orderListView.tableView.dataSource = self;
        
        WEAK_SELF(self);
        _orderListView.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex = 0;
            [self.orderListView.tableView.mj_footer resetNoMoreData];
            [self requestGetOrderLst];
        }];
        
        _orderListView.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex++;
            [self requestGetOrderLst];
        }];
        
        _orderListView.tableView.mj_footer.hidden = YES;

    }
    return _orderListView;
}

- (BATDefaultView *)defaultView
{
    if (!_defaultView) {
        _defaultView = [[BATDefaultView alloc]initWithFrame:CGRectZero];
        _defaultView.hidden = YES;
        WEAK_SELF(self);
        [_defaultView setReloadRequestBlock:^{
            STRONG_SELF(self);
            DDLogInfo(@"=====重新开始加载！=====");
            self.defaultView.hidden = YES;
            [self requestGetOrderLst];
        }];
        
    }
    return _defaultView;
}


@end
