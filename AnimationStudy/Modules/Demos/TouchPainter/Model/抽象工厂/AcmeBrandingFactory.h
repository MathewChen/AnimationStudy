//
//  AcmeBrandingFactory.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/13.
//  Copyright © 2021 Star. All rights reserved.
//

#import "BrandingFactory.h"

@interface AcmeBrandingFactory : BrandingFactory

- (UIView *)brandView;

- (UIButton *)brandedMainButton;

- (UIToolbar *)brandedToolbar;

@end

