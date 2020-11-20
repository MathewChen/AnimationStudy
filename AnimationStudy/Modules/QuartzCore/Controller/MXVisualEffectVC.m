//
//  MXVisualEffectVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/8/18.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXVisualEffectVC.h"

@interface MXVisualEffectVC ()

@property(nonatomic, strong) UIView *layerView1;
@property(nonatomic, strong) UIView *layerView2;
@property(nonatomic, strong) UIView *shadowView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *containerView;
@end

@implementation MXVisualEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.qmui_randomColor;
    
//    [self cornerRadiusAndShadowOpacity];
    [self shadowPath];
//    [self layerMask];
//    [self opacity];
}

///圆角阴影
- (void)cornerRadiusAndShadowOpacity {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(16, 100, 150, 150)];
    leftView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:leftView];
    
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView1.backgroundColor = UIColor.whiteColor;
    [leftView addSubview:self.layerView1];
    
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(16, leftView.qmui_bottom + 32, 150, 150)];
    self.shadowView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.shadowView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    rightView.backgroundColor = UIColor.clearColor;
    [self.shadowView addSubview:rightView];
    
    
    
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView2.backgroundColor = UIColor.whiteColor;
    [rightView addSubview:self.layerView2];
    
    //set the corner radius on our layers
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    //add a shadow to layerView1
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView1.layer.shadowRadius = 5.0f;
    //add same shadow to shadowView (not layerView2)
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    //enable clipping on the second layer
    self.layerView2.layer.masksToBounds = YES;
    //如果layerView1也裁剪，那么他的阴影效果也将消失。
    //self.layerView1.layer.masksToBounds = YES;
    
    UIView *leftRedView = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
    leftRedView.backgroundColor = UIColor.redColor;
    [self.layerView1 addSubview:leftRedView];
    
    UIView *rightRedView = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
    rightRedView.backgroundColor = UIColor.redColor;
    [self.layerView2 addSubview:rightRedView];
}

/// 阴影形状
- (void)shadowPath {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(16, 100, 150, 150)];
    leftView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:leftView];
    
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView1.backgroundColor = UIColor.whiteColor;
    [leftView addSubview:self.layerView1];
    
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(16, leftView.qmui_bottom + 32, 150, 150)];
    self.shadowView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.shadowView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    rightView.backgroundColor = UIColor.clearColor;
    [self.shadowView addSubview:rightView];
    
    
    
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView2.backgroundColor = UIColor.clearColor;
    [rightView addSubview:self.layerView2];
    
    //enable layer shadows
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView2.layer.shadowOpacity = 0.5f;
    //create a square shadow
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    //create a circular shadow
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    self.layerView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
    //使用贝塞尔曲线画出阴影
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    self.layerView2.layer.shadowPath = path.CGPath;
}

/// 图版蒙层
- (void)layerMask {
    //create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"icon_tabbar_uikit"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 100, 150, 150)];
    self.imageView.image = UIImageMake(@"navigationbar_background");
    [self.view addSubview:self.imageView];
    
    self.imageView.layer.mask = maskLayer;
    
}

/// 拉伸过滤
- (void)ficationFilter {
    
}

/// 组透明
- (void)opacity {
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300)];
    self.containerView.backgroundColor = UIColor.qmui_randomColor;
    [self.view addSubview:self.containerView];
    
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(100, 150);
    [self.containerView addSubview:button1];
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(300, 150);
    button2.alpha = 0.5;
    [self.containerView addSubview:button2];
    //enable rasterization for the translucent button
//    button2.layer.shouldRasterize = YES;
//    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIButton *)customButton {
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame]; button.backgroundColor = [UIColor whiteColor]; button.layer.cornerRadius = 10;
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.whiteColor;
    [button addSubview:label];
    return button;
    
}

@end
