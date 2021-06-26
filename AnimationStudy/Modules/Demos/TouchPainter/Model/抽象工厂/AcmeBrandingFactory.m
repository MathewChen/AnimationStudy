//
//  AcmeBrandingFactory.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/13.
//  Copyright © 2021 Star. All rights reserved.
//

#import "AcmeBrandingFactory.h"

#import "AcmeView.h"
#import "AcmeMainButton.h"
#import "AcmeToolbar.h"

@implementation AcmeBrandingFactory

- (UIView *)brandView {
    return [[AcmeView alloc] init];
}

- (UIButton *)brandedMainButton {
    return [[AcmeMainButton alloc] init];
}

- (UIToolbar *)brandedToolbar {
    return [[AcmeToolbar alloc] init];
}
@end
