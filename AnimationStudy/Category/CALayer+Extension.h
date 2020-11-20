//
//  CALayer+Extension.h
//  ZYOperation
//
//  Created by 唐伟明 on 2018/12/5.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Extension)

+(CAShapeLayer *)annulusLineWidth:(CGFloat)lineWidth
                      radius:(CGFloat)radius
                      center:(CGPoint)center
                 strokeColor:(UIColor *)strokeColor
                   fillColor:(UIColor *)fillColor
                  startAngle:(CGFloat)startAngle
                    endAngle:(CGFloat)endAngle
                   clockWise:(BOOL)clockWise;


//渐变layer
+(CAGradientLayer *)gradientLayerFrame:(CGRect)frame
                                colors:(NSArray<UIColor *> *)colors
                            startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint;

/**
 移除所有layer
 */
-(void)removeAllSublayers;
@end

NS_ASSUME_NONNULL_END
