//
//  BATMeHeaderView.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/6/20.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AvatarBlock)(void);

@interface BATMeHeaderView : UIView

/**
 头像背景
 */
@property (nonatomic,strong) UIImageView *avatarBgView;

/**
 头像
 */
@property (nonatomic,strong) UIImageView *avatarImageView;

/**
 头像点击
 */
@property (nonatomic,strong) AvatarBlock avatarBlock;


@end
