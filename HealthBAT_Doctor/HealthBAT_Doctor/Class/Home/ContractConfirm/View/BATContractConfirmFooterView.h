//
//  BATContractConfirmFooterView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelContractBlock)(void);

typedef void(^ConfirmContractBlock)(void);

@interface BATContractConfirmFooterView : UIView

@property (nonatomic,strong) UILabel *noticeLabel;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) UIButton *confirmBtn;

@property (nonatomic,strong) CancelContractBlock cancelContractBlock;

@property (nonatomic,strong) ConfirmContractBlock confirmContractBlock;

@end
