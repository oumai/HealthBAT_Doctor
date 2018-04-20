//
//  BATDoctorStudioMessageModel.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BATDoctorStudioMessageData;
@interface BATDoctorStudioMessageModel : NSObject

@property (nonatomic, assign) NSInteger ResultCode;

@property (nonatomic, assign) NSInteger RecordsCount;

@property (nonatomic, copy) NSString *ResultMessage;

@property (nonatomic, strong) NSMutableArray <BATDoctorStudioMessageData *> *Data;

@end


@interface BATDoctorStudioMessageData : NSObject

@property (nonatomic,copy) NSString *ID;

@property (nonatomic,assign) NSInteger ReceiveID;

@property (nonatomic,copy) NSString *OrderNo;

@property (nonatomic,copy) NSString *MessageTitle;

@property (nonatomic,copy) NSString *MessageContent;

@property (nonatomic,assign) NSInteger MessageType;

@property (nonatomic,assign) NSInteger State;

@property (nonatomic,copy) NSString *CreatedTime;

@property (nonatomic,copy) NSString *CompactContent;

@property (nonatomic,assign) BOOL IsRead;

@end
