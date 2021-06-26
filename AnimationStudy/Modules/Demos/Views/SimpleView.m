//
//  SimpleView.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/6.
//  Copyright © 2021 Star. All rights reserved.
//

#import "SimpleView.h"

@interface SimpleView ()

@property(nonatomic, strong) UIView *leftHandle;

@property(nonatomic, strong) UILabel *label;
@end

@implementation SimpleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 拖动
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
        // 缩放
        [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)]];
        // 旋转
        [self addGestureRecognizer:[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)]];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
        self.label.text = @"我就是测试sdfsdfksdfhsdfsdfLDFKG第三方";
        self.label.textColor = [UIColor colorWithHexString:@"#125236"];
        self.label.font = FUNC_FONT(16);
        [self addSubview:self.label];
        self.label.numberOfLines = 0;
        
        self.leftHandle = [[UIView alloc] initWithFrame:CGRectMake(150 - 25, 25, 50, 50)];
        [self addSubview:self.leftHandle];
        self.leftHandle.backgroundColor = UIColor.blueColor;
        
        UIPanGestureRecognizer *leftHandlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandlePanAction:)];
        [self.leftHandle addGestureRecognizer:leftHandlePan];
    }
    return self;
}
 
#pragma mark - 手势
 
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果父视图也实现了Pan手势，放到子视图后可能会造成子视图Pan手势失效，需要特殊处理一下
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && ![gestureRecognizer.view isEqual:self])
    {
        return NO;
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}
 
- (void)panAction:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *piece = [gestureRecognizer view];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        piece.center = CGPointMake(piece.center.x + translation.x, piece.center.y + translation.y);
        
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameWillChange:)]) {
        [self.delegate sipmleViewFrameWillChange:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameChanging:)]) {
        [self.delegate sipmleViewFrameChanging:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(sipmleViewFrameChanged:)]) {
        [self.delegate sipmleViewFrameChanged:self.frame];
    }
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
 
- (void)pinchAction:(UIPinchGestureRecognizer *)gestureRecognizer {
    self.transform = CGAffineTransformScale(self.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    gestureRecognizer.scale = 1.0f;
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameWillChange:)]) {
        [self.delegate sipmleViewFrameWillChange:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameChanging:)]) {
        [self.delegate sipmleViewFrameChanging:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(sipmleViewFrameChanged:)]) {
        [self.delegate sipmleViewFrameChanged:self.frame];
    }
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
 
- (void)rotationAction:(UIRotationGestureRecognizer *)gestureRecognizer {
    self.transform = CGAffineTransformRotate(self.transform, gestureRecognizer.rotation);
    gestureRecognizer.rotation = 0;
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameWillChange:)]) {
        [self.delegate sipmleViewFrameWillChange:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameChanging:)]) {
        [self.delegate sipmleViewFrameChanging:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(sipmleViewFrameChanged:)]) {
        [self.delegate sipmleViewFrameChanged:self.frame];
    }
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state {

    self.transform = CGAffineTransformRotate(self.transform, 90 * M_PI / 180);
}

/// handle拉伸
/// @param pan 移动手势
- (void)leftHandlePanAction:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self hf_setAnchorPoint:CGPointMake(0, 0.5)];
    }
    
    CGPoint translation = [pan translationInView:self];
    UIView *targetView = pan.view;
    
    CGRect bounds = self.bounds;
    bounds.size.width = MAX(bounds.size.width + translation.x, 50);
    self.bounds = bounds;
    
    
    
//    [pan setTranslation:CGPointZero inView:self];
    
    
    targetView.center = CGPointMake(targetView.center.x + translation.x, targetView.center.y);
    
    [pan setTranslation:CGPointZero inView:[targetView superview]];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self hf_setAnchorPoint:CGPointMake(0.5, 0.5)];
    }
    
    if ([pan state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameWillChange:)]) {
        [self.delegate sipmleViewFrameWillChange:self.frame];
    }
    
    if ([pan state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(sipmleViewFrameChanging:)]) {
        [self.delegate sipmleViewFrameChanging:self.frame];
    }
    
    if ([pan state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(sipmleViewFrameChanged:)]) {
        [self.delegate sipmleViewFrameChanged:self.frame];
    }
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)hf_setAnchorPoint:(CGPoint)anchorPoint {
    CGPoint newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = anchorPoint;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subview in self.subviews) {
            CGPoint p = [subview convertPoint: point fromView:self];
            if (CGRectContainsPoint(subview.bounds, p)) {
                return subview;
            }
        }
    }
    return view;
}
@end
