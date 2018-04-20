//
//  BATFeeTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FeeInput)(NSString *fee,NSIndexPath *indexPath);

@interface BATFeeTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UILabel *unitLabel;

@property (nonatomic,strong) FeeInput feeInput;

@end
