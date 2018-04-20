//
//  BATCallViewController.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATCallViewController.h"
#import "BATAgoraSignalingManager.h"
#import "BATAgoraManager.h"
#import "BATDoctorDetailModel.h"
#import "BATLoginModel.h"

@interface BATCallViewController ()

//计时器
@property (strong, nonatomic) NSTimer *durationTimer;

//持续时间
@property (nonatomic) NSUInteger duration;

@property (nonatomic,assign) NSInteger callTime;

@property (nonatomic,strong) NSTimer *callTimer;

@end

@implementation BATCallViewController

- (void)dealloc
{
    DDLogDebug(@"%s",__func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinChannel:) name:@"BATCallJoinChannelNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endByPeer:) name:@"BATCallEndByPeerNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refusedByPeer:) name:@"BATCallRefusedByPeerNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callFail:) name:@"BATCallFailedNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callAccept:) name:@"BATCallAcceptNotification" object:nil];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_durationTimer != nil) {
        [_durationTimer invalidate];
        _durationTimer = nil;
    }
    
    if (self.callTimer != nil) {
        [self.callTimer invalidate];
        self.callTimer = nil;
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
    [self.callView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar] placeholderImage:nil];
    self.callView.nameLabel.text = self.userName;
    
    [self updateUI];
    
    if (self.callState == BATCallState_Call) {
        
        //主动呼叫
        [self channelInviterUser];
        self.callTime = 0;
        WEAK_SELF(self);
        self.callTimer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0f block:^(NSTimer *timer) {
            STRONG_SELF(self);
            self.callTime ++;
            
            if (self.callTime == 120) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallFailedNotification" object:nil];
                
                [timer invalidate];
                timer = nil;
            }
            
        } repeats:YES];
        
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
/**
 *  时间变更
 */
- (void)updateTalkTimeLabel
{
    self.duration++;
    NSUInteger seconds = self.duration % 60;
    NSUInteger minutes = (self.duration - seconds) / 60;
    NSUInteger hours = self.duration / 3600;
    self.callView.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(unsigned long)hours, (unsigned long)minutes, (unsigned long)seconds];
}

- (void)updateUI
{
    
    if (self.callState == BATCallState_Call) {
        self.callView.callStateLabel.text = @"等待对方接听......";
        self.callView.cancelButton.titleLabel.text = @"取消";
        self.callView.callStateLabel.hidden = NO;
//        self.callView.networkStateView.hidden = NO;
        self.callView.timeLabel.hidden = YES;
        self.callView.cancelButton.hidden = NO;
        self.callView.hangUpButton.hidden = YES;
        self.callView.answerButton.hidden = YES;
        
    } else if (self.callState == BATCallState_Answer) {
        self.callView.callStateLabel.text = @"正在呼叫你，是否接通";
        
        self.callView.callStateLabel.hidden = NO;
//        self.callView.networkStateView.hidden = YES;
        self.callView.timeLabel.hidden = YES;
        self.callView.cancelButton.hidden = YES;
        self.callView.hangUpButton.hidden = NO;
        self.callView.answerButton.hidden = NO;
    } else if (self.callState == BATCallState_Calling) {
        self.callView.callStateLabel.text = @"";
        self.callView.cancelButton.titleLabel.text = @"挂断";
        self.callView.callStateLabel.hidden = YES;
//        self.callView.networkStateView.hidden = NO;
        self.callView.timeLabel.hidden = NO;
        self.callView.cancelButton.hidden = NO;
        self.callView.hangUpButton.hidden = YES;
        self.callView.answerButton.hidden = YES;
    }
    

}

/**
 加入引擎频道
 */
- (void)joinChannel:(NSNotification *)notif
{
    
    self.channelKey = [notif object];
    
    BATLoginModel *loginModel = LOGIN_INFO;
    
    [[BATAgoraManager shared] joinCahannel:self.channelKey channelName:self.roomID info:@"" uid:loginModel.Data.ID joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
        DDLogDebug(@"加入引擎频道成功");
        
    }];
}

/**
 对方结束呼叫

 @param notif 通知数据
 */
- (void)endByPeer:(NSNotification *)notif
{
    
    if (self.callTimer != nil) {
        [self.callTimer invalidate];
        self.callTimer = nil;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"患者已退出诊室" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:^{
        WEAK_SELF(self);

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONG_SELF(self);
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

/**
 对方拒绝呼叫

 @param notif 通知数据
 */
- (void)refusedByPeer:(NSNotification *)notif
{
    if (self.callTimer != nil) {
        [self.callTimer invalidate];
        self.callTimer = nil;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"对方正忙" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        WEAK_SELF(self);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONG_SELF(self);
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

/**
 呼叫失败

 @param notif 通知数据
 */
- (void)callFail:(NSNotification *)notif
{
    if (self.callTimer != nil) {
        [self.callTimer invalidate];
        self.callTimer = nil;
    }
    
    //结束呼叫
    [[BATAgoraSignalingManager shared] channelInviteEnd:self.roomID account:self.accountID];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"对方正忙" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        WEAK_SELF(self);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            STRONG_SELF(self);
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

/**
 对方接受呼叫

 @param notif 通知数据
 */
- (void)callAccept:(NSNotification *)notif
{
    
    if (self.callTimer != nil) {
        [self.callTimer invalidate];
        self.callTimer = nil;
    }
    
    self.callState = BATCallState_Calling;
    [self updateUI];
    
    [self requestUpdateConsultStatus];
    
    self.duration = 0;
    self.callView.timeLabel.text = [NSString stringWithFormat:@"00:00:00"];
    _durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTalkTimeLabel) userInfo:nil repeats:YES];
    
//    [BATAgoraManager shared].listenNetworkQuality = ^(AgoraRtcQuality quality) {
//        
//        if (quality == AgoraRtc_Quality_Good || quality == AgoraRtc_Quality_Excellent) {
//            self.callView.networkStateView.networkStateLabel.text = @"网络状态良好";
//            self.callView.networkStateView.networkStateImageView.image = [UIImage imageNamed:@"img-ll-3"];
//        } else {
//            self.callView.networkStateView.networkStateLabel.text = @"网络状态不好";
//            self.callView.networkStateView.networkStateImageView.image = [UIImage imageNamed:@"img-ll-1"];
//        }
//        
//    };
}

/**
 呼叫用户
 */
- (void)channelInviterUser
{
    BATDoctorDetailModel *doctorDetailModel = DoctorDetail_INFO;
    
    NSDictionary *dic = @{@"Name":doctorDetailModel.Data.DoctorName,
                          @"PhotoPath":doctorDetailModel.Data.DoctorPic,
                          @"OrderNo":self.orderNo,
                          @"HospitalName":doctorDetailModel.Data.HospitalName,
                          @"DepartmentName":doctorDetailModel.Data.DepartmentName,
                          @"DoctorTitle":doctorDetailModel.Data.DoctorTitle};
    
    NSString *extra = [Tools dataTojsonString:dic];
    
    [[BATAgoraSignalingManager shared] channelJoin:self.roomID complete:^(BOOL success) {
        if (success) {
            [[BATAgoraSignalingManager shared] channelInviteUser2:self.roomID account:self.accountID extra:extra];
        } else {
            [self showText:@"对方正忙"];
            
            if (self.callTimer != nil) {
                [self.callTimer invalidate];
                self.callTimer = nil;
            }
            
        }
    }];
    
}

#pragma mark - Net

- (void)requestUpdateConsultStatus
{
    [HTTPTool requestWithURLString:@"/api/order/UpdateConsultStatus" parameters:@{@"orderNo":self.orderNo} type:kGET success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        [self showErrorWithText:error.localizedDescription];
    }];
}

#pragma mark - pageLayout
- (void)pageLayout
{
    [self.view addSubview:self.callView];
    
    WEAK_SELF(self);
    [self.callView mas_makeConstraints:^(MASConstraintMaker *make) {
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - get & set
- (BATCallView *)callView
{
    if (_callView == nil) {
        _callView = [[BATCallView alloc] init];
        
        WEAK_SELF(self);
        _callView.cancelButton.callOptBlock = ^{
            
            STRONG_SELF(self);
            
            if (self.callState == BATCallState_Calling) {
                
                //挂断
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出将结束当前诊断订单?" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    //结束呼叫
                    [[BATAgoraSignalingManager shared] channelInviteEnd:self.roomID account:self.accountID];
                }];
                
                
                [alertController addAction:cancelAction];
                [alertController addAction:confirmAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            } else if (self.callState == BATCallState_Call) {
                
                //取消
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                //结束呼叫
                [[BATAgoraSignalingManager shared] channelInviteEnd:self.roomID account:self.accountID];
            }
            
        };
        
        _callView.hangUpButton.callOptBlock = ^{
            //挂断
            STRONG_SELF(self);
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[BATAgoraSignalingManager shared] channelInviteRefuse:self.roomID account:self.accountID extra:nil];
            
            //离开信令频道
            [[BATAgoraSignalingManager shared] channelLeave:self.roomID];
            
            //离开引擎频道
            [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
                
            }];
        };
        
        _callView.answerButton.callOptBlock = ^{
            //接听
            STRONG_SELF(self);
            [[BATAgoraSignalingManager shared] channelInviteAccept:self.roomID account:self.accountID];
            
            [self joinChannel:[NSNotification notificationWithName:@"BATCallJoinChannelNotification" object:self.channelKey]];
            
            [self callAccept:[NSNotification notificationWithName:@"BATCallAcceptNotification" object:nil]];
        };
    }
    return _callView;
}

@end
