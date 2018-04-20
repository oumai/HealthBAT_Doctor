//
//  BATAppDelegate+BATSide.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/6/19.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAppDelegate+BATSide.h"

#import "BATDoctorStudioViewController.h"
#import "BATMeViewController.h"

@implementation BATAppDelegate (BATSide)

- (void)bat_side
{
    UINavigationController *centerVC = [[UINavigationController alloc] initWithRootViewController:[[BATDoctorStudioViewController alloc] init]];
    
//    UINavigationController *meVC = [[UINavigationController alloc] initWithRootViewController:[[BATMeViewController alloc] init]];
    
    BATMeViewController *meVC = [[BATMeViewController alloc] init];
    
    self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerVC
                                                                    leftMenuViewController:meVC
                                                                   rightMenuViewController:nil];
    self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    self.sideMenuViewController.delegate = self;
    self.sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    self.sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    self.sideMenuViewController.contentViewShadowOpacity = 0.6;
    self.sideMenuViewController.contentViewShadowRadius = 12;
    self.sideMenuViewController.contentViewShadowEnabled = YES;
    self.sideMenuViewController.contentViewInLandscapeOffsetCenterX = 30.0f;
    self.sideMenuViewController.contentViewInPortraitOffsetCenterX = 30.0f;
    self.sideMenuViewController.contentViewScaleValue = 0.85f;
    self.sideMenuViewController.scaleBackgroundImageView = NO;
    self.sideMenuViewController.scaleMenuView = NO;
    self.sideMenuViewController.fadeMenuView = NO;
    
    self.window.rootViewController = self.sideMenuViewController;
}


#pragma mark - RESideMenuDelegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    
    if ([menuViewController isKindOfClass:[BATMeViewController class]]) {
        BATMeViewController *meVC = (BATMeViewController *)menuViewController;
        [meVC refreshAvatar];
    }
    
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


@end
