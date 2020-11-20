//
//  NSMutableAttributedString+Extension.m
// 
//
//  Created by 唐伟明 on 2018/6/14.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"


@implementation NSMutableAttributedString (Extension)
/**
 *增加普通字符串
 */
-(void)appendString:(NSString *)string{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSAttributedString *astr = [[NSAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [self appendAttributedString:astr];
}

/**
 *增加普通字符串
 */
-(void)appendString:(NSString *)string attributes:(NSDictionary *)attributes{
   NSAttributedString *astr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
   [self appendAttributedString:astr];
}

/**
 *为下一行添加一个间距
 */
-(void)addLineSpacing:(CGFloat)spacing{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    NSAttributedString *astr = [[NSAttributedString alloc] initWithString:@"\n \n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle,ATT_FONT([UIFont systemFontOfSize:0])}];
    [self appendAttributedString:astr];
}
@end
