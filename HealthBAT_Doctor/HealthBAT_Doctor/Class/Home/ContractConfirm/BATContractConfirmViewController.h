//
//  BATContractConfirmViewController.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATContractConfirmView.h"

@interface BATContractConfirmViewController : UIViewController

@property (nonatomic,strong) BATContractConfirmView *contractConfirmView;

@property (nonatomic,strong) NSString *messageID;

@property (nonatomic,assign) NSInteger state;

@end
