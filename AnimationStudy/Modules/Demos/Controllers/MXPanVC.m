//
//  MXPanVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/6.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXPanVC.h"
#import "SimpleView.h"

@interface MXPanVC ()<SimpleViewDelegate>

@property(nonatomic, strong) SimpleView *simpleView;

@property(nonatomic, assign) NSInteger rotate;

@property (nonatomic, strong) CAShapeLayer *itemiDashesShapeLayer;
/// 绘制路径
@property (nonatomic, strong) UIBezierPath *itemiDashesPath;

@end

@implementation MXPanVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didInitialize {
    [super didInitialize];
    
    QMUIButton *rotateButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16, TOP_HEIGHT, 100, 50)];
    [rotateButton setTitle:@"旋转" forState:UIControlStateNormal];
    rotateButton.backgroundColor = UIColor.redColor;
    [self.view addSubview:rotateButton];
    [rotateButton addTarget:self action:@selector(clickRotateButton) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *restoreButton = [[QMUIButton alloc] initWithFrame:CGRectMake(rotateButton.qmui_right + 16, TOP_HEIGHT, 100, 50)];
    [restoreButton setTitle:@"复原" forState:UIControlStateNormal];
    restoreButton.backgroundColor = UIColor.redColor;
    [self.view addSubview:restoreButton];
    [restoreButton addTarget:self action:@selector(clickRestoreButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.simpleView = [[SimpleView alloc] initWithFrame:CGRectMake(16, 100, 150, 100)];
    self.simpleView.backgroundColor = UIColor.redColor;
    self.simpleView.delegate = self;
    [self.view addSubview:self.simpleView];
    
    [self.view.layer addSublayer:self.itemiDashesShapeLayer];
    
    [self.view bringSubviewToFront:self.simpleView];
}


- (void)clickRotateButton {
    self.rotate++;
    NSInteger rotate = self.rotate % 4;
    
    [self.simpleView itemRotate:rotate];
}

- (void)clickRestoreButton {
    [UIView animateWithDuration:0.5f animations:^{
        //复原
        self.simpleView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.simpleView.frame = CGRectMake(16, 100, 150, 100);
    }];
    
    
}

#pragma mark - SimpleViewDelegate

- (void)sipmleViewFrameWillChange:(CGRect)frame {
    
}

- (void)sipmleViewFrameChanging:(CGRect)frame {
    NSLog(@"frame:%@",NSStringFromCGRect(frame));
    [self itemDashesMoveSceneFrame:self.view.frame itemFrame:frame angle:0];
}

- (void)sipmleViewFrameChanged:(CGRect)frame {
    
}

#pragma mark - 虚线绘制

- (void)itemDashesMoveSceneFrame:(CGRect)sceneFrame itemFrame:(CGRect)itemFrame angle:(int)angle {
    //移除轨迹
    [_itemiDashesPath removeAllPoints];
    
    _itemiDashesPath = [UIBezierPath bezierPath];
    
    //item左边的线条
    [_itemiDashesPath moveToPoint:CGPointMake(itemFrame.origin.x, 0)];

    [_itemiDashesPath addLineToPoint:CGPointMake(itemFrame.origin.x, sceneFrame.size.height)];
    
    //item右边的线条
    [_itemiDashesPath moveToPoint:CGPointMake(itemFrame.origin.x + itemFrame.size.width, 0)];

    [_itemiDashesPath addLineToPoint:CGPointMake(itemFrame.origin.x + itemFrame.size.width, sceneFrame.size.height)];
    
    //item顶部的线条
    [_itemiDashesPath moveToPoint:CGPointMake(0, itemFrame.origin.y)];

    [_itemiDashesPath addLineToPoint:CGPointMake(sceneFrame.size.width, itemFrame.origin.y)];
    
    //item底部的线条
    [_itemiDashesPath moveToPoint:CGPointMake(0, itemFrame.origin.y + itemFrame.size.height)];

    [_itemiDashesPath addLineToPoint:CGPointMake(sceneFrame.size.width, itemFrame.origin.y + itemFrame.size.height)];
    
    self.itemiDashesShapeLayer.path = self.itemiDashesPath.CGPath;
}

#pragma mark - 初始化
- (CAShapeLayer *)itemiDashesShapeLayer {
    if (!_itemiDashesShapeLayer) {
        _itemiDashesShapeLayer = [CAShapeLayer layer];
        _itemiDashesShapeLayer.lineWidth = 1 ;
        _itemiDashesShapeLayer.strokeColor = UIColor.yellowColor.CGColor;
        _itemiDashesShapeLayer.fillColor = nil; // 默认为blackColor
        _itemiDashesShapeLayer.lineDashPattern =  @[@(5),@(2)];
        _itemiDashesShapeLayer.path = self.itemiDashesPath.CGPath;
//        _itemiDashesShapeLayer.hidden = YES;
    }
    return _itemiDashesShapeLayer;
}
@end
