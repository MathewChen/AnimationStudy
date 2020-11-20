//
//  UIView+Cutting.m
//  BeraceProject
//
//  Created by sucheng on 2017/7/26.
//  Copyright © 2017年 Berace. All rights reserved.
//

#import "UIView+Cutting.h"

@implementation UIView (Cutting)


- (void)cuttingViewbyRoundingCorners:(UIRectCorner)corners cornerRadiusWidth:(CGFloat)radiusWidth{

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radiusWidth, radiusWidth)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

@end
