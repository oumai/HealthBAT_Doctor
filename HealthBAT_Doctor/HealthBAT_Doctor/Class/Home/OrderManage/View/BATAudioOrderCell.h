//
//  BATAudioOrderCell.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BATAudioOrderCell : UITableViewCell

/**
 就诊人
 */
@property (nonatomic,strong) UILabel *nameLabel;

/**
 服务类型
 */
@property (nonatomic,strong) UILabel *orderType;

/**
 服务时间
 */
@property (nonatomic,strong) UILabel *timeLabel;

/**
 服务状态
 */
@property (nonatomic,strong) UILabel *statusLabel;

@end
