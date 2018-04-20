//
//  BATDoctorServiceInfoButton.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/10.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoctorServiceInfoButtonBlock)(void);

@interface BATDoctorServiceInfoButton : UIView

/**
 数量
 */
@property (nonatomic,strong) UILabel *countLabel;

/**
 标题
 */
@property (nonatomic,strong) UILabel *titleLabel;

/**
 操作按钮
 */
@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) DoctorServiceInfoButtonBlock doctorServiceInfoButtonBlock;

@end
