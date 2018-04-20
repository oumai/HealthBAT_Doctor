//
//  BATDoctorStudioConsultingRoomTableViewCell.m
//  HealthBAT_Pro
//
//  Created by Skybrim on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATDoctorStudioConsultingRoomTableViewCell.h"

@interface BATDoctorStudioConsultingRoomTableViewCell ()

@property (nonatomic,strong) NSMutableArray *buttons;

@end

@implementation BATDoctorStudioConsultingRoomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _buttons = [NSMutableArray array];
        
        [self setBottomBorderWithColor:UIColorFromHEX(0xeeeeee, 1) width:SCREEN_WIDTH height:0.5];
        
//        [self.contentView addSubview:self.line];
//        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(@0);
//            make.top.equalTo(@40);
//            make.height.mas_equalTo(0.5);
//        }];
        
        [self.contentView addSubview:self.avaterImageView];
        [self.contentView addSubview:self.familyStatusImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.sexLabel];
        [self.contentView addSubview:self.ageLabel];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.unreadImageView];

        WEAK_SELF(self);
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);

            make.left.equalTo(@10);
            make.top.equalTo(self.contentView.mas_top).offset(12.5);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [self.familyStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.size.mas_offset(CGSizeMake(40, 14));
            make.centerX.equalTo(self.avaterImageView.mas_centerX);
            make.bottom.equalTo(self.avaterImageView.mas_bottom);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);

            make.left.equalTo(self.avaterImageView.mas_right).offset(10);
            make.top.equalTo(self.avaterImageView.mas_top);
            make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-10);
        }];
        
        [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);

            make.left.equalTo(self.avaterImageView.mas_right).offset(10);
            make.bottom.equalTo(self.avaterImageView.mas_bottom);
        }];
        
        [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);

            make.left.equalTo(self.sexLabel.mas_right).offset(20);
            make.top.equalTo(self.sexLabel.mas_top);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.left.greaterThanOrEqualTo(self.ageLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.sexLabel.mas_top);
        }];
        
        [self.unreadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.right.equalTo(self.avaterImageView.mas_right).offset(-2);
            make.top.equalTo(self.avaterImageView.mas_top).offset(2);
            make.size.mas_offset(CGSizeMake(10, 10));
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)loadMenuButton:(NSString *)orderServerType consultStatus:(NSInteger)consultStatus
{
    
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[BATMenuButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    NSMutableArray *menus = [NSMutableArray arrayWithArray:[orderServerType componentsSeparatedByString:@","]];
    
    [menus removeObject:@"4"];
    
    BATMenuButton *lastButton = nil;
    
    for (NSInteger i = 0; i < menus.count; i++) {
        
        BATMenuButton *button = [BATMenuButton buttonWithType:UIButtonTypeCustom];
        
         NSInteger type = [menus[i] integerValue];
        
        if (type == 1) {
            //视频
            [button setTitle:@"视频咨询" forState:UIControlStateNormal];
        } else if (type == 2) {
            //语音
            [button setTitle:@"语音咨询" forState:UIControlStateNormal];
        } else if (type == 3) {
            //图文
            [button setTitle:@"图文咨询" forState:UIControlStateNormal];
        }
        
        button.orderServerType = type;
        
        button.layer.cornerRadius = 6.0f;
        button.layer.masksToBounds = YES;
        
        if (consultStatus == 2) {
            [button setTitleColor:UIColorFromHEX(0xa4a4a4, 1) forState:UIControlStateNormal];
            button.layer.borderColor = UIColorFromHEX(0xa4a4a4, 1).CGColor;
            button.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
        } else {
            [button setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
            button.layer.borderColor = BLUE_COLOR.CGColor;
            button.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:button];
        
        WEAK_SELF(self);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            if (i == 0) {
                make.right.equalTo(self.contentView.mas_right).offset(-10);
            } else {
                make.right.equalTo(lastButton.mas_left).offset(-10);
            }
            
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.size.mas_offset(CGSizeMake(80, 28));
            
        }];
        
        lastButton = button;
        
    }
}

- (void)buttonAction:(BATMenuButton *)button
{
    if (self.menuBlock) {
        self.menuBlock(button.orderServerType);
    }
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:STRING_MID_COLOR textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

//- (UIView *)line {
//    
//    if (!_line) {
//        _line = [[UIView alloc] init];
//        _line.backgroundColor = UIColorFromHEX(0xeeeeee, 1);
//    }
//    return _line;
//}

- (UIView *)line1 {
    
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = UIColorFromHEX(0xeeeeee, 1);
    }
    return _line1;
}

- (UIImageView *)avaterImageView {
    
    if (!_avaterImageView) {
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 50 / 2;
        _avaterImageView.clipsToBounds = YES;
    }
    return _avaterImageView;
}

- (UIImageView *)familyStatusImageView
{
    if (_familyStatusImageView == nil) {
        _familyStatusImageView = [[UIImageView alloc] init];
        _familyStatusImageView.hidden = YES;
    }
    return _familyStatusImageView;
}

- (UIImageView *)unreadImageView
{
    if (_unreadImageView == nil) {
        _unreadImageView = [[UIImageView alloc] init];
        _unreadImageView.backgroundColor = [UIColor redColor];
        _unreadImageView.layer.cornerRadius = 10 / 2;
        _unreadImageView.layer.masksToBounds = YES;
//        _unreadImageView.image = [UIImage imageNamed:@"unread"];
    }
    return _unreadImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:STRING_DARK_COLOR textAlignment:NSTextAlignmentLeft];
        
    }
    return _nameLabel;
}
- (UILabel *)sexLabel {
    
    if (!_sexLabel) {
        _sexLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:STRING_MID_COLOR textAlignment:NSTextAlignmentLeft];
    }
    return _sexLabel;
}

- (UILabel *)ageLabel {
    
    if (!_ageLabel) {
        _ageLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:14] textColor:STRING_MID_COLOR textAlignment:NSTextAlignmentLeft];
    }
    return _ageLabel;
}

//- (UIButton *)consultingBtn {
//    
//    if (!_consultingBtn) {
//        _consultingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _consultingBtn.layer.cornerRadius = 5.0f;
//        _consultingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        
//        WEAK_SELF(self);
//        [_consultingBtn bk_whenTapped:^{
//            STRONG_SELF(self);
//            if (self.consultBlock) {
//                self.consultBlock(self.indexPath);
//            }
//        }];
//    }
//    return _consultingBtn;
//}

- (void)setIsFamilyService:(BOOL)isFamilyService
{
    _isFamilyService = isFamilyService;
    
    self.familyStatusImageView.hidden = !_isFamilyService;
    
}

- (void)setIsExpire:(BOOL)isExpire
{
    _isExpire = isExpire;
    self.familyStatusImageView.image = _isExpire ? [UIImage imageNamed:@"img-jtfw-"] : [UIImage imageNamed:@"img-jtfw"];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
