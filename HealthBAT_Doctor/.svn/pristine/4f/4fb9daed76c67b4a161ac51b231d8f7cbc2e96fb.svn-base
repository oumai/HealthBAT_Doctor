//
//  BATScheduleModel.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BATScheduleData,BATScheduleTimeData,BATDataWeekData,BATScheduleItem;
@interface BATScheduleModel : NSObject

@property (nonatomic, assign) NSInteger ResultCode;

@property (nonatomic, copy) NSString *ResultMessage;

@property (nonatomic, strong) NSMutableArray <BATScheduleData *> *Data;

@end


@interface BATScheduleData : NSObject

@property (nonatomic,strong) NSMutableArray <BATDataWeekData *> *DataWeekList;

@property (nonatomic,strong) NSMutableArray <BATScheduleTimeData *> *ScheduleTimeList;

@end

@interface BATDataWeekData : NSObject

@property (nonatomic,copy) NSString *DateStr;

@property (nonatomic,copy) NSString *WeekStr;


@end

@interface BATScheduleTimeData : NSObject

@property (nonatomic,copy) NSString *StartTime;

@property (nonatomic,copy) NSString *EndTime;

@property (nonatomic,strong) NSMutableArray <BATScheduleItem *> *ScheduleList;

@end

@interface BATScheduleItem : NSObject

@property (nonatomic,copy) NSString *ScheduleID;

@property (nonatomic,assign) NSInteger YueYueMax;

@property (nonatomic,assign) BOOL CanEdit;

@end
