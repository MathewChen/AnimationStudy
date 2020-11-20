//
//  MXIconVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXIconVC.h"

@interface MXIconVC ()

@end

@implementation MXIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:imageView];
    imageView.image = UIImageMake(@"icon_tabbar_uikit_selected");
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, 200, 200)];
    [self.view addSubview:imageView2];
    imageView2.image = UIImageMake(@"alignmentRight_selected");
}

@end
