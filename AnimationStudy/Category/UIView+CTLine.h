//
//  UIView+CTLine.h
//  ZMJCTKit
//
//  Created by zmjios on 15/11/6.
//  Copyright © 2015年 zmjios. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,CTLinePosition) {
    CTLinePositionTop = 1 << 0,
    CTLinePositionBottom  = 1 << 1,
    CTLinePositionLeft = 1 << 2,
    CTLinePositionRight = 1 << 3
};

@interface UIView (CTLine)

- (void)drawLineInPosition:(CTLinePosition)position;

- (void)drawLineInPosition:(CTLinePosition)position width:(CGFloat)width;

- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color;

- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color width:(CGFloat)width;

- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color  edge:(UIEdgeInsets)edge;

/**
 *  用shapeLayer的将UIiew的边角添加直线
 *
 *  @param postion 支持的位置
 *  @param color   线条的颜色
 *  @param width   线条宽度
 *  @param edge    edge
 */
- (void)drawLineInPosition:(CTLinePosition)postion color:(UIColor *)color width:(CGFloat)width edge:(UIEdgeInsets)edge;

@end
