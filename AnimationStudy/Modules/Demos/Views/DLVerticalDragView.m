//
//  DLVerticalDragView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/9/30.
//  Copyright © 2020 Star. All rights reserved.
//

#import "DLVerticalDragView.h"
#import "UIView+Extension.h"

static const CGFloat titleLabelHeight = 48.f;
static const CGFloat titleLabelLeftLeading = 12.f;
static const CGFloat titleLabelTopLeading = 16.f;
static const CGFloat contentViewHeight = 267.f;



//发布动态的键盘状态
typedef NS_ENUM(NSInteger, BottomBarLevelType) {
    BottomBarLevelTypeMin = 0,
    BottomBarLevelTypeMid,
    BottomBarLevelTypeMax
};

@interface DLVerticalDragView ()


@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomBarCoverView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *desLabel;



//操作的对象视图
@property (nonatomic, weak) UIView *handleView;
//手势的对象视图
//@property (nonatomic, weak) UIView *gestureView;
//当前的手势触发位置
@property (nonatomic, assign) CGPoint currentPoint;
//当前的拖动方向
@property (nonatomic, assign) BOOL directionUp;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BottomBarLevelType levelType;

//额外的高度
@property (nonatomic, assign)  CGFloat extraHeight;

@end

@implementation DLVerticalDragView

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
    [self.bottomBar addSubview:self.bottomBarCoverView];
    [self.bottomBarCoverView addSubview:self.titleLabel];
    [self.bottomBarCoverView addSubview:self.desLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomBarCoverView);
        make.left.mas_equalTo(self.bottomBarCoverView).offset(titleLabelLeftLeading);
        make.top.mas_equalTo(self.bottomBarCoverView).offset(titleLabelTopLeading);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self.bottomOperateView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    self.bottomOperateView.qmui_top = self.bottomBar.qmui_bottom;
    self.qmui_top = SCREEN_HEIGHT - SAFE_BOTTOM - contentViewHeight;
    
    self.handleView = self;
    self.minY = TOP_HEIGHT;
    self.midY = SCREEN_HEIGHT - SAFE_BOTTOM - contentViewHeight - titleLabelHeight;
    self.maxY = SCREEN_HEIGHT - self.bottomBar.qmui_height;
    _directionUp = YES;
    _currentPoint = CGPointZero;
    _levelType = BottomBarLevelTypeMid;
    [self.bottomBarCoverView addGestureRecognizer:self.panGesture];
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    CGPoint pointInSuperview = [gesture locationInView:self.handleView.superview];
    CGPoint pointVelocity = [gesture velocityInView:self.handleView];
    
    CGFloat afterY = 0;
    CGFloat distance = 0;
    distance = pointInSuperview.y - self.currentPoint.y;
    afterY = self.handleView.qmui_top + distance;
    NSLog(@"distance = %f afterY = %f",distance,afterY);
    //识别器已经接收识别为此手势(状态)的触摸(Began)
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.currentPoint = pointInSuperview;
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        if (afterY <= self.minY) {
            afterY = self.minY;
        }
        self.handleView.qmui_top = afterY;
        CGFloat offsetY = 0;
        if (self.levelType == BottomBarLevelTypeMin) {
            offsetY = afterY - self.minY;
        }else if (self.levelType == BottomBarLevelTypeMid) {
            offsetY = afterY - self.midY;
        }else {
            offsetY = afterY - self.maxY;
        }
        [self offsetChange:afterY];
        self.currentPoint = pointInSuperview;
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        self.currentPoint = pointInSuperview;
        [self autoBackLocation:pointVelocity];
    }
}

- (void)autoBackLocation:(CGPoint)velocity {
    if (self.handleView == nil) {
        return;
    }
    if (self.handleView.qmui_top < self.minY * 0.5 + self.midY * 0.5) {
        if (velocity.y > 50) {
            self.directionUp = false;
            self.levelType = BottomBarLevelTypeMid;
        }else {
            self.directionUp = true;
            self.levelType = BottomBarLevelTypeMin;
        }
    }else if ((self.handleView.qmui_top >= self.minY * 0.5 + self.midY * 0.5) && (self.handleView.qmui_top < self.maxY * 0.5 + self.midY * 0.5)) {
        if (velocity.y > 50) {
            self.directionUp = false;
            self.levelType = BottomBarLevelTypeMax;
        }else if (velocity.y < -50) {
            self.directionUp = true;
            self.levelType = BottomBarLevelTypeMin;
        }else {
            self.directionUp = self.handleView.qmui_top > self.midY;
            self.levelType = BottomBarLevelTypeMid;
        }
    }else if (self.handleView.qmui_top >= self.maxY * 0.5 + self.midY * 0.5) {
        if (velocity.y < -50) {
            self.directionUp = true;
            self.levelType = BottomBarLevelTypeMid;
        }else {
            self.directionUp = false;
            self.levelType = BottomBarLevelTypeMax;
        }
    }else {
        
    }
    NSLog(@"是否向上 %d", self.directionUp);
}

- (void)offsetChange:(CGFloat)afterY {
    if (afterY < SCREEN_HEIGHT - contentViewHeight - titleLabelHeight) {

        self.bottomOperateView.qmui_height = SCREEN_HEIGHT - self.qmui_top - titleLabelHeight;
    }else {
        self.bottomOperateView.qmui_height = contentViewHeight;
    }
    if (afterY < SCREEN_HEIGHT && self.bottomOperateView.hidden) {
        self.bottomOperateView.hidden = NO;
    }
    
}

- (CGFloat)bottomOperateViewHeightChange:(CGFloat)afterY handleViewTop:(CGFloat)handleViewTop {
    
    CGFloat bottomOperateViewHeight = 0;
    
    if (afterY < SCREEN_HEIGHT - contentViewHeight - titleLabelHeight) {
        bottomOperateViewHeight = SCREEN_HEIGHT - handleViewTop - titleLabelHeight;
    }else {
        bottomOperateViewHeight = contentViewHeight;
    }
    if (afterY < SCREEN_HEIGHT && self.bottomOperateView.hidden) {
        self.bottomOperateView.hidden = NO;
    }
    
    return bottomOperateViewHeight;
}

#pragma mark - setter & getter

- (void)setLevelType:(BottomBarLevelType)levelType {
    _levelType = levelType;
    __block CGFloat offsetY = 0;
    
    CGFloat bottomOperateViewHeight = 0;
    CGFloat handleViewTop = 0;
    
    if (levelType == BottomBarLevelTypeMin) {
        
        offsetY = self.handleView.qmui_top - self.minY;
        handleViewTop = self.minY - self.extraHeight;
        bottomOperateViewHeight = [self bottomOperateViewHeightChange:self.minY handleViewTop:handleViewTop];
        
    }else if (levelType == BottomBarLevelTypeMid) {
        
        offsetY = self.handleView.qmui_top - self.midY;
        handleViewTop = self.midY - self.extraHeight;
        bottomOperateViewHeight = [self bottomOperateViewHeightChange:self.minY handleViewTop:handleViewTop];
        
    }else if (levelType == BottomBarLevelTypeMax) {
        
        offsetY = self.handleView.qmui_top - self.maxY;
        handleViewTop = self.maxY - self.extraHeight;
        bottomOperateViewHeight = [self bottomOperateViewHeightChange:self.minY handleViewTop:handleViewTop];
        
    }
    
    [self levelTypeDidChange:bottomOperateViewHeight];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.handleView.qmui_top = handleViewTop;
        self.bottomOperateView.qmui_height = bottomOperateViewHeight;
        
    } completion:^(BOOL finished) {
        NSLog(@"do something");
    }];
}

- (void)levelTypeDidChange:(CGFloat)bottomOperateViewHeight {
    
}

- (void)setDragViewTitle:(NSString *)dragViewTitle {
    _dragViewTitle = dragViewTitle;
    self.titleLabel.text = dragViewTitle;
}

- (void)setDragViewDesStr:(NSString *)dragViewDesStr {
    _dragViewDesStr = dragViewDesStr;
    self.desLabel.text = dragViewDesStr;
}

#pragma mark - 懒加载

- (UIView *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleLabelHeight)];
        _bottomBar.backgroundColor = [UIColor redColor];
        _bottomBar.layer.shadowColor = [[UIColor blackColor] CGColor];
        _bottomBar.layer.shadowOffset = CGSizeMake(0, 2);
        _bottomBar.layer.shadowOpacity = 0.14;
        _bottomBar.layer.shadowRadius = 3;
        
    }
    return _bottomBar;
}

- (UIView *)bottomBarCoverView {
    if (!_bottomBarCoverView) {
        _bottomBarCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleLabelHeight)];
        _bottomBarCoverView.backgroundColor = UIColor.yellowColor;
    }
    return _bottomBarCoverView;
}

- (UIView *)bottomOperateView {
    if (!_bottomOperateView) {
        _bottomOperateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentViewHeight + SAFE_BOTTOM)];
        _bottomOperateView.backgroundColor = [UIColor colorWithRed:1.0 green:102.0/255.0 blue:0 alpha:1.0];
    }
    return _bottomOperateView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.textColor = COLOR333;
        _titleLabel.font = FUNC_FONT(14);
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
//        _desLabel.textColor = 9a9a9a
        _desLabel.font = FUNC_FONT(12);
        _desLabel.text = @"";
    }
    return _desLabel;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    }
    return _panGesture;
}
@end
