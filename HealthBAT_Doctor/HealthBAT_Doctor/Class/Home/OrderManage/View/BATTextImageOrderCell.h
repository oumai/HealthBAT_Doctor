//
//  BATTextImageOrderCell.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReplyBlock)(void);

@interface BATTextImageOrderCell : UITableViewCell

/**
 就诊人
 */
@property (nonatomic,strong) UILabel *nameLabel;

/**
 咨询时间
 */
@property (nonatomic,strong) UILabel *consultTimeLabel;

/**
 描述
 */
@property (nonatomic,strong) UILabel *descLabel;

/**
 服务状态
 */
@property (nonatomic,strong) UILabel *statusLabel;

/**
 线
 */
@property (nonatomic,strong) UILabel *line;

/**
 回复按钮
 */
@property (nonatomic,strong) UIButton *replyBtn;

@property (nonatomic,strong) ReplyBlock replyBlock;

- (void)resetUI:(NSInteger)consultStatus;

@end
