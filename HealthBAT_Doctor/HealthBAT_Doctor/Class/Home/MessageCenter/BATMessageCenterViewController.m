//
//  BATMessageCenterViewController.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMessageCenterViewController.h"
#import "BATMessageCenterTableViewCell.h"
#import "BATContractConfirmViewController.h"
#import "BATDoctorStudioMessageModel.h"
#import "BATContractDetailViewController.h"

@interface BATMessageCenterViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) BATDefaultView *defaultView;

/**
 判断数据请求完成
 */
@property (nonatomic,assign) BOOL isCompleteRequest;

@end

@implementation BATMessageCenterViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    [self pageLayout];
    
    self.title = @"消息";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.messageCenterView.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMessageState:) name:@"BATUpdateMessageStateNotification" object:nil];
    
    _dataSource = [NSMutableArray array];
    _pageIndex = 0;
    _pageSize = 10;
    
    [self.messageCenterView.tableView registerClass:[BATMessageCenterTableViewCell class] forCellReuseIdentifier:@"BATMessageCenterTableViewCell"];
    
    [self.messageCenterView.tableView.mj_header beginRefreshing];
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
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
    BATMessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATMessageCenterTableViewCell" forIndexPath:indexPath];
    
    if (_dataSource.count > 0) {
        
        BATDoctorStudioMessageData *data = _dataSource[indexPath.row];
        
        if (data.MessageType == 1 || data.MessageType == 4) {
            //1确认合同，4取消合同
            cell.iconImageView.image = [UIImage imageNamed:@"ic-xxqr"];
        } else if (data.MessageType == 2) {
            //新的合同
            cell.iconImageView.image = [UIImage imageNamed:@"ic-xdht"];
        } else if (data.MessageType == 3) {
            //患者消息
            cell.iconImageView.image = [UIImage imageNamed:@"ic-xdht"];
        }
        
        cell.titleLabel.text = data.MessageTitle;
        cell.timeLabel.text = data.CreatedTime;
        cell.contentLabel.text = data.MessageContent;
        cell.pointImageView.hidden = data.IsRead;
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        BATDoctorStudioMessageData *data = _dataSource[indexPath.row];
        
        if (!data.IsRead) {
            [self requestSetIsRead:indexPath data:data];
        }
        
        
        if (data.MessageType == 1) {
            BATContractConfirmViewController *contractConfirmVC = [[BATContractConfirmViewController alloc] init];
            contractConfirmVC.messageID = data.ID;
            contractConfirmVC.state = data.State;
            contractConfirmVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:contractConfirmVC animated:YES];
        } else if (data.MessageType == 2) {
            BATContractDetailViewController *contractDetailVC = [[BATContractDetailViewController alloc] init];
            contractDetailVC.orderNO = data.OrderNo;
            contractDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:contractDetailVC animated:YES];
        }
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (_dataSource.count > 0) {
            BATDoctorStudioMessageData *data = _dataSource[indexPath.row];
            
            [self requestDeleteMessage:data];
        }
        
    }
}

#pragma mark - Action
- (void)updateMessageState:(NSNotification *)notif
{
    NSDictionary *dic = [notif object];
    
    NSString *messageId = dic[@"messageId"];
    NSInteger state = [dic[@"state"] integerValue];
    
    for (BATDoctorStudioMessageData *data in _dataSource) {
        if ([data.ID isEqualToString:messageId]) {
            data.State = state;
            [self.messageCenterView.tableView reloadData];
            break;
        }
    }
}

#pragma mark - Net
#pragma mark - 获取消息列表
- (void)requestGetMessageLst
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetMessageLst" parameters:@{@"pageIndex":@(_pageIndex),@"pageSize":@(_pageSize)} type:kGET success:^(id responseObject) {
        WEAK_SELF(self);
        [self.messageCenterView.tableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.messageCenterView.tableView reloadData];
        }];
        [self.messageCenterView.tableView.mj_footer endRefreshing];
        
        if (_pageIndex == 0) {
            [_dataSource removeAllObjects];
        }
        
        BATDoctorStudioMessageModel *doctorStudioMessageModel = [BATDoctorStudioMessageModel mj_objectWithKeyValues:responseObject];
        
        [_dataSource addObjectsFromArray:doctorStudioMessageModel.Data];
        
//        NSInteger badge = 0;
//        
//        for (BATDoctorStudioMessageData *data in _dataSource) {
//            
//            if (!data.IsRead) {
//                badge+=1;
//            }
//        }
//        
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
//        [JPUSHService setBadge:badge];
        
        
        if (doctorStudioMessageModel.RecordsCount > 0) {
            self.messageCenterView.tableView.mj_footer.hidden = NO;
        } else {
            self.messageCenterView.tableView.mj_footer.hidden = YES;
        }
        
        if (_dataSource.count == doctorStudioMessageModel.RecordsCount) {
            self.messageCenterView.tableView.mj_footer.hidden = YES;
        }
        
        [self.messageCenterView.tableView reloadData];
        
        
        if(_dataSource.count == 0){
            [self.defaultView showDefaultView];
        }
        
        
    } failure:^(NSError *error) {
        
        [self showErrorWithText:error.localizedDescription];
        
        WEAK_SELF(self);
        [self.messageCenterView.tableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.messageCenterView.tableView reloadData];
        }];
        [self.messageCenterView.tableView.mj_footer endRefreshing];
        _pageIndex--;
        if (_pageIndex < 0) {
            _pageIndex = 0;
        }
        
        [self.defaultView showDefaultView];
    }];

}

#pragma mark - 删除消息
- (void)requestDeleteMessage:(BATDoctorStudioMessageData *)data
{
    [self showProgress];
    [HTTPTool requestWithURLString:@"/api/Doctor/DeleteMessage" parameters:@{@"messageId":data.ID} type:kGET success:^(id responseObject) {
        [self dismissProgress];
        
        [_dataSource removeObject:data];
        
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
        [JPUSHService setBadge:badge];
        
        [self.messageCenterView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self dismissProgress];
    }];
}

#pragma mark - 设置消息已读
- (void)requestSetIsRead:(NSIndexPath *)indexPath data:(BATDoctorStudioMessageData *)data
{
    [HTTPTool requestWithURLString:@"/api/Doctor/SetIsRead" parameters:@{@"messageId":data.ID} type:kGET success:^(id responseObject) {
        [self dismissProgress];
        
        data.IsRead = YES;
        
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
        [JPUSHService setBadge:badge];
        
        [_dataSource replaceObjectAtIndex:indexPath.row withObject:data];
        
        [self.messageCenterView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self dismissProgress];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.messageCenterView];
    
    WEAK_SELF(self);
    [self.messageCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.defaultView];
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.bottom.right.left.top.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATMessageCenterView *)messageCenterView
{
    if (_messageCenterView == nil) {
        _messageCenterView = [[BATMessageCenterView alloc] init];
        _messageCenterView.tableView.delegate = self;
        _messageCenterView.tableView.dataSource = self;
        
        WEAK_SELF(self);
        _messageCenterView.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex = 0;
            [self.messageCenterView.tableView.mj_footer resetNoMoreData];
            [self requestGetMessageLst];
        }];
        
        _messageCenterView.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex++;
            [self requestGetMessageLst];
        }];
        
        _messageCenterView.tableView.mj_footer.hidden = YES;

    }
    return _messageCenterView;
}

- (BATDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[BATDefaultView alloc]initWithFrame:CGRectZero];
        _defaultView.hidden = YES;
        WEAK_SELF(self);
        [_defaultView setReloadRequestBlock:^{
            STRONG_SELF(self);
            DDLogInfo(@"=====重新开始加载！=====");
            self.defaultView.hidden = YES;
            [self requestGetMessageLst];
        }];
        
    }
    return _defaultView;
}


@end
