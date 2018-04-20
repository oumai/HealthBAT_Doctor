//
//  BATChatViewController.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface BATChatViewController : RCConversationViewController

@property (nonatomic,strong) NSString *orderNo;

@property (nonatomic,strong) NSString *IllnessDescription;

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,assign) NSInteger ConsultStatus;

@property (nonatomic,assign) BOOL isFamilyService;

@end
