//
//  NSDate+BATTimeCatagory.h
//  HealthBAT_Pro
//
//  Created by four on 17/2/24.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BATTimeCatagory)

/**
 *  字符串转NSDate
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return <#return value description#>
 */
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

/**
 *  NSDate转时间戳
 *
 *  @param date 字符串时间
 *
 *  @return 返回时间戳
 */
+ (NSInteger)cTimestampFromDate:(NSDate *)date;

/**
 *  字符串转时间戳
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回时间戳的字符串
 */
+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;


/**
 *  时间戳转字符串
 *
 *  @param timeStamp 时间戳
 *  @param format    转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;

/**
 *  NSDate转字符串
 *
 *  @param date   NSDate时间
 *  @param format 转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;

/**
 *  格式化当前时间
 *
 *  @param format 格式
 *
 *  @return 格式化后的时间
 */
+ (NSString *)getCurrentDateStringByFormat:(NSString *)format;
@end
