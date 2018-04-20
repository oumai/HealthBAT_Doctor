//
//  BATServiceSettingModel.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATServiceSettingModel.h"

@implementation BATServiceSettingModel

+ (NSDictionary *)objectClassInArray{
    return @{@"Data" : [BATServiceSettingData class]};
}

@end

@implementation BATServiceSettingData

+ (NSDictionary *)objectClassInArray{
    return @{@"FamilyDoctorCostList" : [BATFamilyDoctorCostItem class],@"FamilyServiceList":[BATFamilyServiceItem class]};
}

@end

@implementation BATFamilyDoctorCostItem

@end

@implementation BATFamilyServiceItem


@end
