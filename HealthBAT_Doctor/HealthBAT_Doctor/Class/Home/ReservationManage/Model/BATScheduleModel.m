//
//  BATScheduleModel.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATScheduleModel.h"

@implementation BATScheduleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"Data" : [BATScheduleData class]};
}

@end

@implementation BATScheduleData

+ (NSDictionary *)objectClassInArray{
    return @{@"DataWeekList" : [BATDataWeekData class],@"ScheduleTimeList" : [BATScheduleTimeData class]};
}

@end

@implementation BATDataWeekData


@end

@implementation BATScheduleTimeData

+ (NSDictionary *)objectClassInArray{
    return @{@"ScheduleList" : [BATScheduleItem class]};
}

@end

@implementation BATScheduleItem

@end
