//
//  UIView+Cutting.h
//  BeraceProject
//
//  Created by sucheng on 2017/7/26.
//  Copyright © 2017年 Berace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Cutting)


/**
 切圆角方法，必须在设置控件的bounds之后调用才有效果

 @param corners 哪些角
 @param radiusWidth 裁切宽度
 */
-(void)cuttingViewbyRoundingCorners:(UIRectCorner)corners cornerRadiusWidth:(CGFloat)radiusWidth;

@end
