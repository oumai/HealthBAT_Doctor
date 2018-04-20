//
//  BATTopicDetailController.m
//  RecordTest
//
//  Created by kmcompany on 2017/3/16.
//  Copyright © 2017年 kmcompany. All rights reserved.
//

#import "BATTopicDetailController.h"
#import "BATTapicListCell.h"
#import "BATTopicScorListCell.h"
#import "BATPassTableView.h"
#import "BATTopicDetailModel.h"
#import "BATHotTopicModel.h"
#import "BATTopicTableViewCell.h"
#import "BATSendDynamicViewController.h"
#import "BATInvitationDetailController.h"
//#import "BATTopicPersonController.h"
#import "BATListenDoctorDetailController.h"

@interface BATTopicDetailController ()<UITableViewDelegate,UITableViewDataSource,BATTapicListCellDelegate>

@property (nonatomic,strong) BATPassTableView *topicTab;

@property (nonatomic,strong) UIView *scroLineView;

@property (nonatomic,assign) BOOL isCanScor;

@property (nonatomic,strong) BATTopicDetailModel *model;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger LeftCurrentPage;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton *allBtn;

@property (nonatomic,strong) UIButton *essenceBtn;

@property (nonatomic,assign) NSInteger RightCurrentPage;

@property (nonatomic,strong) NSMutableArray *rightDataArray;

@property (nonatomic,assign) NSInteger page;

/**
 全部内容数量
 */
@property (nonatomic,assign) NSInteger allContentCount;

/**
 精华内容数量
 */
@property (nonatomic,assign) NSInteger essenceContentCount;

@end

@implementation BATTopicDetailController

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pageLayout];
    
//    获取热门帖子列表
//    [self  attentionRequest];
    //获取第一段详情内容
    [self  TopicDetailRequest];
}

- (void)pageLayout {
    
    UIImage *image = [UIImage imageNamed:@"edit"];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [sendBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    
//    UIBarButtonItem *sendBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStyleDone handler:^(id sender) {
//        
//        if (!LOGIN_STATION) {
//            PRESENT_LOGIN_VC
//            return;
//        }
//        if (!self.model) {
//            return;
//        }
//        BATSendDynamicViewController *CCCVV = [[BATSendDynamicViewController alloc]init];
//        CCCVV.topicID = self.model.Data.ID;
//        [self.navigationController pushViewController:CCCVV animated:YES];
//    }];
    
    self.navigationItem.rightBarButtonItem = sendBarButtonItem;
    

    self.navigationItem.rightBarButtonItem.enabled = NO;

    self.isCanScor = YES;
    self.dataArray = [NSMutableArray array];
    self.rightDataArray = [NSMutableArray array];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeTableCanScroll) name:@"Cell_LOCK_SCROLL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLineAction:) name:@"changeLineAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAction) name:@"SEND_DYNAMIC_SUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPresentVC) name:@"isPresentVC" object:nil];
//    self.title = @"话题详情";
    [self.view addSubview:self.topicTab];
    
}

- (void)sendBtnAction
{
    if (!LOGIN_STATION) {
        PRESENT_LOGIN_VC
        return;
    }
    if (!self.model) {
        return;
    }
    BATSendDynamicViewController *CCCVV = [[BATSendDynamicViewController alloc]init];
    CCCVV.topicID = self.model.Data.ID;
    [self.navigationController pushViewController:CCCVV animated:YES];

}

- (void)isPresentVC {

    PRESENT_LOGIN_VC;
}

- (void)reloadDataAction {

    self.RightCurrentPage = 0;
    [self attentionAllRequest];
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BATTopicScorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BATTopicScorListCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.TopicID = self.ID;
    if (self.dataArray.count>0) {
        cell.modelArr = self.dataArray;
    }
    cell.leftTabRecordsCount = self.essenceContentCount;
    
    if (self.rightDataArray.count >0) {
        cell.RightModelArr = self.rightDataArray;
    }
    cell.RightTabRecordsCount = self.allContentCount;
    
    cell.LeftFooterReflashBlock = ^(NSInteger page) {
        self.RightCurrentPage = page;
        [self attentionAllRequest];
    };
    cell.RightFooterReflashBlock = ^(NSInteger page) {
        self.LeftCurrentPage = page;
        [self attentionRequest];
    };
    
    cell.pushBlock =^(NSString *ID,NSInteger isAudio) {
    
        if (isAudio == 1) {
            BATListenDoctorDetailController *listenVC = [[BATListenDoctorDetailController alloc]init];
            listenVC.ID = ID;
            [self.navigationController pushViewController:listenVC animated:YES];
        }else {
            BATInvitationDetailController *inivitation = [[BATInvitationDetailController alloc]init];
            inivitation.ID = ID;
            [self.navigationController pushViewController:inivitation animated:YES];

        }
        
    };
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat offsetX = (SCREEN_WIDTH - 150 * 2) / 2;
    
    self.allBtn = [[UIButton alloc]initWithFrame:CGRectMake(offsetX, 0, 150, 40)];
    self.allBtn.tag = 0;
    [self.allBtn  setTitle:@"全部帖子动态" forState:UIControlStateNormal];
    self.allBtn .titleLabel.font = [UIFont systemFontOfSize:13];
    [self.allBtn  setTitleColor:UIColorFromHEX(0X333333, 1) forState:UIControlStateNormal];
    [self.allBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.allBtn addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.allBtn ];
    
    
    self.essenceBtn = [[UIButton alloc]initWithFrame:CGRectMake(offsetX + 150, 0, 150, 40)];
    self.essenceBtn.tag = 1;
    [self.essenceBtn setTitle:@"精华" forState:UIControlStateNormal];
    self.essenceBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.essenceBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [self.essenceBtn addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.essenceBtn];

    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    self.lineView.backgroundColor = BASE_BACKGROUND_COLOR;
    [view addSubview:self.lineView];
    
//    self.scroLineView = [[UIView alloc]init];
//    self.scroLineView.backgroundColor = BASE_COLOR;
//    [view addSubview:self.scroLineView];
//    self.scroLineView.frame = CGRectMake(self.allBtn.center.x - 50, 40, 100, 1);
//    [self.scroLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.bottom.equalTo(view.mas_bottom).offset(-1);
//        make.centerX.equalTo(self.essenceBtn.mas_centerX);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(1);
//        
//    }];
    
    [self chanegeFramePublicMoth:self.page];
    
    return view;
}

- (void)BATTapicListCellTopicAttenAction:(UIButton *)topicBtn row:(NSIndexPath *)rowPath {
    
    if (!LOGIN_STATION) {
        PRESENT_LOGIN_VC
        return;
    }
    
    NSString *urlString = nil;
    if (self.model.Data.IsTopicFollow) {
        urlString = @"/api/dynamic/CancelOperation";
        [self AttendRequesetWithURL:urlString];
    }else {
        urlString = @"/api/dynamic/ExecuteOperation";
        [self AttendRequesetWithURL:urlString];
    }
    
}

- (void)AttendRequesetWithURL:(NSString *)url{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"2" forKey:@"RelationType"];
    [dict setObject:self.model.Data.ID forKey:@"RelationID"];
    
    [HTTPTool requestWithURLString:url parameters:dict type:kPOST success:^(id responseObject) {
        
        self.model.Data.IsTopicFollow = !self.model.Data.IsTopicFollow;
        
        if (self.TopicDetailRefashBlock) {
            self.TopicDetailRefashBlock(self.model.Data.IsTopicFollow);
        }
        [self.topicTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeLineAction:(NSNotification *)notice {

    NSLog(@"%@",notice.userInfo);
    NSDictionary *userDic = (NSDictionary *)notice.object;
    NSInteger page = [userDic[@"page"] integerValue];

    [self chanegeFramePublicMoth:page];
    
     self.page = page;
}

- (void)changeFrame:(UIButton *)sender {

    [self chanegeFramePublicMoth:sender.tag];
    
    self.page = sender.tag;
    
//    [self.topicTab reloadData];
    
}

- (void)chanegeFramePublicMoth:(NSInteger)tag{
  
    switch (tag) {
        case 0:
        {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.scroLineView.frame = CGRectMake(self.allBtn.center.x - 50, 40, 100, 1);
//                
//            }];
            [self.essenceBtn setTitleColor:UIColorFromHEX(0X333333, 1) forState:UIControlStateNormal];
            [self.allBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
            NSDictionary *dict = @{@"page":@"0"};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLLVIEWROW" object:dict];
            
            break;
        }
            
        case 1:
        {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.scroLineView.frame = CGRectMake(self.essenceBtn.center.x - 50, 40, 100, 1);
//                
//            }];
            [self.essenceBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
            [self.allBtn setTitleColor:UIColorFromHEX(0X333333, 1) forState:UIControlStateNormal];
            NSDictionary *dict = @{@"page":@"1"};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLLVIEWROW" object:dict];
            
            break;
        }
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return SCREEN_HEIGHT - 40 ;
}

#pragma mark -NET
#pragma mark - 获取话题详情
- (void)TopicDetailRequest {

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.ID forKey:@"ID"];
    
    [HTTPTool requestWithURLString:@"/api/dynamic/GetTopicDetail" parameters:dict type:kGET success:^(id responseObject) {
         self.navigationItem.rightBarButtonItem.enabled = YES;
         self.model = [BATTopicDetailModel mj_objectWithKeyValues:responseObject];
//        [self.topicTab reloadData];
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.topicTab reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        
        [self attentionRequest];
        [self attentionAllRequest];
    } failure:^(NSError *error) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }];
}

#pragma mark - 获取精华内容列表
- (void)attentionRequest {
    
    [HTTPTool requestWithURLString:@"/api/dynamic/GetTopicDetailPostList"
                        parameters:@{
                                     @"pageIndex":@(self.LeftCurrentPage),
                                     @"pageSize":@"10",
                                     @"TopicID":self.ID,
                                     @"IsHotFlag":@"1"
                                     }
                              type:kGET
                           success:^(id responseObject) {
                               
                               BATHotTopicModel * tmpModel = [BATHotTopicModel mj_objectWithKeyValues:responseObject];
                               
                               if (self.LeftCurrentPage == 0) {
                                   [self.dataArray removeAllObjects];
                               }
                               
                               for (HotTopicData *data in tmpModel.Data) {
                                   data.isAudio = self.isAudio;
                                   data.isShowTime = YES;
                               }
                               
                               [self.dataArray addObjectsFromArray:tmpModel.Data];
                               
                               self.essenceContentCount = tmpModel.RecordsCount;
                               
                               NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
                               [self.topicTab reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

                               

                               BATTopicScorListCell * ScrollCell = (BATTopicScorListCell *)[self.topicTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                               [ScrollCell.rightTab.mj_footer endRefreshing];
                               
                               
                               
                           } failure:^(NSError *error) {
                               
                               
                           }];
    
    
}

#pragma mark - 获取全部内容列表
- (void)attentionAllRequest {
    
    [HTTPTool requestWithURLString:@"/api/dynamic/GetTopicDetailPostList"
                        parameters:@{
                                     @"pageIndex":@(self.RightCurrentPage),
                                     @"pageSize":@"10",
                                     @"TopicID":self.ID,
                                     @"IsHotFlag":@"0"
                                     }
                              type:kGET
                           success:^(id responseObject) {
                               
                               BATHotTopicModel * tmpModel = [BATHotTopicModel mj_objectWithKeyValues:responseObject];
                               
                               if (self.RightCurrentPage == 0) {
                                   [self.rightDataArray removeAllObjects];
                               }
                               for (HotTopicData *data in tmpModel.Data) {
                                   data.isAudio = self.isAudio;
                                   data.isShowTime = YES;
                               }
                               [self.rightDataArray addObjectsFromArray:tmpModel.Data];
                               [self.topicTab reloadData];
                               
                               self.allContentCount = tmpModel.RecordsCount;
                               
                               BATTopicScorListCell * ScrollCell = (BATTopicScorListCell *)[self.topicTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                               [ScrollCell.leftTab.mj_footer endRefreshing];
                               
                           } failure:^(NSError *error) {
                               
                               
                           }];
    
    
}



#pragma mark - Lazy Load
- (BATPassTableView *)topicTab {

    if (!_topicTab) {
        _topicTab = [[BATPassTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _topicTab.delegate = self;
        _topicTab.dataSource = self;
        _topicTab.scrollEnabled = NO;
        _topicTab.showsVerticalScrollIndicator = NO;
        [_topicTab registerClass:[BATTapicListCell class] forCellReuseIdentifier:@"BATTapicListCell"];
        [_topicTab registerClass:[BATTopicScorListCell class] forCellReuseIdentifier:@"BATTopicScorListCell"];
    }
    return _topicTab;
}

@end
