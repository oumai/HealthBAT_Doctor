//
//  BATAuthenticateIndexView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

typedef void(^StartBlock)(void);

@interface BATAuthenticateIndexView : UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) YYLabel *contentLabel;

@property (nonatomic,strong) UIButton *startBtn;

@property (nonatomic,strong) StartBlock startBlock;

@end
