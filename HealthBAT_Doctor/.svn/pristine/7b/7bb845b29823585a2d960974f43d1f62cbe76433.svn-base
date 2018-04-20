//
//  BATDoctorInfoHeaderView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/22.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATDoctorServiceInfoButton.h"

typedef void(^DoctorAvatarClickBlock)(void);

@interface BATDoctorInfoHeaderView : UIView

/**
 头像背景
 */
@property (nonatomic,strong) UIImageView *avatarBgView;

/**
 头像
 */
@property (nonatomic,strong) UIImageView *avatarImageView;

/**
 医生名
 */
@property (nonatomic,strong) UILabel *doctorNameLabel;

/**
 职称和医院
 */
@property (nonatomic,strong) UILabel *doctorTitleAndHospitalNameLabel;

/**
 咨询中
 */
@property (nonatomic,strong) BATDoctorServiceInfoButton *consultingButton;

/**
 已咨询
 */
@property (nonatomic,strong) BATDoctorServiceInfoButton *consultFinishButton;

/**
 我的患者
 */
@property (nonatomic,strong) BATDoctorServiceInfoButton *myPatientButton;

/**
 头像点击
 */
@property (nonatomic,strong) DoctorAvatarClickBlock doctorAvatarClickBlock;

@end
