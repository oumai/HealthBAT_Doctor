//
//  BATDoctorStudioConsultingRoomTableViewCell.h
//  HealthBAT_Pro
//
//  Created by Skybrim on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATMenuButton.h"

typedef void(^MenuBlock)(NSInteger type);

@interface BATDoctorStudioConsultingRoomTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLabel;
//@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIImageView *avaterImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UIView *line1;

@property (nonatomic,strong) UIImageView *familyStatusImageView;

@property (nonatomic,assign) BOOL isFamilyService;

@property (nonatomic,assign) BOOL isExpire;

@property (nonatomic,strong) UIImageView *unreadImageView;

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) void(^consultBlock)(NSIndexPath *clickIndexPath);
@property (nonatomic,strong) MenuBlock menuBlock;


- (void)loadMenuButton:(NSString *)orderServerType consultStatus:(NSInteger)consultStatus;

@end
