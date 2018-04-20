//
//  BATCanEnterRoomModel.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/16.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BATCanEnterRoomModel : NSObject

@property (nonatomic, assign) NSInteger ResultCode;

@property (nonatomic, copy) NSString *ResultMessage;

@property (nonatomic, assign) BOOL Data;

@end
