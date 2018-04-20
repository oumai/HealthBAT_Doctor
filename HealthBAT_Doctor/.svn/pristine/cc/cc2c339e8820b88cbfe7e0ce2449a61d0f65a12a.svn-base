//
//  BATCustomTableViewCell.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/15.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextInput)(NSString *text,NSIndexPath *indexPath);

//typedef void(^TextClick)(NSIndexPath *indexPath);


@interface BATCustomTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UIImageView *arrowImageView;

//@property (nonatomic,assign) BOOL canInput;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) TextInput textInput;

//@property (nonatomic,strong) TextClick textClick;

- (NSMutableAttributedString *)setTitleString:(NSString *)title;

@end
