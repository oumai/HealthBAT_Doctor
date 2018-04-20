//
//  BATMyPatientTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BATMyPatientTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *sexLabel;

@property (nonatomic,strong) UILabel *ageLabel;

@property (nonatomic,strong) UIImageView *avatarImageView;

@property (nonatomic,strong) UIImageView *familyStatusImageView;

@property (nonatomic,assign) BOOL isFamilyService;

@property (nonatomic,assign) BOOL isExpire;

@end
