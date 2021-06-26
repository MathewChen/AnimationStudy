//
//  SierraBrandingFactory.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/13.
//  Copyright © 2021 Star. All rights reserved.
//

#import "SierraBrandingFactory.h"
#import "SierraView.h"
#import "SierraToolBar.h"
#import "SierraMainButton.h"

@implementation SierraBrandingFactory

- (UIView *)brandView {
    return [[SierraView alloc] init];
}

- (UIButton *)brandedMainButton {
    return [[SierraMainButton alloc] init];
}

- (UIToolbar *)brandedToolbar {
    return [[SierraToolBar alloc] init];
}

@end
