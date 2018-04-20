//
//  BATDoctorStudioConsultListViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATDoctorStudioConsultListViewController.h"
#import "BATDoctorStudioConsultingRoomTableViewCell.h"
#import "BATDoctorStrudioMyRoomModel.h"
#import "BATChatViewController.h"
#import "BATCallViewController.h"
#import "BATCanEnterRoomModel.h"

static  NSString * const CONSULTING_CELL = @"BATDoctorStudioConsultingRoomTableViewCell";

@interface BATDoctorStudioConsultListViewController() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *consultingTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) BATDefaultView *defaultView;

/**
 判断数据请求完成
 */
@property (nonatomic,assign) BOOL isCompleteRequest;

@end

@implementation BATDoctorStudioConsultListViewController

- (void)dealloc
{
    DDLogDebug(@"%@", self);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"BATRefreshUnreadNotifcatiion" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateConsultStatus:) name:@"BATUpdateConsultStatusNotification" object:nil];
    
    self.title = @"我的诊室";
    self.dataArray = [NSMutableArray array];
    self.pageIndex = 0;
    
    [self layoutPages];
    
    [self.consultingTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.dataArray.count > 0) {
        [self refresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)refresh
{
    [self.consultingTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BATDoctorStudioConsultingRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CONSULTING_CELL forIndexPath:indexPath];
    BATMyRoomData *data = self.dataArray[indexPath.section];
    
    cell.indexPath = indexPath;
    cell.timeLabel.text = data.CreatedTime;
    [cell.avaterImageView sd_setImageWithURL:[NSURL URLWithString:data.PatientPhotoPath] placeholderImage:nil];
    cell.nameLabel.text = data.PatientName;
    cell.sexLabel.text = data.Gender?@"男":@"女";
    cell.ageLabel.text = [NSString stringWithFormat:@"%ld岁",(long)data.Age];
    [cell loadMenuButton:data.OrderServerType consultStatus:data.ConsultStatus];
    
    NSInteger unreadCount = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_GROUP targetId:data.ChatRoomId];
    
    cell.unreadImageView.hidden = unreadCount > 0 ? NO : YES;
    
    WEAK_SELF(self);
    cell.menuBlock = ^(NSInteger type) {
        STRONG_SELF(self);
        if (type == 1) {
            //视频
        } else if (type == 2) {
            //语音
            
            [self requestCanEnterRoom:data];

            
//            [self requestGetChannelKey:data];
            
        } else if (type == 3) {
            //图文
            
            //设置融云个人信息
            [[BATRongCloudManager sharedBATRongCloudManager] bat_saveRongCloudUserInfoWithUserId:data.PatientId name:data.PatientName portraitUri:data.PatientPhotoPath];
            
            BATChatViewController *chatVC = [[BATChatViewController alloc] initWithConversationType:ConversationType_GROUP targetId:data.ChatRoomId];
            chatVC.title = data.PatientName;
            chatVC.orderNo = data.OrderNo;
            chatVC.IllnessDescription = data.IllnessDescription;
            
            NSMutableArray *images = [NSMutableArray array];
            
            if (data.Images.length > 0) {
                [images addObjectsFromArray:[data.Images componentsSeparatedByString:@","]];
            }
            
            chatVC.images = images;
            chatVC.ConsultStatus = data.ConsultStatus;
            chatVC.isFamilyService = data.IsFamilyService;
            chatVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatVC animated:YES];
            
        }
    };
    
    cell.isFamilyService = data.IsFamilyService;
    cell.isExpire = data.IsExpire;
    
    return cell;
}

#pragma mark - Action
- (void)updateConsultStatus:(NSNotification *)notif
{
//    NSDictionary *dic = [notif object];
//    NSString *orderNo = dic[@"orderNo"];
//    NSInteger consultStatus = [dic[@"consultStatus"] integerValue];
//    
//    for (BATMyRoomData *data in self.dataArray) {
//        if ([data.OrderNo isEqualToString:orderNo]) {
//            data.ConsultStatus = consultStatus;
//            break;
//        }
//    }
//    
//    [self.consultingTableView reloadData];
    
    [self.consultingTableView.mj_header beginRefreshing];
    
}

#pragma mark - net
#pragma mark - 获取列表数据
- (void)myRoomRequest {
    
    [HTTPTool requestWithURLString:@"/api/Doctor/GetMyRoom" parameters:@{@"doctorID":self.doctorID,@"pageIndex":@(self.pageIndex),@"pageSize":@10,@"consultStatus":@(self.consultState)} type:kGET success:^(id responseObject) {
        WEAK_SELF(self);
        [self.consultingTableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.consultingTableView reloadData];
        }];
        [self.consultingTableView.mj_footer endRefreshing];
        
        if (_pageIndex == 0) {
            [self.dataArray removeAllObjects];
        }
        
        BATDoctorStrudioMyRoomModel *model = [BATDoctorStrudioMyRoomModel mj_objectWithKeyValues:responseObject];
        
        [self.dataArray addObjectsFromArray:model.Data];
        
        if (model.RecordsCount > 0) {
            self.consultingTableView.mj_footer.hidden = NO;
        } else {
            self.consultingTableView.mj_footer.hidden = YES;
        }
        
        if (self.dataArray.count == model.RecordsCount) {
            //            [self.batOnlineLearningView.tableView.mj_footer endRefreshingWithNoMoreData];
            self.consultingTableView.mj_footer.hidden = YES;
        }
        
        [self.consultingTableView reloadData];
        
        
        if(self.dataArray.count == 0){
            [self.defaultView showDefaultView];
        }
        
    } failure:^(NSError *error) {
        
        [self showErrorWithText:error.localizedDescription];
        
        WEAK_SELF(self);
        [self.consultingTableView.mj_header endRefreshingWithCompletionBlock:^{
            STRONG_SELF(self);
            self.isCompleteRequest = YES;
            [self.consultingTableView reloadData];
        }];
        [self.consultingTableView.mj_footer endRefreshing];
        _pageIndex--;
        if (_pageIndex < 0) {
            _pageIndex = 0;
        }
        
        [self.defaultView showDefaultView];
        
    }];
}

#pragma mark - 判断是否可以进入诊室
- (void)requestCanEnterRoom:(BATMyRoomData *)data
{
    [HTTPTool requestWithURLString:@"/api/order/CanEnterRoom" parameters:@{@"orderNo":data.OrderNo} type:kGET success:^(id responseObject) {
        
        BATCanEnterRoomModel *canEnterRoomModel = [BATCanEnterRoomModel mj_objectWithKeyValues:responseObject];
        
        if (canEnterRoomModel.Data) {
            //主动呼叫
            BATCallViewController *callVC = [[BATCallViewController alloc] init];
            
            callVC.callState = BATCallState_Call;
            callVC.avatar = data.PatientPhotoPath;
            callVC.userName = data.PatientName;
            callVC.accountID = data.PatientId;
            callVC.roomID = data.ChatRoomId;
            callVC.orderNo = data.OrderNo;
            
            [self presentViewController:callVC animated:YES completion:nil];
        } else {
            [self showText:@"不可进行呼叫"];
        }
        

        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

//#pragma mark - 获取channelkey
//- (void)requestGetChannelKey:(BATMyRoomData *)roomData
//{
//    [HTTPTool requestWithURLString:@"/api/Doctor/GetChannelKey" parameters:@{@"chatRoomId":roomData.ChatRoomId} type:kGET success:^(id responseObject) {
//        //主动呼叫
//        BATCallViewController *callVC = [[BATCallViewController alloc] init];
//        
//        callVC.callState = BATCallState_Call;
//        callVC.avatar = roomData.PatientPhotoPath;
//        callVC.userName = roomData.PatientName;
//        callVC.accountID = roomData.PatientId;
//        
//        [self presentViewController:callVC animated:YES completion:nil];
//
//    } failure:^(NSError *error) {
//        
//    }];
//}

#pragma mark - layoutPages
- (void)layoutPages {
    WEAK_SELF(self);
    [self.view addSubview:self.consultingTableView];
    [self.consultingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.defaultView];
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.bottom.right.left.top.equalTo(self.view);
    }];
    
}
#pragma mark - getter
- (UITableView *)consultingTableView {
    
    if (!_consultingTableView) {
        _consultingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        [_consultingTableView registerClass:[BATDoctorStudioConsultingRoomTableViewCell class] forCellReuseIdentifier:CONSULTING_CELL];
        
        _consultingTableView.rowHeight = 125;
        _consultingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _consultingTableView.tableFooterView = [UIView new];
        _consultingTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        _consultingTableView.delegate = self;
        _consultingTableView.dataSource = self;
        
        WEAK_SELF(self);
        _consultingTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex = 0;
            [self myRoomRequest];
        }];
        _consultingTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            STRONG_SELF(self);
            self.pageIndex ++;
            [self myRoomRequest];
        }];
        
        _consultingTableView.mj_footer.hidden = YES;
    }
    
    return _consultingTableView;
}

- (BATDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[BATDefaultView alloc] initWithFrame:CGRectZero];
        _defaultView.hidden = YES;
        WEAK_SELF(self);
        [_defaultView setReloadRequestBlock:^{
            STRONG_SELF(self);
            DDLogInfo(@"=====重新开始加载！=====");
            self.defaultView.hidden = YES;
            [self myRoomRequest];
        }];
        
    }
    return _defaultView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
