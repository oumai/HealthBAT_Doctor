//
//  BATReservationCountPickerView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock)(NSInteger value);

@interface BATReservationCountPickerView : UIView

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *unitLabel;

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,strong) UIButton *confirmBtn;

@property (nonatomic,strong) ConfirmBlock confirmBlock;

@property (nonatomic,assign) NSInteger value;

@end
