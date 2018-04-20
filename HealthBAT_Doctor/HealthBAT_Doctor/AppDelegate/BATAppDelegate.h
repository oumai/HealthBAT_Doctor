//
//  BATAppDelegate.h
//  HealthBAT_Doctor
//
//  Created by KM on 17/4/102017.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATRootTabBarController.h"
#import "RESideMenu.h"

@interface BATAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) RESideMenu *sideMenuViewController;

@end

