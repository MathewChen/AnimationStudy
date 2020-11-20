//
//  ViewController.m
//  AnimationStudy
//
//  Created by mingxing on 2020/4/14.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "ViewController.h"
#import <QMUIKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImage *image = [UIImage imageNamed:@"123456.jpg"];
    
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(self.view.sh_centerX - 100, self.view.sh_centerY - 100, 200, 200);
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(0, 0, 300, 300);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [bgView.layer addSublayer:blueLayer];
    
//    UIImage *image = [UIImage imageNamed:@"123456.jpg"];
//
//    UIView *bgView = [[UIView alloc] init];
//    [self.view addSubview:bgView];
//    bgView.frame = CGRectMake(self.view.sh_centerX - 100, self.view.sh_centerY - 100, 200, 200);
//    bgView.frame = CGRectMake(self.view.sh_centerX - image.size.width/2, self.view.sh_centerY - image.size.height/2, image.size.width, image.size.height);
//    bgView.backgroundColor = UIColor.whiteColor;
//    bgView.contentMode = UIViewContentModeScaleAspectFit;
    
//    CALayer *blueLayer = [[CALayer alloc] init];
//    blueLayer.frame = CGRectMake(50, 50, 100, 100);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [bgView.layer addSublayer:blueLayer];
    

//    bgView.layer.contents = (__bridge id _Nullable)(image.CGImage);
//    bgView.layer.contentsGravity = kCAGravityResizeAspectFill;
    //set the contentsScale to match image
//    bgView.layer.contentsScale = 2;
//    bgView.layer.contentsScale = [UIScreen mainScreen].scale;
//    bgView.layer.masksToBounds = YES;
    
//    bgView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
}


@end
