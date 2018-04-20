//
//  BATAppDelegate+BATResetLogin.m
//  HealthBAT_Pro
//
//  Created by KM on 16/8/222016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATAppDelegate+BATResetLogin.h"
#import "BATLoginModel.h"
#import "BATPerson.h"
#import "SVProgressHUD.h"
#import "SFHFKeychainUtils.h"
#import "BATTIMDataModel.h"

@implementation BATAppDelegate (BATResetLogin)

- (void)bat_LoginWithUserName:(NSString *)userName password:(NSString *)password Success:(void(^)(void))success failure:(void(^)(NSError * error))failure {

    [HTTPTool requestWithURLString:@"/api/NetworkMedical/Login"
                        parameters:@{
                                     @"AccountName":userName,
                                     @"PhoneNumber":@"",
                                     @"PassWord":password,
                                     @"LoginType":@"1"
                                     }
                              type:kPOST
                           success:^(id responseObject) {

                               BATLoginModel * login = [BATLoginModel mj_objectWithKeyValues:responseObject];

                               if (login.ResultCode == 0) {
                                   //登录成功
                                   [self successActionWithLogin:login userName:userName password:password];

                                   if (success) {
                                       success();
                                   }
                               }
                           }
                           failure:^(NSError *error) {

                               if (failure) {
                                   failure(error);
                               }
                           }];
}

- (void)bat_autoLoginSuccess:(void(^)(void))success failure:(void(^)(void))failure {

    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGIN_NAME"];
    NSError *error;
    NSString * password = [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:ServiceName error:&error];
    if(error){
        DDLogError(@"从Keychain里获取密码出错：%@",error);
        return;
    }

    if (!password || !userName) {
        //密码或者用户名未获取到，退出登录
        [self bat_logout];
        return;
    }

    [self bat_LoginWithUserName:userName password:password Success:^{

        if (success) {
            success();
        }
    } failure:^(NSError *error) {

        [self bat_logout];
        if (failure) {
            failure();
        }
    }];
}

- (void)successActionWithLogin:(BATLoginModel *)login userName:(NSString *)userName password:(NSString *)password {
    
    //保存密码
    NSError  *error;
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"LOGIN_NAME"];
    BOOL saved = [SFHFKeychainUtils storeUsername:userName andPassword:password forServiceName:ServiceName updateExisting:YES error:&error];
    if(!saved){
        DDLogError(@"保存密码时出错：%@",error.localizedDescription);
    }
    
    //改变登录状态
    SET_LOGIN_STATION(YES);
    
    //保存登录信息
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLogin.data"];
    [NSKeyedArchiver archiveRootObject:login toFile:file];
    [[NSUserDefaults standardUserDefaults] setValue:login.Data.Token forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    //获取个人信息
//    [self personInfoListRequest];
    
    //设置极光推送别名
    [[BATJPushManager sharedJPushManager] setAlias:[NSString stringWithFormat:@"BAT%ld",(long)login.Data.ID]];
    
}

//获取个人信息
- (void)personInfoListRequest {

    [HTTPTool requestWithURLString:@"/api/Patient/Info" parameters:nil type:kGET success:^(id responseObject) {

        BATPerson * person = [BATPerson mj_objectWithKeyValues:responseObject];
        if (person.ResultCode == 0) {

            //保存登录信息
            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"];
            [NSKeyedArchiver archiveRootObject:person toFile:file];
        }
    } failure:^(NSError *error) {
        
    }];
}

//重置登陆状态
- (void)bat_logout {

    DDLogDebug(@"退出登录");
    SET_LOGIN_STATION(NO);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Login_Out_Hidden_Consultion_Order_Data" object:nil];


    //发送推出登陆的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APPLICATION_LOGOUT" object:nil];

    //登出融云
    [[BATRongCloudManager sharedBATRongCloudManager] bat_loginOutRongCloud];

    //极光清除别名
    [[BATJPushManager sharedJPushManager] setAlias:@""];

    //清除本地数据
    [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLogin.data"] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DoctorDetail.data"] error:nil];

    //清楚token
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    //清除缓存
    [self cleanCacheAndCookie];

    //清楚推送
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[BATLoginViewController alloc] init]] animated:NO completion:^{
        [SVProgressHUD showSuccessWithStatus:@"退出登录"];

        //界面跳转
        
        
        [self.sideMenuViewController hideMenuViewController];
        
        UINavigationController *navVC = (UINavigationController *)self.sideMenuViewController.contentViewController;
        
        [navVC popToRootViewControllerAnimated:YES];
        
//        BATRootTabBarController *rootTabBar = (BATRootTabBarController *)self.window.rootViewController;
//        for (UINavigationController * nav in rootTabBar.viewControllers) {
//            
//            [nav popToRootViewControllerAnimated:YES];
//        }
        
//        rootTabBar.selectedIndex = 0;
    }];

    
//    [self bk_performBlock:^(id obj) {
//        
//
//    } afterDelay:0.5];
    


//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[BATLoginViewController new]];
//    [rootTabBar presentViewController:nav animated:YES completion:nil];
//    [self performSelector:@selector(backHome) withObject:nil afterDelay:1];
}

- (void)backHome {
    BATRootTabBarController *rootTabBar = (BATRootTabBarController *)self.window.rootViewController;
    [rootTabBar setSelectedIndex:0];
}

- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}


@end
