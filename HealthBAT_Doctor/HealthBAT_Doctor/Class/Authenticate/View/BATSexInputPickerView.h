//
//  BATSexInputPickerView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/17.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BATSexInputPickerView;
@protocol BATSexInputPickerViewDelegate <NSObject>

- (void)BATSexInputPickerView:(BATSexInputPickerView *)sexInputPickerView didSelectRow:(NSInteger)row titleForRow:(NSString *)title;

@end

typedef void(^CancelBlcok)(void);

@interface BATSexInputPickerView : UIView

@property (nonatomic,strong) UIToolbar *toolBar;

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,weak) id<BATSexInputPickerViewDelegate> delegate;

@property (nonatomic,strong) CancelBlcok cancelBlcok;

//- (void)show;
//
//- (void)hide;

@end
