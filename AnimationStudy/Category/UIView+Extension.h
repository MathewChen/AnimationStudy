//
//  UIView+Extension.h
//  APPDEMO
//
//  Created by 唐伟明 on 2017/6/22.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *创建一个1xp的底线
 */
-(void)addBottomLineWithColor:(UIColor *)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

-(void)addTopLineWithColor:(UIColor *)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;
/**
 *创建一个圆点
 */
+(UIView *)getDotWithColor:(UIColor *)color Radius:(CGFloat)radius;

/**
 *添加边线
 */
-(void)addBorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)color;

/**
 *添加圆角
 */
-(void)addCornerRadius:(CGFloat)cornerRadius;

/**
 *从nib中加载,nib名字默认为class名字
 */
+(instancetype)loadNib;


/**
 *添加一组view
 */
-(void)addSubviews:(NSArray<UIView *> *)views;


/**
 *移除所有子UI
 */
-(void)removeAllSubviews;


/**
 *所有的view执行block
 */
-(void)findAllView:(Class)viewClass Block:(void(^)(id))block;

/**
 *找到最近的响应者处理
 */
+(void)finder:(id)finder Responder:(Class)responderclass Block:(void(^)(id))block;


/**
 *复制
 */
+ (UIView *)duplicate:(UIView *)view;

/// 模态弹出一个View
/// @param duration 动画时间
+ (void)presentModalView:(UIView*)aView  withDuration:(NSTimeInterval)duration;


+ (void)dismissModalView:(UIView*)aView withDuration:(NSTimeInterval)duration completion:(void(^)(void))completion;

+ (void)animationAlert:(UIView *)aView;

@end
