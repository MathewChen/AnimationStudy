//
//  MXThemeManager.h
//  AnimationStudy
//
//  Created by mingxing on 2020/5/27.
//  Copyright © 2020 dudian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXThemeProtocol.h"

/// 简单对 QMUIThemeManager 做一层业务的封装，省去类型转换的工作量
@interface MXThemeManager : NSObject

@property(class, nonatomic, readonly, nullable) NSObject<MXThemeProtocol> *currentTheme;

@end

@interface UIColor (QDTheme)

@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColorLighten;
@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColorHighlighted;
@property(class, nonatomic, strong, readonly) UIColor *qd_tintColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_titleTextColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_mainTextColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_descriptionTextColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_placeholderColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_codeColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_separatorColor;
@property(class, nonatomic, strong, readonly) UIColor *qd_gridItemTintColor;
@end

@interface UIImage (QDTheme)

@property(class, nonatomic, strong, readonly) UIImage *qd_searchBarTextFieldBackgroundImage;
@property(class, nonatomic, strong, readonly) UIImage *qd_searchBarBackgroundImage;
@end

@interface UIVisualEffect (QDTheme)

@property(class, nonatomic, strong, readonly) UIVisualEffect *qd_standardBlurEffect;
@end
