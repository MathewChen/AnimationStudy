//
//  BrandingFactory.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/13.
//  Copyright © 2021 Star. All rights reserved.
//

#import "BrandingFactory.h"
#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"


@implementation BrandingFactory

+ (BrandingFactory *) factory {
    if (MXCompanyName == 0) {
        return [[AcmeBrandingFactory alloc] init];
    }else if (MXCompanyName == 1) {
        return [[AcmeBrandingFactory alloc] init];
    }else {
        return nil;
    }

}

- (UIView *)brandView {
    return nil;
}

- (UIButton *)brandedMainButton {
    return nil;
}

- (UIToolbar *)brandedToolbar {
    return nil;
}
@end
