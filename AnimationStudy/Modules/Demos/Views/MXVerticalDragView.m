//
//  MXVerticalDragView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/9/29.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXVerticalDragView.h"
#import "GenericPanGestureHandler.h"
#import "UIView+Extension.h"
@interface MXVerticalDragView ()

@property (nonatomic, strong) GenericPanGestureHandler *bottomBarGestureHandler;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomBarCoverView;
@property (nonatomic, strong) UIView *bottomOperateView;

@end

@implementation MXVerticalDragView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.bottomBar];
    [self addSubview:self.bottomOperateView];
    
//    self.bottomBar.bottom = SCREEN_HEIGHT;
    self.bottomOperateView.qmui_top = self.bottomBar.qmui_bottom;
    self.qmui_top = SCREEN_HEIGHT - 267 - SAFE_BOTTOM;
    for (int i = 0; i < 10; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = UIColor.whiteColor;
        bgView.frame = CGRectMake(16, 44 * i, 100, 40);
        [self.bottomOperateView addSubview:bgView];
    }

    __weak typeof(self) weakSelf = self;
//    self.bottomBarGestureHandler = [[GenericPanGestureHandler alloc] initWithGestureView:self.bottomBarCoverView handleView:self.bottomBar minY:TOP_HEIGHT midY:SCREEN_HEIGHT - 315 - SAFE_BOTTOM maxY:SCREEN_HEIGHT - self.bottomBar.height];
    self.bottomBarGestureHandler = [[GenericPanGestureHandler alloc] initWithGestureView:self.bottomBarCoverView handleView:self minY:TOP_HEIGHT midY:SCREEN_HEIGHT - 315 - SAFE_BOTTOM maxY:SCREEN_HEIGHT - self.bottomBar.qmui_height];
    self.bottomBarGestureHandler.offsetChangeBlock = ^(CGFloat afterY, CGFloat offsetY, BOOL direction) {
//        weakSelf.bottomOperateView.y = weakSelf.bottomBar.bottom;
        if (afterY < SCREEN_HEIGHT - 267 - 48) {
//            weakSelf.bottomOperateView.height = SCREEN_HEIGHT - self.bottomOperateView.y;
            weakSelf.bottomOperateView.qmui_height = SCREEN_HEIGHT - self.qmui_top - 48;
        }else {
            weakSelf.bottomOperateView.qmui_height = 267;
        }
        if (afterY < SCREEN_HEIGHT && weakSelf.bottomOperateView.hidden) {
            weakSelf.bottomOperateView.hidden = NO;
        }
    };
    self.bottomBarGestureHandler.shouldResponseGesture = ^BOOL{
        return YES;
    };
    self.bottomBarGestureHandler.offsetCompleteBlock = ^{
        NSLog(@"do something");
    };
}

#pragma mark - getter

- (UIView *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        [_bottomBar addSubview:self.bottomBarCoverView];
        
        _bottomBar.backgroundColor = [UIColor redColor];
        _bottomBar.layer.shadowColor = [[UIColor blackColor] CGColor];
        _bottomBar.layer.shadowOffset = CGSizeMake(0, 2);
        _bottomBar.layer.shadowOpacity = 0.14;
        _bottomBar.layer.shadowRadius = 3;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"拖拽我 Drag me";
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        [_bottomBar addSubview:label];
//        label.centerX = _bottomBar.qmui_width * 0.5;
//        label.centerY = _bottomBar.qmui_height * 0.5;
    }
    return _bottomBar;
}

- (UIView *)bottomBarCoverView {
    if (!_bottomBarCoverView) {
        _bottomBarCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        _bottomBarCoverView.backgroundColor = UIColor.yellowColor;
    }
    return _bottomBarCoverView;
}

- (UIView *)bottomOperateView {
    if (!_bottomOperateView) {
        _bottomOperateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 267 + SAFE_BOTTOM)];
        _bottomOperateView.backgroundColor = [UIColor colorWithRed:1.0 green:102.0/255.0 blue:0 alpha:1.0];
    }
    return _bottomOperateView;
}
@end
