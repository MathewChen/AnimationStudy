//
//  CALayer+Extension.m
//  ZYOperation
//
//  Created by 唐伟明 on 2018/12/5.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

+(CAShapeLayer *)annulusLineWidth:(CGFloat)lineWidth
                 radius:(CGFloat)radius
                 center:(CGPoint)center
            strokeColor:(UIColor *)strokeColor
              fillColor:(UIColor *)fillColor
             startAngle:(CGFloat)startAngle
               endAngle:(CGFloat)endAngle
              clockWise:(BOOL)clockWise
{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth =lineWidth;
    //圆环的颜色
    layer.strokeColor = strokeColor.CGColor;
    //背景填充色
    layer.fillColor = fillColor.CGColor;
   
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockWise];
    
    layer.path = [path CGPath];
    return layer;
}

//渐变layer
+(CAGradientLayer *)gradientLayerFrame:(CGRect)frame colors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    NSMutableArray *marr = [NSMutableArray array];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:(id)obj.CGColor];
    }];
    [gradientLayer setColors:marr];
    
    
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint =   endPoint;
 
    return gradientLayer;
}


/**
 移除所有layer
 */
-(void)removeAllSublayers{
    [self.sublayers.copy enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
}
@end
