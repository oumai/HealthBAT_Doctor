//
//  BATChatViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATChatViewController.h"
#import "KMChatHeaderCollectionReusableView.h"
#import "BATNotificationMessage.h"
#import "BATDoctorDetailModel.h"
#import "IQKeyboardManager.h"

@interface BATChatViewController ()

@end

@implementation BATChatViewController

- (void)dealloc
{
    DDLogDebug(@"%s",__func__);
    
    [[BATRongCloudManager sharedBATRongCloudManager] setEndIMBlock:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //sectionHeaderView
    [self.conversationMessageCollectionView registerNib:[UINib nibWithNibName:@"KMChatHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KMChatHeaderCollectionReusableView"];
    
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_LOCATION_TAG];
    
    self.displayUserNameInCell = NO;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber - self.unReadMessage;
    
    WEAK_SELF(self);
    [[BATRongCloudManager sharedBATRongCloudManager] setEndIMBlock:^(NSString *orderNo){
        STRONG_SELF(self);
        if (![orderNo isEqualToString:self.orderNo]) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ConsultStatus = 2;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BATUpdateConsultStatusNotification" object:@{@"orderNo":self.orderNo,@"consultStatus":@(self.ConsultStatus)}];
            
            [self updateUI];
        });
        

    }];
    
    if (self.ConsultStatus == 2) {
        self.chatSessionInputBarControl.hidden = YES;
    } else {
        if (!self.isFamilyService) {
//            WEAK_SELF(self);
//            UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"结束咨询" style:UIBarButtonItemStyleDone handler:^(id sender) {
//                
//                STRONG_SELF(self);
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否结束问诊" message:@"感谢您的信任和支持，如结束咨询，请对我的服务进行评价。" preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction *goOnAction = [UIAlertAction actionWithTitle:@"继续咨询" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                    
//                }];
//                
//                UIAlertAction *endAction = [UIAlertAction actionWithTitle:@"结束咨询" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                    
//                    BATNotificationMessage *messageContent = [BATNotificationMessage messageWithActionStatus:[NSString stringWithFormat:@"%ld",batDoctorStudioTextImageStatus_DoctorAskOver] orderNo:self.orderNo targetId:self.targetId doctorName:[BATRongCloudManager sharedBATRongCloudManager].bat_getRongCloudUserInfo.name patientName:self.title];
//                    
//                    [[BATRongCloudManager sharedBATRongCloudManager] bat_sendRongCloudMessageWithType:ConversationType_GROUP targetId:self.targetId content:messageContent pushContent:[NSString stringWithFormat:@"%@医生请求结束咨询",[BATRongCloudManager sharedBATRongCloudManager].bat_getRongCloudUserInfo.name] pushData:nil success:^(long messageId) {
//                        
//                        //                    [self showSuccessWithText:@"请等待患者确定"];
//                        
//                    } error:^(RCErrorCode nErrorCode, long messageId) {
//                        
//                    }];
//                    
//                }];
//                
//                // Add the actions.
//                [alertController addAction:goOnAction];
//                [alertController addAction:endAction];
//                
//                [self presentViewController:alertController animated:YES completion:nil];
//                
//                
//            }];
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setFrame:CGRectMake(0, 0, 80, 40)];
            [closeBtn setTitle:@"结束咨询" forState:UIControlStateNormal];
            [closeBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
            
            self.navigationItem.rightBarButtonItem = closeBarButtonItem;
        }
    }
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
- (void)updateUI
{
    if (self.ConsultStatus == 2) {
        self.chatSessionInputBarControl.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
        [self.view endEditing:YES];
    }
}

- (void)closeBtnAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否结束问诊" message:@"感谢您的信任和支持，如结束咨询，请对我的服务进行评价。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *goOnAction = [UIAlertAction actionWithTitle:@"继续咨询" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *endAction = [UIAlertAction actionWithTitle:@"结束咨询" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        BATNotificationMessage *messageContent = [BATNotificationMessage messageWithActionStatus:[NSString stringWithFormat:@"%ld",batDoctorStudioTextImageStatus_DoctorAskOver] orderNo:self.orderNo targetId:self.targetId doctorName:[BATRongCloudManager sharedBATRongCloudManager].bat_getRongCloudUserInfo.name patientName:self.title];
        
        [[BATRongCloudManager sharedBATRongCloudManager] bat_sendRongCloudMessageWithType:ConversationType_GROUP targetId:self.targetId content:messageContent pushContent:[NSString stringWithFormat:@"%@医生请求结束咨询",[BATRongCloudManager sharedBATRongCloudManager].bat_getRongCloudUserInfo.name] pushData:nil success:^(long messageId) {
            
            //                    [self showSuccessWithText:@"请等待患者确定"];
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
        
    }];
    
    // Add the actions.
    [alertController addAction:goOnAction];
    [alertController addAction:endAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isFamilyService) {
        KMChatHeaderCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"KMChatHeaderCollectionReusableView" forIndexPath:indexPath];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"病症描述：" forKey:@"title"];
        [dic setObject:self.IllnessDescription forKey:@"detail"];
        [dic setObject:self.images forKey:@"images"];
        
        [sectionHeaderView reloadHeader:dic complete:^{
            
        }];
        
        return sectionHeaderView;
    }
    return nil;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (!self.isFamilyService) {
        return [self calHeaderViewSize];
    }
    return CGSizeZero;
}

#pragma mark 计算headerView size
- (CGSize )calHeaderViewSize
{
    //计算标题size
    
    CGFloat titleHeight = [Tools calculateHeightWithText:@"病症描述:" width:SCREEN_WIDTH - 40.0f font:[UIFont systemFontOfSize:15]];
    
    //计算详情size
    CGFloat detailHeight = [Tools calculateHeightWithText:self.IllnessDescription width:SCREEN_WIDTH - 40.0f font:[UIFont systemFontOfSize:15]];
    
    //计算collection size
    NSArray *pics = self.images;
    
    float picCollectionHeight = 0;
    
    //列数 图片在collectionview 上显示多少列
    NSInteger column = 0;
    
    //计算列数
    //1、默认是6列
    //2、MainScreenWidth - 40 - 50，40为collectionview左右距离supview的长度总和，50为默认6列时，item的间隔宽度总和
    //3、((int)MainScreenWidth - 90) % 50 == 0 求余，判断是否能显示6列，如不能整除就列数减一
    //4、得出最终的列数
    if (((int)SCREEN_WIDTH - 90) % 50 > 0) {
        column = ((int)SCREEN_WIDTH - 90) / 50;
    } else {
        column = ((int)SCREEN_WIDTH - 90) / 50 - 1;
    }
    
    //计算行数
    NSInteger row = 0;
    
    //图片求余 得出行数
    if (pics.count % column == 0) {
        row = pics.count / column;
    } else {
        row = pics.count / column + 1;
    }
    
    //计算collection size height
    picCollectionHeight = row * 50 + 10 * (row - 1);
    
    //10-10-标题高度-8-详情高度-8-图片collection-10-10
    return CGSizeMake(SCREEN_WIDTH, 10 + 10 + titleHeight + 8 + detailHeight + 8 + picCollectionHeight + 10 + 10);
    
}

#pragma mark - 重载
- (void)didSendMessage:(NSInteger)stauts content:(RCMessageContent *)messageCotent
{
    [super didSendMessage:stauts content:messageCotent];
    
    if (stauts == 0 && self.ConsultStatus == 4 && ![messageCotent isMemberOfClass:[BATNotificationMessage class]]) {
        [self requestUpdateConsultStatus];
    }
}

#pragma mark - Net

- (void)requestUpdateConsultStatus
{
    [HTTPTool requestWithURLString:@"/api/order/UpdateConsultStatus" parameters:@{@"orderNo":self.orderNo} type:kGET success:^(id responseObject) {
        
        self.ConsultStatus = 1;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATUpdateConsultStatusNotification" object:@{@"orderNo":self.orderNo,@"consultStatus":@(self.ConsultStatus)}];
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

@end
