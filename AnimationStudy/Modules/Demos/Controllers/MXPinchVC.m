//
//  MXPinchVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/3/16.
//  Copyright © 2021 dudian. All rights reserved.
//

#import "MXPinchVC.h"

@interface MXPinchVC ()

@property(nonatomic, strong) UIView *pinchView;

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
//    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchViewBegin:)];
//
//    [self.pinchView addGestureRecognizer:recognizer];
 
    UIPinchGestureRecognizer *recognizer2 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(viewBegin:)];
    
    [self.bgView addGestureRecognizer:recognizer2];
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
}

- (UIView *)pinchView {
    if (!_pinchView) {
        _pinchView = [[UIView alloc] init];
        _pinchView.backgroundColor = UIColor.qd_tintColor;
    }
    return _pinchView;
}
@end
