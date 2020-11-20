//
//  NSDate+Extension.m
//  DongLaiShun
//
//  Created by 唐伟明 on 2017/11/22.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 *不同时间格式的转换
 */
+ (NSString *)getDateStringFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat ToFormat:(NSString *)tformat{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:fformat];
    NSDate *date = [dataFormatter dateFromString:dateString];
    [dataFormatter setDateFormat:tformat];
    return [dataFormatter stringFromDate:date];
    
}


/**
 *获取指定格式的时间的时间戳
 */
+(NSTimeInterval)getTimeIntervalFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat{
    
    NSDate *date = [self getDateFormDateString:dateString FormFormat:fformat];
    return [date timeIntervalSince1970];
}

/**
 *获取指定格式的日期
 */
+(NSDate *)getDateFormDateString:(NSString *)dateString FormFormat:(NSString *)fformat{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:fformat];
    NSDate *date = [dataFormatter dateFromString:dateString];
    return date;
}

/**
 *获取指定格式的日期
 */
-(NSString *)getDateStringToFormat:(NSString *)tformat;{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:tformat];
    return [dataFormatter stringFromDate:self];
}

/**
 *  获取星期几
 *  0-6 == 日-六
 */
-(NSInteger)week{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    //之前的天数
    NSInteger week = [comps weekday]-1;
    return week;
}

// 获取月份的天数
- (NSInteger)getNumberOfDays
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}


//获取当前日期偏移月份
- (NSDate *)getMonthByoffset:(NSInteger)offset
{
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *com = [[NSDateComponents alloc] init];
    [com setMonth:offset];
    NSDate *newdate = [calendar dateByAddingComponents:com toDate:self options:0];
    return newdate;
    
}

//获取当前日期偏移天数
- (NSDate *)getDayByoffset:(NSInteger)offset
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *com = [[NSDateComponents alloc] init];
    [com setDay:offset];
    NSDate *newdate = [calendar dateByAddingComponents:com toDate:self options:0];
    return newdate;
    
}

//获取农历
- (NSString *)getChineseDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit   calenderUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cComponents =  [formatter.calendar components:calenderUnit fromDate:self];
    
    formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *eComponents =  [formatter.calendar components:calenderUnit fromDate:self];
    
    NSInteger year = eComponents.year - (cComponents.month>eComponents.month?1:0);
    NSInteger month = cComponents.month;
    NSInteger day = cComponents.day;
   
    NSArray *yearArr =  @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    NSArray *monthArr = @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月"];
    NSArray *dayArr = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
    
   
    NSMutableString *yearStr = [NSMutableString string];
    NSInteger yearCount = @(year).description.length;
    for (NSInteger i = 0; i<yearCount; i++) {
        NSString *str = [@(year).description substringWithRange:NSMakeRange(i, 1)];
        str = yearArr[str.integerValue];
        [yearStr appendString:str];
    }
    
    NSString *monthStr  = monthArr[month  - 1];

    if (cComponents.isLeapMonth) {
        monthStr = [NSString stringWithFormat:@"闰%@",monthStr];
    }
       

    
    NSString *dayStr = dayArr[day - 1];
    
    NSString *cStr = [NSString stringWithFormat:@"%@年%@%@",yearStr,monthStr,dayStr];
    return cStr;
}










+ (NSString *)convertTime:(NSTimeInterval)time ToFormat:(NSString *)tformat{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:tformat];
    return [dataFormatter stringFromDate:date];
}

+(NSString *)getDateStringyyyyLineMMLinedd{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dataFormatter stringFromDate:[NSDate date]];
}



@end
