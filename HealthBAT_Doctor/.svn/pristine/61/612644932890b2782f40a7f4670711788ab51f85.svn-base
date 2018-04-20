//
//  BATPushModel.h
//  HealthBAT_Pro
//
//  Created by Skybrim on 2017/4/1.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class PushAps;

@interface BATPushModel : NSObject

@property (nonatomic, assign) BATJPushMsgType JPushMsgType;

@property (nonatomic, copy) NSString *_j_msgid;

@property (nonatomic, strong) PushAps *aps;

@end

@interface PushAps : NSObject

@property (nonatomic, copy) NSString *alert;
@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, copy) NSString *sound;

@end
