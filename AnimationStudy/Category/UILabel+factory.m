//
//  UILabel+factory.m
//  DLabel
//
//  Created by 唐伟明 on 2019/6/14.
//  Copyright © 2019 Star. All rights reserved.
//

#import "UILabel+factory.h"

@implementation UILabel (factory)
+(instancetype)labelWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    UILabel *lbl = [UILabel new];
    lbl.text = text;
    lbl.textColor = color;
    lbl.font = font;
    [lbl sizeToFit];
    return lbl;
}
@end
