//
//  NSDate+Extension.h
//  DongLaiShun
//
//  Created by 唐伟明 on 2017/11/22.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import <Foundation/Foundation.h>
#define yyyy_MM_dd_HMS   @"yyyy-MM-dd HH:mm:ss"
#define yyyy_MM_dd   @"yyyy-MM-dd"
#define yyyy_MM      @"yyyy-MM"
@interface NSDate (Extension)

/**
 *不同时间格式的转换
 */
+ (NSString *)getDateStringFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat ToFormat:(NSString *)tformat;


/**
 *获取指定格式的时间的时间戳
 */
+(NSTimeInterval)getTimeIntervalFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat;

/**
 *获取指定格式的日期
 */
+(NSDate *)getDateFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat;


/**
 *获取指定格式的日期
 */
-(NSString *)getDateStringToFormat:(NSString *)tformat;

/**
 *  获取星期几
 *  0-6 == 日-六
 */
-(NSInteger)week;

// 获取月份的天数
- (NSInteger)getNumberOfDays;


//获取当前日期偏移月份
- (NSDate *)getMonthByoffset:(NSInteger)offset;

//获取当前日期偏移天数
- (NSDate *)getDayByoffset:(NSInteger)offset;

//获取农历
- (NSString *)getChineseDate;

@end
