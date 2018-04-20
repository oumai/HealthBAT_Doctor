//
//  BATAppDelegate+BATAgora.h
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/5/13.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAppDelegate.h"
#import "BATAgoraManager.h"
#import "BATAgoraSignalingManager.h"

@interface BATAppDelegate (BATAgora) <BATAgoraSignalingManagerDelegate>

- (void)bat_registerAgora;

@end
