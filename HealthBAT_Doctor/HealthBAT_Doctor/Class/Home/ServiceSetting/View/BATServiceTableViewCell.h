//
//  BATServiceTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/16.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATServiceSettingModel.h"

typedef void(^FamilyServiceClick)(NSInteger index,NSString *key,BOOL value);

@interface BATServiceTableViewCell : UITableViewCell

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) FamilyServiceClick familyServiceClick;

- (void)configData:(BATServiceSettingModel *)serviceSettingModel;

@end
