//
//  MXCommonViewController.m
//  AnimationStudy
//
//  Created by mingxing on 2020/5/25.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXCommonViewController.h"

@interface MXCommonViewController ()

@end

@implementation MXCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsUITest) {
        self.view.accessibilityLabel = [NSString stringWithFormat:@"viewController-%@", self.title];
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (IsUITest && self.isViewLoaded) {
        self.view.accessibilityLabel = [NSString stringWithFormat:@"viewController-%@", self.title];
    }
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

@end
