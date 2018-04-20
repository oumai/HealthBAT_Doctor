//
//  BATAgoraManager.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/12.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAgoraManager.h"

@interface BATAgoraManager () <AgoraRtcEngineDelegate>

@property (nonatomic,strong) UIView *remoteView;

@end

@implementation BATAgoraManager

+ (BATAgoraManager *)shared
{
    static BATAgoraManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BATAgoraManager alloc] init];
    });
    return instance;
}

- (void)registerAgora
{
    
    NSString *appId = nil;
#ifdef DEBUG
    //AppStore开发 com.KmHealthBAT.Doctor.app
    appId = @"1a1a51431ae040ef8b02ee4dd7a5ba82";
#elif TESTING
    //AppStore测试 com.KmHealthBAT.Doctor.app
    appId = @"1a1a51431ae040ef8b02ee4dd7a5ba82";
#elif PUBLICRELEASE
    //企业版开发 com.KmHealthBAT.Doctor.Enterprise.app
    appId = @"1a1a51431ae040ef8b02ee4dd7a5ba82";
#elif PRERELEASE
    //企业版发布 com.KmHealthBAT.Doctor.Enterprise.app
    appId = @"764a4f09065d453e9f21727a241db460";
#elif ENTERPRISERELEASE
    //企业版发布 com.KmHealthBAT.Doctor.Enterprise.app
    appId = @"764a4f09065d453e9f21727a241db460";
#elif RELEASE
    //AppStore发布 com.KmHealthBAT.Doctor.app
    appId = @"764a4f09065d453e9f21727a241db460";
#endif
    
    self.agoraRtcEngineKit = [AgoraRtcEngineKit sharedEngineWithAppId:appId delegate:self];
    
    
    [self.agoraRtcEngineKit setChannelProfile:AgoraRtc_ChannelProfile_Communication];
    
    [self.agoraRtcEngineKit enableLastmileTest];
}

- (void)openAudio:(BOOL)flag
{
    if (flag) {
        [self.agoraRtcEngineKit enableAudio];
    } else {
        [self.agoraRtcEngineKit disableAudio];
    }
}

- (void)openVideo:(BOOL)flag
{
    if (flag) {
        [self.agoraRtcEngineKit enableVideo];
        [self.agoraRtcEngineKit setVideoProfile:AgoraRtc_VideoProfile_360P swapWidthAndHeight:false];
    } else {
        [self.agoraRtcEngineKit disableVideo];
    }
}

- (void)setupLocalVideo:(UIView *)localView
{
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    
    videoCanvas.view = localView;
    videoCanvas.renderMode = AgoraRtc_Render_Adaptive;
    [self.agoraRtcEngineKit setupLocalVideo:videoCanvas];
}

- (void)setupRemoteVideo:(UIView *)remoteView
{
    self.remoteView = remoteView;
}

- (void)startPreview
{
    [self.agoraRtcEngineKit startPreview];
}

- (void)stopPreview
{
    [self.agoraRtcEngineKit stopPreview];
}

- (void)switchCamera
{
    [self.agoraRtcEngineKit switchCamera];
}

- (void)joinCahannel:(NSString *)key channelName:(NSString *)channelName info:(NSString *)info uid:(NSUInteger)uid joinSuccess:(void (^)(NSString *, NSUInteger, NSInteger))joinChannelSuccessBlock
{
    [self.agoraRtcEngineKit joinChannelByKey:key channelName:channelName info:info uid:uid joinSuccess:joinChannelSuccessBlock];
}

- (void)leaveChannel:(void (^)(AgoraRtcStats *))leaveChannelBlock
{
    [self.agoraRtcEngineKit leaveChannel:leaveChannelBlock];
}

#pragma mark - AgoraRtcEngineDelegate
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraRtcWarningCode)warningCode
{
    //发生警告回调
    DDLogDebug(@"声网引擎发生警告");
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraRtcErrorCode)errorCode
{
    //发生错误回调
    DDLogDebug(@"声网引擎发生错误");
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed
{
    //加入频道成功回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRejoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed
{
    //重新加入频道回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed
{
    //本地首帧视频显示回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed
{
    //远端首帧视频接收解码回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoFrameOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed
{
    //远端首帧视频显示回调
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    
    videoCanvas.view = self.remoteView;
    videoCanvas.renderMode = AgoraRtc_Render_Adaptive;
    [self.agoraRtcEngineKit setupLocalVideo:videoCanvas];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed
{
    //用户加入回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraRtcUserOfflineReason)reason
{
    //用户离线回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid
{
    //用户停止/重新发送视频回调
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine lastmileQuality:(AgoraRtcQuality)quality
{
    //网络质量回调
//    
//    if (self.listenNetworkQuality) {
//        [self.agoraRtcEngineKit disableLastmileTest];
//        self.listenNetworkQuality(quality);
//    }
}

@end
