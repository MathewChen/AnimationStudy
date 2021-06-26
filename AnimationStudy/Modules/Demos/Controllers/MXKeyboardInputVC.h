//
//  MXKeyboardInputVC.h
//  AnimationStudy
//
//  Created by mingxing on 2021/6/2.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXCommonViewController.h"

static CGFloat const kToolbarHeight = 56;
static CGFloat const kEmotionViewHeight = 232;

@interface MXKeyboardInputVC : MXCommonViewController <QMUIKeyboardManagerDelegate>

@property(nonatomic, strong) QMUITextView *textView;

- (void)showInParentViewController:(UIViewController *)controller;

- (void)hide;

@end

