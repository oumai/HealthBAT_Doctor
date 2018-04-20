//
//  BATAuthenticateFooterView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SubmitAction)(void);
@interface BATAuthenticateFooterView : UIView

/**
 标题
 */
@property (nonatomic,strong) UILabel *titleLabel;

/**
 内容
 */
@property (nonatomic,strong) UILabel *contentLabel;

/**
 提交按钮
 */
@property (nonatomic,strong) UIButton *submitButton;

/**
 提交Block
 */
@property (nonatomic,strong) SubmitAction submitAction;

@end
