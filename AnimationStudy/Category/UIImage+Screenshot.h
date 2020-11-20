//
//  UIImage+Screenshot.h
//  DLabel
//
//  Created by mingxing on 2018/7/25.
//  Copyright © 2018年 mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Screenshot)

/**
 对某个View截图

 @param view 需要截图的View
 @return 生成的image
 */
+ (UIImage *)getImageViewWithView:(UIView *)view;

+ (UIImage *)getImageViewWithView:(UIView *)view andNewSize:(CGSize)newSize;
/**
 对某个image旋转

 @param image 旋转image
 @param orientation 怎样旋转
 @return 新的图片
 */
+(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;

- (UIImage *)aspectImageWithSize:(CGSize)size;

+ (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image;

+ (UIImage*) imageToTransparent:(UIImage*) image;
@end
