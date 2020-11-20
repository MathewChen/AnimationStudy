//
//  UIColor+Extension.m
//  APPDEMO
//
//  Created by 唐伟明 on 2017/6/19.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+(UIColor *)colorWithHexString:(NSString *)ColorString{
    return [self colorWithHexString:ColorString alpha:1.0];
}
+ (UIColor *)colorWithHexString:(NSString *)ColorString alpha:(CGFloat)alpha {
    
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != ColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:ColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:alpha];
    
    return result;
    
}
+(UIColor *)randomColor{
    return [[UIColor alloc] initWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}
@end
