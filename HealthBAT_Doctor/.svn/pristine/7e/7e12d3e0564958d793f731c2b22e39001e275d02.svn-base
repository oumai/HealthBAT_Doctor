//
//  BATRongCloudManager.m
//  HealthBAT_Pro
//
//  Created by KM on 17/4/132017.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATRongCloudManager.h"
#import "BATAppDelegate+BATResetLogin.h"
#import "BATNotificationMessage.h"

#import "BATPerson.h"


@implementation BATRongCloudManager

singletonImplemention(BATRongCloudManager)

#pragma mark - 登录/注销
- (void)bat_loginRongCloudWithToken:(NSString *)rongCloudToken
                            success:(void(^)(NSString *userId))success
                              error:(void(^)(RCConnectErrorCode status))error
                     tokenIncorrect:(void(^)(void))tokenIncorrect {
    
    [[RCIM sharedRCIM] connectWithToken:rongCloudToken success:^(NSString *userId) {
        DDLogDebug(@"登陆成功。当前登录的用户ID：%@", userId);
        
        
        self.userInfoDic = [NSMutableDictionary dictionary];
        
        //登录成功设置监听
        //连接状态监听
        [[RCIM sharedRCIM] setConnectionStatusDelegate:[BATRongCloudManager sharedBATRongCloudManager]];
        //接收消息监听
        [[RCIM sharedRCIM] setReceiveMessageDelegate:[BATRongCloudManager sharedBATRongCloudManager]];
        //用户信息策略
        [[RCIM sharedRCIM] setUserInfoDataSource:[BATRongCloudManager sharedBATRongCloudManager]];
        
//        //保存当前用户信息
//        BATPerson *person = PERSON_INFO;
//        RCUserInfo *currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:person.Data.UserName portrait:person.Data.PhotoPath];
//        [[RCIM sharedRCIM] setCurrentUserInfo:currentUserInfo];
//        [self.userInfoDic setObject:currentUserInfo forKey:userId];
        
        if (success) {
            success(userId);
        }
    } error:^(RCConnectErrorCode status) {
        DDLogDebug(@"登陆的错误码为:%ld", (long)status);
        if (error) {
            error(status);
        }
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        DDLogDebug(@"token错误");
        if (tokenIncorrect) {
            tokenIncorrect();
        }
    }];
}

- (void)bat_loginOutRongCloud {
    
    [[RCIM sharedRCIM] logout];
}

- (BOOL)bat_getRongCloudStatus {
    
    if ([[RCIM sharedRCIM] getConnectionStatus] == ConnectionStatus_Connected) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

- (void)bat_setRongCloudDeviceToken:(NSData *)deviceToken
{
    //融云注册token
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

#pragma mark - 用户状态
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    switch (status) {
        case ConnectionStatus_UNKNOWN:
        {
            DDLogDebug(@"未知状态");
        }
            break;
        case ConnectionStatus_Connected:
        {
            DDLogDebug(@"连接成功");
        }
            break;
        case ConnectionStatus_NETWORK_UNAVAILABLE:
        {
            DDLogDebug(@"当前设备网络不可用");
        }
            break;
        case ConnectionStatus_AIRPLANE_MODE:
        {
            DDLogDebug(@"当前设备切换到飞行模式");
        }
            break;
        case ConnectionStatus_Cellular_2G:
        {
            DDLogDebug(@"当前设备切换到 2G（GPRS、EDGE）低速网络");
        }
            break;
        case ConnectionStatus_Cellular_3G_4G:
        {
            DDLogDebug(@"当前设备切换到 3G 或 4G 高速网络");
        }
            break;
        case ConnectionStatus_WIFI:
        {
            DDLogDebug(@"当前设备切换到 WIFI 网络");
        }
            break;
        case ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT:
        {
            //踢下线
            [self showAlertWithMessage:@"您的帐号在另一台设备登录!"];
            
            
            
        }
            break;
        case ConnectionStatus_LOGIN_ON_WEB:
        {
            DDLogDebug(@"当前用户在 Web 端登录");
        }
            break;
        case ConnectionStatus_SERVER_INVALID:
        {
            DDLogDebug(@"服务器异常");
        }
            break;
        case ConnectionStatus_VALIDATE_INVALID:
        {
            DDLogDebug(@"连接验证异常");
        }
            break;
        case ConnectionStatus_Connecting:
        {
            DDLogDebug(@"连接中");
        }
            break;
        case ConnectionStatus_Unconnected:
        {
            DDLogDebug(@"连接失败或未连接");
        }
            break;
        case ConnectionStatus_SignUp:
        {
            DDLogDebug(@"已注销");
        }
            break;
        case ConnectionStatus_TOKEN_INCORRECT:
        {
            DDLogDebug(@"Token无效");
        }
            break;
        case ConnectionStatus_DISCONN_EXCEPTION:
        {
            DDLogDebug(@"与服务器的连接已断开");
        }
            break;
    }
}

- (void)showAlertWithMessage:(NSString *)message {
    
    
    //登出操作
    BATAppDelegate *delegate = (BATAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate bat_logout];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    UIWindow *mainWindow = MAIN_WINDOW;
    [mainWindow.rootViewController.presentedViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 发送消息
- (void)bat_sendRongCloudMessageWithType:(RCConversationType)type
                                targetId:(NSString *)targetId
                                 content:(RCMessageContent *)content
                             pushContent:(NSString *)pushContent
                                pushData:(NSString *)pushData
                                 success:(void(^)(long messageId))success
                                   error:(void(^)(RCErrorCode nErrorCode, long messageId))error {
    
    [[RCIM sharedRCIM] sendMessage:type targetId:targetId content:content pushContent:pushContent pushData:pushData success:^(long messageId) {
        if (success) {
            success(messageId);
        }
    } error:^(RCErrorCode nErrorCode, long messageId) {
        if (error) {
            error(nErrorCode,messageId);
        }
    }];
}


#pragma mark - 接收消息监听
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param nLeft       还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMlib消息监听之后，SDK在接收到消息时候会执行此方法。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 object为您在设置消息接收监听时的key值。
 */


- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    if ([message.content isMemberOfClass:[BATNotificationMessage class]]) {
        BATNotificationMessage *batMsg = (BATNotificationMessage *)message.content;
        BATDoctorStudioTextImageStatus actionType = [batMsg.actionStatus integerValue];
        
        switch (actionType) {
            case batDoctorStudioTextImageStatus_DoctorAskOver:
            {
                //医生请求结束
            }
                break;
            case batDoctorStudioTextImageStatus_PatientAgreeOver:
            {
                //患者同意结束
                
                if (self.endIMBlock) {
                    self.endIMBlock(batMsg.orderNo);
                }
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"患者%@同意结束咨询",batMsg.patientName] message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:okAction];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIWindow *window = MAIN_WINDOW;
                    [window.rootViewController presentViewController:alert animated:YES completion:nil];
                });
                
            }
                break;
            case batDoctorStudioTextImageStatus_PatientCancelOver:
            {
                //患者取消结束
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"患者%@请求继续咨询",batMsg.patientName] message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:okAction];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIWindow *window = MAIN_WINDOW;
                    [window.rootViewController presentViewController:alert animated:YES completion:nil];
                });
            }
                break;
                case batDoctorStudioTextImageStatus_PatientComplain:
            {
                
                if (self.endIMBlock) {
                    self.endIMBlock(batMsg.orderNo);
                }
                
                //患者投诉
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"患者%@已经对您投诉",batMsg.patientName] message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:okAction];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIWindow *window = MAIN_WINDOW;
                    [window.rootViewController presentViewController:alert animated:YES completion:nil];
                });
            }
                break;
        }
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新未读消息
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BATRefreshUnreadNotifcatiion" object:nil];
        });
    }
    
    DDLogDebug(@"还剩余的未接收的消息数：%d", left);
}

#pragma mark - 用户信息策略
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    if ([self.userInfoDic.allKeys containsObject:userId]) {
        RCUserInfo *userInfo = self.userInfoDic[userId];
        if (completion) {
            completion(userInfo);
        }
    }
}

- (void)bat_saveRongCloudUserInfoWithUserId:(NSString *)userId
                                       name:(NSString *)name
                                portraitUri:(NSString *)portraitUri {
    
    RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portraitUri];
    [self.userInfoDic setObject:userInfo forKey:userId];
}

- (RCUserInfo *)bat_getRongCloudUserInfo {
    
    
    return [[RCIM sharedRCIM] currentUserInfo];
}

- (void)bat_saveRongCloudCurrentUserInfo:(NSString *)userId name:(NSString *)name portraitUri:(NSString *)portraitUri
{
    //保存当前用户信息
    RCUserInfo *currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portraitUri];
    [[RCIM sharedRCIM] setCurrentUserInfo:currentUserInfo];
    [self.userInfoDic setObject:currentUserInfo forKey:userId];
}

@end
