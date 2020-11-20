//
//  NSString+Regex.h
//  Cloud
//
//  Created by paykee on 2017/5/8.
//  Copyright © 2017年 冀明达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)
/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)isMobileNumberClassification;
/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;


/**
 *  正整数
 */
- (BOOL)isPositiveInteger;


/**
 *  数值
 */
- (BOOL)isNumber;

/**
 *  两位数字
 */
- (BOOL)isNumber2;

/**
 *  是否包含数字
 */
- (BOOL)containNumber;

/**
 *  是否包含字母
 */
- (BOOL)containChar;

//检验小数位数
- (BOOL)isDecLen:(NSInteger) count;

+ (NSString *)showPhoneNum:(NSString *)phoneNum;
//开始校验  
@property(nonatomic, copy) NSDictionary *(^startCheck)(NSString *name);
@end
