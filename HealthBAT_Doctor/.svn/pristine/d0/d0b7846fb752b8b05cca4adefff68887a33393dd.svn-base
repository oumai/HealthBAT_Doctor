//
//  BATAppDelegate.m
//  HealthBAT_Doctor
//
//  Created by KM on 17/4/102017.
//  Copyright © 2017年 KM. All rights reserved.
//

//appDelegate类别
#import "BATAppDelegate+BATXcodeSetting.h"//视图控制器设置
#import "BATAppDelegate+BATViewControllerSetting.h"//xcodeColors设置
#import "BATAppDelegate+BATBaiduMap.h"//百度地图
#import "BATAppDelegate+BATVersion.h"//版本
#import "BATAppDelegate+BATJPushCategory.h"     //极光
#import "BATAppDelegate+BATResetLogin.h"//登录
#import "BATAppDelegate+BATDoctorStatus.h"//医生
#import "BATAppDelegate+BATRongCloud.h"
#import "BATAppDelegate+BATAgora.h"
#import "BATAppDelegate+BATSide.h"
#import "BATAppDelegate+BATTableView.h"

#import "IQKeyboardManager.h"//键盘管理
#import "SVProgressHUD.h"//提示框

#import "HTTPTool+BATDomainAPI.h"//获取域名

@interface BATAppDelegate ()

@end

@implementation BATAppDelegate

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //支付宝 appId ： 2016092101939879
    
    //获取最新的域名
    [HTTPTool getDomain];
    
    //第三方ui控件设置
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//设置HUD的Style
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];//设置HUD和文本的颜色
    [SVProgressHUD setBackgroundColor:UIColorFromRGB(0, 0, 0, 0.3)];//设置HUD的背景颜色
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[BATRootTabBarController alloc] init];
    
    [self bat_side];
    
    //iOS11 tableview
    [self cancelTableViewAdjust];
    
    [self.window makeKeyAndVisible];
    
    //设置VC
    [self bat_settingVC];
    [self bat_VCDissmiss];
    
    //设置XcodeColors
    [self bat_setXcodeColorsConfigration];
    
    //启动百度地图
    [self bat_startBaiduMap];
    [self bat_getLocation];
    
    //融云
    [self bat_initRongCloud];
    
    //声网
    [self bat_registerAgora];
    
    //初始化JPush
    [self bat_registerAPNS];
    [self bat_registerJPush:launchOptions];
    if (launchOptions && [launchOptions.allKeys containsObject:UIApplicationLaunchOptionsRemoteNotificationKey]) {
        // do something else
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_PUSH_MESSAGE_VC" object:nil];
//        });
    }
    
    //设置角标0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //获取个人信息
    //重新登陆
    if (LOGIN_STATION) {
        [self bat_autoLoginSuccess:^{
            [self getDoctorStatus:^(BATAuditingType type,BATDoctorStatusModel *doctorStatusModel) {
                switch (type) {
                    case BATAuditingType_NotOpen:
                    case BATAuditingType_PendingReview:
                    case BATAuditingType_ReviewFail:
                    case BATAuditingType_Close:
                        //未开通工作室，待审核/审核中，审核不通过，关闭工作室
                        [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[BATLoginViewController alloc] init]] animated:NO completion:nil];
                        break;
                    case BATAuditingType_ReviewSuccess:
                        
                        //连接融云
                        [[BATRongCloudManager sharedBATRongCloudManager] bat_loginRongCloudWithToken:doctorStatusModel.Data.RongCloudToken success:^(NSString *userId) {
                            
                        } error:^(RCConnectErrorCode status) {
                            
                        } tokenIncorrect:^{
                            
                        }];
                        
                        //登录声网信令
                        [[BATAgoraSignalingManager shared] login:doctorStatusModel.Data.DoctorID token:doctorStatusModel.Data.AgoraToken deviceID:@"" complete:^(BOOL success) {
                            
                        }];

                        
                        break;
                    default:
                        break;
                }
            }];
            
        } failure:^{
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[BATLoginViewController alloc] init]] animated:NO completion:nil];
        }];
    }
    else {
        [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[BATLoginViewController alloc] init]] animated:NO completion:nil];
    }
    
    
    //获取地理位置信息的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bat_getLocation) name:@"BEGIN_GET_LOCATION" object:nil];
    
    //接口返回－2，登录失败，重置登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bat_logout) name:@"LOGIN_FAILURE" object:nil];
    
    //监控网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.jkbat.com"];
    [reach startNotifier];
    
    
#ifdef ENTERPRISERELEASE
    //企业版更新
//    [self bat_versionEnterprise];
#elif RELEASE
    //AppStore更新
//    [Tools updateVersion];
#endif
   
    return YES;
}

- (void)reachabilityChanged:(NSNotification *)noti {
    
    BOOL isNetwork = YES;
    
    Reachability *reachability = [noti object];
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus) {
        case NotReachable:
            DDLogDebug(@"无网络");
            isNetwork = NO;
            [[NSUserDefaults standardUserDefaults] setBool:isNetwork forKey:@"netStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"APP_NOT_NET_STATION" object:nil];
            
            break;
        case ReachableViaWiFi:
            DDLogDebug(@"wifi网络");
            isNetwork = YES;
            [[NSUserDefaults standardUserDefaults] setBool:isNetwork forKey:@"netStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case ReachableViaWWAN:
            DDLogDebug(@"移动网络");
            isNetwork = YES;
            [[NSUserDefaults standardUserDefaults] setBool:isNetwork forKey:@"netStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BATRefreshOnlineLearningInterfaceNotification object:@(isNetwork)];
}

#pragma mark - Application
- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //后台运行
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self bat_getLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //离开引擎频道
    [[BATAgoraManager shared] leaveChannel:^(AgoraRtcStats *stat) {
        
    }];
    
}


@end
