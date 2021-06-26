//
//  PaperView.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import "PaperView.h"



@interface PaperView ()

@end

@implementation PaperView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = UIColor.randomColor;
    // 拖动
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
    // 缩放
    [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)]];
    
    self.totalScale = 1.0;
}

#pragma mark - 手势
 
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果父视图也实现了Pan手势，放到子视图后可能会造成子视图Pan手势失效，需要特殊处理一下
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && ![gestureRecognizer.view isEqual:self]) {
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
    
}
 
- (void)pinchAction:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    self.transform = CGAffineTransformScale(self.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    
    self.totalScale *= gestureRecognizer.scale;
    NSLog(@"totalScale : %f | frame:%@",self.totalScale,NSStringFromCGRect(self.frame));
    
    gestureRecognizer.scale = 1.0f;
    
}

- (BaseItem *)addItem {
    BaseItem *item = [BaseItem createItemWidthType:Font image:nil AndFrame:CGRectMake(16, 16, 100, 40) ImgUrl:nil];
    
    [self addSubview:item];
    
    [self.viewList addObject:item];
    
    return item;
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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [super pointInside:point withEvent:event];
    
    return YES;
}

/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state {
    
    BaseItem *item = [self.viewList firstObject];
    
    item.transform = CGAffineTransformRotate(item.transform, 90 * M_PI / 180);
}

/// item字体大小
/// @param state 旋转方式
- (void)itemFontChange:(NSInteger)state {
    
    FontItem *item = (FontItem *)[self.viewList firstObject];
    
//    if (state == 0) {
//        item.labelFontSize +=2;
//    }else {
//        item.labelFontSize -=2;
//    }
    
    CGRect bounds = item.bounds;
    bounds.size.width += 20;
    item.bounds = bounds;
}

/// item移动
/// @param state 旋转方式
- (void)itemMove:(RotateState)state {
    
    BaseItem *item = [self.viewList firstObject];
    
    CGPoint centerPoint = CGPointMake(0, 0);
    switch (state) {
        case RotateStateTop:
            centerPoint = item.center;
            centerPoint.y -= 10;
            item.center = centerPoint;
            break;
        case RotateStateBottom:
            centerPoint = item.center;
            centerPoint.y += 10;
            item.center = centerPoint;
            break;
        case RotateStateLeft:
            centerPoint = item.center;
            centerPoint.x -= 10;
            item.center = centerPoint;
            break;
        default:
            centerPoint = item.center;
            centerPoint.x += 10;
            item.center = centerPoint;
            break;
    }
}

/// item文字对齐方式
/// @param aliment 对齐方式
- (void)itemTextAliment:(NSInteger)aliment {
    
    FontItem *item = (FontItem *)[self.viewList firstObject];
    
    item.currentSegIndex = aliment;
}

#pragma mark - 初始化

- (NSMutableArray<BaseItem *> *)viewList {
    if (!_viewList) {
        _viewList = [[NSMutableArray alloc] init];
    }
    return _viewList;
}

@end
