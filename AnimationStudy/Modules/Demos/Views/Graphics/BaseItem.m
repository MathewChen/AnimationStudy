//
//  BaseItemView.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import "BaseItem.h"
#import "FontItem.h"

@interface BaseItem ()

@property(nonatomic, strong) UIView *leftHandle;

@end

@implementation BaseItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.randomColor;
        _rectArray = [[NSMutableArray alloc] init];
        _rectUndoArray = [[NSMutableArray alloc] init];
        [self buildBaseItemUI];
    }
    return self;
}

- (void)buildBaseItemUI {
    
    // 拖动
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
    
    self.leftHandle = [[UIView alloc] initWithFrame:CGRectMake(100 - 20, 0, 40, 40)];
    [self addSubview:self.leftHandle];
    self.leftHandle.backgroundColor = UIColor.randomColor;
//    [self.leftHandle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self).offset(self.qmui_width - 20);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
    
    UIPanGestureRecognizer *leftHandlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandlePanAction:)];
    [self.leftHandle addGestureRecognizer:leftHandlePan];
}

+ (BaseItem *)createItemWidthType:(ItemType)type image:(UIImage *)image AndFrame:(CGRect)rect ImgUrl:(NSString *)url {
    BaseItem *item;
    item.userInteractionEnabled = YES;
    switch (type) {
            
        case Font: {
            item = [[FontItem alloc]initWithFrame:rect];
            item.itemType = Font;
        }
            
            break;
        default:
            break;
    }
    return item;
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
    
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
    NSLog(@"%@ | %@ | %f",NSStringFromCGSize(self.frame.size),NSStringFromCGSize(self.bounds.size),self.contentScaleFactor);
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(itemFrameWillChange:)]) {
        self.moveRect = self.frame;
        [self.delegate itemFrameWillChange:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(itemFrameChanging:)]) {
        [self.delegate itemFrameChanging:self.frame];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(itemFrameChanged:Item:)]) {
        [self.delegate itemFrameChanged:self.frame Item:self];
    }
    
    [self baseItemPan];
}

- (void)baseItemPan {
    
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
    
    /*
     center.y决定用 bounds.size.height / 2 是因为需要拖动handle需要时刻处在Item中部。
     */
    targetView.center = CGPointMake(targetView.center.x + translation.x, bounds.size.height / 2);
    
    
    [pan setTranslation:CGPointZero inView:[targetView superview]];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self hf_setAnchorPoint:CGPointMake(0.5, 0.5)];
    }
    
    if ([pan state] == UIGestureRecognizerStateBegan && self.delegate && [self.delegate respondsToSelector:@selector(itemFrameWillChange:)]) {
        [self.delegate itemFrameWillChange:self.frame];
    }
    
    if ([pan state] == UIGestureRecognizerStateChanged && self.delegate && [self.delegate respondsToSelector:@selector(itemFrameChanging:)]) {
        [self.delegate itemFrameChanging:self.frame];
    }
    
    if ([pan state] == UIGestureRecognizerStateEnded && self.delegate &&  [self.delegate respondsToSelector:@selector(itemFrameChanged:Item:)]) {
        [self.delegate itemFrameChanged:self.frame Item:self];
    }
    
    [self leftHandlePan];
}

- (void)leftHandlePan {
    
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

/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state {

    self.transform = CGAffineTransformRotate(self.transform, 90 * M_PI / 180);
}
@end
