//
//  MXTuyaVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXTuyaVC.h"
#import "BSBGraffitiView.h"
@interface MXTuyaVC ()

@property (nonatomic, strong) BSBGraffitiView *drawView;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation MXTuyaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.yellowColor;
    
    QMUIButton *showButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16, TOP_HEIGHT, 100, 40)];
    showButton.backgroundColor = UIColor.qmui_randomColor;
    [self.view addSubview:showButton];
    [showButton addTarget:self action:@selector(showTuyaView) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, showButton.sh_bottom, 375, 256)];
    [self.view addSubview:self.imageView];

}

- (void)showTuyaView {
    [UIView presentModalView:self.drawView withDuration:0.3];
}

- (BSBGraffitiView *)drawView {
    if (!_drawView) {
        _drawView = [[BSBGraffitiView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [KEYWINDOW addSubview:_drawView];
        WS(weakSelf);
        _drawView.graffitiImageBlock = ^(UIImage *graffitiImage) {
            weakSelf.imageView.image = graffitiImage;
        };
    }
    return _drawView;
}
@end
