//
//  BATAppDelegate+BATAgora.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAppDelegate+BATAgora.h"
#import "BATCallViewController.h"
#import "BATChannelModel.h"

@implementation BATAppDelegate (BATAgora)

- (void)bat_registerAgora
{
    //注册引擎
    [[BATAgoraManager shared] registerAgora];
    //注册信令
    [[BATAgoraSignalingManager shared] registerAgoraSignaling];
    
    [BATAgoraSignalingManager shared].delegate = self;
}

#pragma mark - Net
#pragma mark - 获取channelkey
- (void)requestGetChannelKey:(NSString *)chatRoomId complete:(void(^)(BOOL success,NSString *channelKey))complete
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetChannelKey" parameters:@{@"chatRoomId":chatRoomId} type:kGET success:^(id responseObject) {
        
        
        BATChannelModel *channelModel = [BATChannelModel mj_objectWithKeyValues:responseObject];
        
        if (complete) {
            complete(YES,channelModel.Data);
        }
        
    } failure:^(NSError *error) {
        if (complete) {
            complete(NO,nil);
        }
    }];
}


#pragma mark - BATAgoraSignalingManagerDelegate

- (void)inviteReceived:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    //接收到呼叫时
    [self requestGetChannelKey:channel complete:^(BOOL success, NSString *channelKey) {
        
        if (success && channelKey != nil && ![channelKey isEqualToString:@""]) {
            
            
            NSDictionary *dic = [Tools dictionaryWithJsonString:extra];
            
            BATCallViewController *callVC = [[BATCallViewController alloc] init];
            
            callVC.callState = BATCallState_Answer;
            
            if (dic.allKeys.count > 0) {
                callVC.avatar = dic[@"PhotoPath"] != nil ? dic[@"PhotoPath"] : @"";
                callVC.userName = dic[@"Name"] != nil ? dic[@"Name"] : @"";
                callVC.orderNo = dic[@"OrderNo"] != nil ? dic[@"OrderNo"] : @"";
            }
            

            callVC.accountID = name;
            callVC.channelKey = channelKey;
            callVC.roomID = channel;
            
            [self.window.rootViewController presentViewController:callVC animated:YES completion:nil];

        }
        
    }];
}

- (void)inviteReceivedByPeer:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    //对方已收到呼叫
    [self requestGetChannelKey:channel complete:^(BOOL success, NSString *channelKey) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallJoinChannelNotification" object:channelKey];
        });
        
//        if (success && channelKey != nil && ![channelKey isEqualToString:@""]) {
//            BATCallViewController *callVC = [[BATCallViewController alloc] init];
//            
//            callVC.callState = BATCallState_Answer;
//            callVC.avatar = @"";
//            callVC.userName = @"测试用户";
//            callVC.accountID = name;
//            callVC.channelKey = channelKey;
//            callVC.roomID = channel;
//            
//            [self.window.rootViewController presentViewController:callVC animated:YES completion:nil];
//            
//        }
        
    }];
    
}

- (void)inviteAcceptedByPeer:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    //对方接受呼叫
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallAcceptNotification" object:nil];
    });
    
}

- (void)inviteRefusedByPeer:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    //对方已拒绝呼叫
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallRefusedByPeerNotification" object:nil];
    });
    
}

- (void)inviteEndByMyself:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    //自己结束呼叫
    
    //离开信令频道
    [[BATAgoraSignalingManager shared] channelLeave:channel];
    
    //离开引擎频道
    [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
        
    }];

    
}

- (void)inviteEndByPeer:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid extra:(NSString *)extra
{
    
    if (![[BATAgoraSignalingManager shared].channelID isEqualToString:channel] && [BATAgoraSignalingManager shared].channelID != nil) {
        return;
    }
    
    //对方已结束呼叫
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallEndByPeerNotification" object:nil];
    });
    
    //离开信令频道
    [[BATAgoraSignalingManager shared] channelLeave:channel];
    
    //离开引擎频道
    [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
        
    }];
    
    
//    [[BATAgoraSignalingManager shared] channelQueryUserNum:channel complete:^(NSString *channelID, AgoraEcode ecode, int num) {
//        if (num > 1) {
//            //对方已结束呼叫
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallEndByPeerNotification" object:nil];
//            });
//            
//            //离开信令频道
//            [[BATAgoraSignalingManager shared] channelLeave:channel];
//            
//            //离开引擎频道
//            [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
//                
//            }];
//        }
//    }];
    

}

- (void)inviteFailed:(NSString *)channel name:(NSString *)name uid:(uint32_t)uid ecode:(AgoraEcode)ecode extra:(NSString *)extra
{
    //呼叫失败
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BATCallFailedNotification" object:nil];
    });
    
    //离开信令频道
    [[BATAgoraSignalingManager shared] channelLeave:channel];
    
    //离开引擎频道
    [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
        
    }];
}


@end
