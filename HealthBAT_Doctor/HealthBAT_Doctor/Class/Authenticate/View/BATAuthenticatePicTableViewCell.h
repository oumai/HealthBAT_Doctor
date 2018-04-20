//
//  BATAuthenticatePicTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddPicBlock)(void);
typedef void(^DeletePicBlock)(void);

@interface BATAuthenticatePicTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *picView;

@property (nonatomic,strong) UIButton *deleteBtn;

@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,strong) AddPicBlock addPicBlock;

@property (nonatomic,strong) DeletePicBlock deletePicBlock;

@end
