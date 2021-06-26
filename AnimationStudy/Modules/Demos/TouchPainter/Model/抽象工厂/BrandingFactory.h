//
//  BrandingFactory.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/13.
//  Copyright © 2021 Star. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BrandingFactory : NSObject

+ (BrandingFactory *) factory;

- (UIView *)brandView;

- (UIButton *)brandedMainButton;

- (UIToolbar *)brandedToolbar;

@end


