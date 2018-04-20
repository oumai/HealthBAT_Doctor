//
//  BATContractConfirmView.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATContractConfirmFooterView.h"

@interface BATContractConfirmView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) BATContractConfirmFooterView *footerView;

@end
