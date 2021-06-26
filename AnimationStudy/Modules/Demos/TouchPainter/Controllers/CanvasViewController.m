//
//  CanvasViewController.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "CanvasViewController.h"
#import "BrandingFactory.h"

@interface CanvasViewController ()


@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//- (void)didInitialize {
//    [super didInitialize];
//    
//    CanvasViewGenerator *defaultGenetator = [[CanvasViewGenerator alloc] init];
//    
//    [self loadCanvasViewWithGenerator:defaultGenetator];
//}
//
//- (void)loadView {
//    
//    BrandingFactory *factory = [BrandingFactory factory];
//    
//    UIView *view = [factory brandView];
//    
//    UIButton *button = [factory brandedMainButton];
//    
//    UIToolbar *toobar = [factory brandedToolbar];
//    
//    [self.view addSubview:view];
//    [self.view addSubview:button];
//    [self.view addSubview:toobar];
//}
////限于篇幅，略去了无关的方法
//
//#pragma mark - Loading a CanvasView from a CanvasViewGenerator
//
//- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator {
//    [self.canvasView removeFromSuperview];
//    CGRect aFrame = CGRectMake(0, 100, SCREEN_WIDTH, 500);
//    CanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
//    self.canvasView = aCanvasView;
//    [self.view addSubview:self.canvasView];
//}
@end
