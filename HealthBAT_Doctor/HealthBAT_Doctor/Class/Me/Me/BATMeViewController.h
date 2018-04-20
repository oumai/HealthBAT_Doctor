//
//  BATMeViewController.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATMeView.h"

@interface BATMeViewController : UIViewController

@property (nonatomic,strong) BATMeView *meView;

- (void)refreshAvatar;

@end
