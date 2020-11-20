//
//  NSString+Extension.h
//  DongLaiShun
//
//  Created by 唐伟明 on 2017/11/20.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
-(NSString *)decimalStyle;
-(NSString *)noStyle;
-(NSString *)addHost;

/**
 *计算文字高度
 */

- (CGFloat)calculateRowHeightFontSize:(NSInteger)fontSize width:(CGFloat)width;

/// 计算文字宽度
/// @param fontSize 文字大小
/// @param height 容器高度
- (CGFloat)calculateRowWidthFontSize:(NSUInteger)fontSize height:(CGFloat)height;

/**
 *转换成拼音
 */
- (NSString *)transformToPinyin;

/**
 *全拼音
 */
- (NSString *)pinYin;

/**
 *首字母
 */
- (NSString *)initial;

/**
 *转表情
 */
- (NSString *)transformToEmoji;

/**
 *表情转字符串
 */
- (NSString *)emojiTransformToString;

/**
 *设置行间距
 */
-(NSAttributedString *)setLineSpacing:(CGFloat)spacing;



/**
 *前面添加¥
 */
-(NSString *)addPrefixRMB;

/**
 *后面添加元
 */
-(NSString *)addsuffixRMB;

/**
 *MD5加密
 */
- (NSString *)md5;

//转换格式化金额
- (NSString *)moneyStr;

//去掉左右空格
-(NSString *)ltrimAndRtrim;

//取第一节字符串
-(NSString *)firstString;

//添加token
-(NSString *)addToken;


@end
