//
//  NSString+BATCommon.h
//  HealthBAT_Pro
//
//  Created by KM on 2017/5/10.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BATCommon)
//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;
- (BOOL)isEmail;
- (BOOL)isQQ;
- (BOOL)isChineseUserName;
- (BOOL)isUserName;
- (BOOL)isPassword;
//是否纯数字
- (BOOL)isPureNumandCharacters;
//字符数目
- (int)charCount;
- (BOOL)isUrlAddress;


//去掉<br />
- (NSString *)stringByShowLinefeedString;
//替换\n为<br />
- (NSString *)stringByPostLinefeedString;
@end
