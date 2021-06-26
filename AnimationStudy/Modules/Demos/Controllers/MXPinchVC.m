//
//  MXPinchVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/3/16.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXPinchVC.h"

@interface MXPinchVC ()

@property(nonatomic, strong) UIView *pinchView;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UIView *bgView;

@end

@implementation MXPinchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didInitialize {
    [super didInitialize];
    
    
    
    self.bgView = [[UIView alloc] initWithFrame:self.view.frame];
    self.bgView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.bgView];

    CGFloat pinchWidth = 200.f;
    self.pinchView.frame = CGRectMake((SCREEN_WIDTH - pinchWidth) / 2, (SCREEN_HEIGHT - pinchWidth) / 2, pinchWidth, pinchWidth);
    [self.bgView addSubview:self.pinchView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 300, 100)];
    self.label.text = @"我就是来测试";
    self.label.font = UIFontMake(40);
    self.label.textColor = UIColor.blueColor;
    [self.bgView addSubview:self.label];
    
//    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchViewBegin:)];
//
//    [self.pinchView addGestureRecognizer:recognizer];

    UIPinchGestureRecognizer *recognizer2 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(viewBegin:)];

    [self.bgView addGestureRecognizer:recognizer2];
    
//    NSString *textStr = @"点击手势触发事件";
//    UIImage *image = [UIImage qmui_imageWithColor:UIColor.whiteColor size:CGSizeMake(100, 100) cornerRadius:0];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 160, 160)];
//    imageView.image = [self createShareImage:textStr of:image];
//    [self.view addSubview:imageView];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 160, 160)];
//
//
//
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:textStr];
//    [attributeString addAttributes:@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 16 ], NSForegroundColorAttributeName :[ UIColor redColor ] } range:NSMakeRange(0, textStr.length)];
//    label.attributedText = attributeString;
//    [self.view addSubview:label];
}

- ( UIImage *)createShareImage:( NSString *)str of:(UIImage *)isImage {
    
    UIImage *image = isImage;
    
    CGSize size= CGSizeMake (image. size . width , image. size . height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );
    
    [image drawAtPoint : CGPointMake ( 0 , 0 )];
    
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext ();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    
    [str drawAtPoint : CGPointMake ( 0 , 0) withAttributes : @{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 16 ], NSForegroundColorAttributeName :[ UIColor redColor ] } ];
    
    //画自己想画的内容。。。。。
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}

#pragma mark - 点击手势触发事件

//-(void)pinchViewBegin:(UIPinchGestureRecognizer *)pinch {
//    NSLog(@"识别到了捏合手势 scale = %f",pinch.scale);
//    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale,pinch.scale);
//    pinch.scale = 1;
//
//}

-(void)viewBegin:(UIPinchGestureRecognizer *)pinch {
    NSLog(@"识别到了self.view捏合手势 scale = %f",pinch.scale);
//    self.pinchView.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale,pinch.scale);
//    pinch.scale = 1;
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale,pinch.scale);
    pinch.scale = 1;
    NSLog(@"bgView.size = %@",NSStringFromCGSize(self.bgView.frame.size));
}

- (UIView *)pinchView {
    if (!_pinchView) {
        _pinchView = [[UIView alloc] init];
        _pinchView.backgroundColor = UIColor.qd_tintColor;
    }
    return _pinchView;
}
@end
