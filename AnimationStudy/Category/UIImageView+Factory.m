//
//  UIImageView+Factory.m
//  APPDEMO
//
//  Created by 唐伟明 on 2017/6/14.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import "UIImageView+Factory.h"

@implementation UIImageView (Factory)
+(UIImageView *)imageViewFrame:(CGRect)frame WithImageName:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    if ([imageName isKindOfClass:[NSString class]]) {
       imgView.image = [UIImage imageNamed:imageName];
    }
    return imgView;
}
+(UIImageView *)imageViewWithImageName:(NSString *)imageName{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}
@end
