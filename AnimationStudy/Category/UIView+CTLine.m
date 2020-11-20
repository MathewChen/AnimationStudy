//
//  UIView+CTLine.m
//  ZMJCTKit
//
//  Created by zmjios on 15/11/6.
//  Copyright © 2015年 zmjios. All rights reserved.
//

#import "UIView+CTLine.h"



#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation UIView (CTLine)


- (void)drawLineInPosition:(CTLinePosition)position
{
    UIColor *defaultColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self drawLineInPosition:position color:defaultColor];
}

- (void)drawLineInPosition:(CTLinePosition)position width:(CGFloat)width
{
    UIColor *defaultColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self drawLineInPosition:position color:defaultColor width:width];
}

- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color
{
    CGFloat width = SINGLE_LINE_WIDTH;
    [self drawLineInPosition:postion color:color width:width];
}


- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color width:(CGFloat)width
{
    [self drawLineInPosition:postion color:color width:width edge:UIEdgeInsetsZero];
}

- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color  edge:(UIEdgeInsets)edge
{
    CGFloat width = 1.0/[[UIScreen mainScreen] scale];
    [self drawLineInPosition:postion color:color width:width edge:edge];
}


/**
 *  用shapeLayer的将UIiew的边角添加直线
 *
 *  @param postion 支持的位置
 *  @param color   线条的颜色
 *  @param width   线条宽度
 *  @param edge    edge
 */
- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color width:(CGFloat)width edge:(UIEdgeInsets)edge
{
    NSString *layerId = [NSString stringWithFormat:@"lineLayer_%ld",(long)postion];
    
    for (CALayer *layer in self.layer.sublayers) {
    
        if ([layer.name isEqualToString:layerId]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    //shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = width;
    shapeLayer.frame = self.bounds;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.name = layerId;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = width;
    
    
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    CGFloat pixelAdjustOffset = 0;
    if (((int)(width * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    if (postion & CTLinePositionTop) {
        
        [path moveToPoint:CGPointMake(0 + edge.left, 0 - pixelAdjustOffset)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-edge.right, 0 - pixelAdjustOffset)];
    }
    
    if (postion & CTLinePositionBottom) {
        
        [path moveToPoint:CGPointMake( 0 + edge.left, CGRectGetHeight(self.bounds)-width - pixelAdjustOffset)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)- edge.right,CGRectGetHeight(self.bounds)-width - pixelAdjustOffset)];
    }
    
    if (postion & CTLinePositionLeft) {
        
        [path moveToPoint:CGPointMake(0 + pixelAdjustOffset, 0 + edge.top)];
        [path addLineToPoint:CGPointMake(0 + pixelAdjustOffset, CGRectGetHeight(self.bounds) - edge.bottom)];
        
    }
    
    if (postion & CTLinePositionRight) {
        
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) - width + pixelAdjustOffset, 0 + edge.top)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - width + pixelAdjustOffset, CGRectGetHeight(self.bounds) - edge.bottom)];
    }
    
    shapeLayer.path = path.CGPath;
    
    
    
    [self.layer addSublayer:shapeLayer];
}



@end
