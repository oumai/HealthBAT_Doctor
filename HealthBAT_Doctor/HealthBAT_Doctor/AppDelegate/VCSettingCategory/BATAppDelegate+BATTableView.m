//
//  BATAppDelegate+BATTableView.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/9/20.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAppDelegate+BATTableView.h"
#import "Aspects.h"

@implementation BATAppDelegate (BATTableView)

- (void)cancelTableViewAdjust {
    
    [UITableView aspect_hookSelector:@selector(initWithFrame:style:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UITableView * tableView = aspectInfo.instance;
        
        if (tableView == nil) {
            return ;
        }
        
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } error:nil];
}

@end
