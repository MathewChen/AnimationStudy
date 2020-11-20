//
//  UIView+Extension.m
//  APPDEMO
//
//  Created by WindyCheng on 2017/6/22.
//  Copyright © 2017年 . All rights reserved.
//

#import "UIView+Extension.h"
#import <pop/POP.h>
@implementation UIView (Extension)
-(void)addSubviews:(NSArray<UIView *> *)views{
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }
    }];
}
-(void)findAllView:(Class)viewClass Block:(void(^)(id))block{
    if (self.subviews.count > 0) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:viewClass]) {
                block(obj);
            }
            if (obj.subviews.count > 0) {
                [obj findAllView:viewClass Block:block];
            }
        }];
    }
}
+(void)finder:(id)finder Responder:(Class)responderclass Block:(void(^)(id))block{
    id nr = [finder nextResponder];
    if (!nr) {
        return;
    }
    if ([nr isKindOfClass:responderclass]) {
        block(nr);
    }else{
        [self finder:nr Responder:responderclass Block:block];
    }
}
-(void)removeAllSubviews{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:self.subviews];
    [marr enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

/**
 *创建一个1xp的底线
 */
-(void)addBottomLineWithColor:(UIColor *)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin{
    UIView *oldLine= [self viewWithTag:330];
    if (oldLine) {
        [oldLine removeFromSuperview];
    }
    
    UIView *line = [[UIView alloc] init];
    line.tag = 330;
    line.backgroundColor = color;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@(1/[UIScreen mainScreen].scale));
        make.left.equalTo(self).offset(leftMargin);
        make.right.equalTo(self).offset(-rightMargin);
    }];
}

-(void)addTopLineWithColor:(UIColor *)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin{
    UIView *oldLine= [self viewWithTag:331];
    if (oldLine) {
        [oldLine removeFromSuperview];
    }
    
    UIView *line = [[UIView alloc] init];
    line.tag = 331;
    line.backgroundColor = color;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(@(1/[UIScreen mainScreen].scale));
        make.left.equalTo(self).offset(leftMargin);
        make.right.equalTo(self).offset(-rightMargin);
    }];
}
+(UIView *)getDotWithColor:(UIColor *)color Radius:(CGFloat)radius{
    UIView *dot = [[UIView alloc]initWithFrame:CGRectMake(8, 8, radius*2, radius*2)];
    dot.layer.cornerRadius = radius;
    dot.clipsToBounds = YES;
    dot.backgroundColor = color;
    return dot;
}
-(void)addBorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)color{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}
-(void)addCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

+(instancetype)loadNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
+ (UIView *)duplicate:(UIView *)view
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    
}

+(void)presentModalView:(UIView *)aView withDuration:(NSTimeInterval)duration{
          //自定义动画
//    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    basicAnimation.fromValue = @(aView.bounds.size.height);
//    basicAnimation.toValue = @(aView.bounds.size.height/2);
//    basicAnimation.duration = duration;
//    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [aView pop_addAnimation:basicAnimation forKey:nil];
        //Spring动画效果
    //Duration：动画时间
   //delay:延迟多久执行
    //usingSpringWithDamping ：0.f - 1.f 数值越小「弹簧」的振动效果越明显。
    //initialSpringVelocity：初始的速度，数值越大一开始移动越快。
    //options ：动画枚举
    [UIView animateWithDuration:duration
                          delay:0.f
         usingSpringWithDamping:1.f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        CGRect frame = aView.frame;
        frame.origin.y = 0.f;
        aView.frame = frame;
    } completion:nil];
    
}

+(void)dismissModalView:(UIView *)aView withDuration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    
    [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = aView.frame;
        frame.origin.y = UIScreen.mainScreen.bounds.size.height;
        aView.frame = frame;

    } completion:^(BOOL finished) {
        [aView removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
            
}

+(void)animationAlert:(UIView *)aView{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [aView.layer addAnimation:popAnimation forKey:nil];
  
}

@end
