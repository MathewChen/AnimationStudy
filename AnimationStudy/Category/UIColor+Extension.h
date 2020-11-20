//
//  UIColor+Extension.h
//  APPDEMO
//
//  Created by WindyCheng on 2017/6/19.
//  Copyright © 2017年 suhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (Extension)
//16进制颜色相关

+ (UIColor *)colorWithHexString:(NSString *)ColorString;

+ (UIColor *)colorWithHexString:(NSString *)ColorString alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;//随机色
@end
