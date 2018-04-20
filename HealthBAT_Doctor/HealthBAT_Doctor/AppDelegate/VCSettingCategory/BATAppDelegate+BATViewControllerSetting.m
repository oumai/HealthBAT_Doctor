//
//  BATAppDelegate+BATViewControllerSetting.m
//  HealthBAT_Pro
//
//  Created by Skyrim on 16/8/15.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "BATAppDelegate+BATViewControllerSetting.h"

#import "Aspects.h"
#import "TZImagePickerController.h"
#import "SVProgressHUD.h"

@implementation BATAppDelegate (BATViewControllerSetting)

- (void)bat_settingVC {
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        UIViewController * vc = aspectInfo.instance;

        if (vc == nil) {
            return ;
        }

        if ([aspectInfo.instance isKindOfClass:NSClassFromString(@"UIInputWindowController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIWindow")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UITabBarController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingControllerNoTouches")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIAlertController")]) {
            //屏蔽一些系统界面

            return ;
        }

        //背景色
        vc.view.backgroundColor = BASE_BACKGROUND_COLOR;

        //导航条标题
        [vc.navigationController.navigationBar setTitleTextAttributes:@{
                                                                        NSForegroundColorAttributeName:UIColorFromHEX(0x333333, 1),
                                                                        NSFontAttributeName:stringFont(20)
                                                                        }];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@""
//                                                                    style:UIBarButtonItemStyleDone
//                                                                   target:nil
//                                                                   action:nil];
//        vc.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_icon"];
//        vc.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_icon"];
//        vc.navigationItem.backBarButtonItem = backItem;

        //返回按钮
        if (vc.navigationController.viewControllers.count > 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 20, 40);
            WEAK_SELF(vc);
            [btn bk_whenTapped:^{
                STRONG_SELF(vc);
                [vc.navigationController popViewControllerAnimated:YES];
            }];
            [btn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            vc.navigationItem.leftBarButtonItem = backItem;
            
            vc.hidesBottomBarWhenPushed = YES;
        }
        
     
        //导航条背景色
        [vc.navigationController.navigationBar setBackgroundImage:[Tools imageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        vc.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:UIColorFromHEX(0xeeeeee, 1)];

        
//        if ([vc isKindOfClass:NSClassFromString(@"RCPhotosPickerController")]) {
//            NSLog(@"subviews %@",vc.navigationController.navigationBar.subviews);
//            for (UIView *subView in vc.navigationController.navigationBar.subviews) {
//                NSLog(@"subView %@",subView);
//            }
//        }
        
    } error:NULL];
}

- (void)bat_VCDissmiss {

    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {

        UIViewController * vc = aspectInfo.instance;
        if (vc == nil) {
            return ;
        }

        if ([aspectInfo.instance isKindOfClass:NSClassFromString(@"UIInputWindowController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIWindow")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UITabBarController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingControllerNoTouches")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIAlertController")]) {
            //屏蔽一些系统界面

            return ;
        }

        [SVProgressHUD dismiss];
        [vc.view endEditing:YES];
    } error:NULL];
}




@end
