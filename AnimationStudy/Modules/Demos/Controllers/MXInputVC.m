//
//  MXInputVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/2.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXInputVC.h"
#import "MXKeyboardInputVC.h"


@interface MXInputVC ()

@property(nonatomic, strong) QMUIButton *writeReviewButton;

@property(nonatomic, strong) MXKeyboardInputVC *customViewController;

@end

@implementation MXInputVC

- (void)didInitialize {
    [super didInitialize];
    
    _writeReviewButton = [MXUIHelper generateLightBorderedButton];
    [self.writeReviewButton setTitle:@"发表想法" forState:UIControlStateNormal];
    [self.writeReviewButton addTarget:self action:@selector(handleWriteReviewItemEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.writeReviewButton];
    self.writeReviewButton.frame = CGRectMake(15, 100, 150, 44);
}

- (void)handleWriteReviewItemEvent:(id)sender {

    if (!self.customViewController) {
        self.customViewController = [[MXKeyboardInputVC alloc] init];
    }
    if (!self.customViewController.view.superview) {
        [self.customViewController showInParentViewController:self.navigationController];
    } else {
        [self.customViewController.textView resignFirstResponder];
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.customViewController.view.superview) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return self.supportedOrientationMask;
    }
}
@end
