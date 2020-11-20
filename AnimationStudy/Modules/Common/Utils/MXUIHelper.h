//
//  MXUIHelper.h
//  AnimationStudy
//
//  Created by mingxing on 2020/5/25.
//  Copyright © 2020 dudian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXUIHelper : NSObject

+ (void)forceInterfaceOrientationPortrait;

@end

@interface MXUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;

@end


@interface MXUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;

@end

@interface MXUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance;

@end


@interface MXUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance;
@end


@interface MXUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance;

@end


@interface MXUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end


@interface MXUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;

@end


@interface MXUIHelper (Emotion)

+ (NSArray<QMUIEmotion *> *)qmuiEmotions;

/// 用于主题更新后，更新表情 icon 的颜色
+ (void)updateEmotionImages;
@end


@interface MXUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied;

@end


@interface MXUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;
    
@end


@interface MXUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color;
@end


@interface NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *codeString, NSRange codeRange))block;

@end


