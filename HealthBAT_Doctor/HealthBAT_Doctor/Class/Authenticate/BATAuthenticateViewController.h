//
//  BATAuthenticateViewController.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATAuthenticateView.h"

@interface BATAuthenticateViewController : UIViewController

@property (nonatomic,strong) BATAuthenticateView *authenticateView;

@property (nonatomic,assign) BOOL isFromResult;

@end
