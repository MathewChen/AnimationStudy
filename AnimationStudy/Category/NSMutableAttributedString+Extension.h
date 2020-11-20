//
//  NSMutableAttributedString+Extension.h
// 
//
//  Created by 唐伟明 on 2018/6/14.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ATT_FONT(font) NSFontAttributeName:font
#define ATT_COLOR(color) NSForegroundColorAttributeName:color
#define ATT_LINK(linkName) NSLinkAttributeName:linkName

@interface NSMutableAttributedString (Extension)

/**
 *增加普通字符串
 */
-(void)appendString:(NSString *)string;

/**
 *增加普通字符串
 */
-(void)appendString:(NSString *)string attributes:(NSDictionary *)attributes;

/**
 *为下一行添加一个间距
 */
-(void)addLineSpacing:(CGFloat)spacing;
@end
