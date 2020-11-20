//
//  UIImage+Screenshot.m
//  DLabel
//
//  Created by mingxing on 2018/7/25.
//  Copyright © 2018年 mingxing. All rights reserved.
//

#import "UIImage+Screenshot.h"

@implementation UIImage (Screenshot)

+ (UIImage *)getImageViewWithView:(UIView *)view {
    //宽高减去一个像素是为了解决生成黑框的问题。
    CGSize size = CGSizeMake(view.bounds.size.width - 1.f, view.bounds.size.height - 1.f);
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getImageViewWithView:(UIView *)view andNewSize:(CGSize)newSize {
//    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(newSize, NO, view.bounds.size.width/newSize.width);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    
    
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate =M_PI_2;
            
            rect =CGRectMake(0,0,image.size.height, image.size.width);
            
            translateX=0;
            
            translateY= -rect.size.width;
            
            scaleY =rect.size.width/rect.size.height;
            
            scaleX =rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate =3 *M_PI_2;
            
            rect =CGRectMake(0,0,image.size.height, image.size.width);
            
            translateX= -rect.size.height;
            
            translateY=0;
            
            scaleY =rect.size.width/rect.size.height;
            
            scaleX =rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate =M_PI;
            
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            
            translateX= -rect.size.width;
            
            translateY= -rect.size.height;
            
            break;
            
        default:
            
            rotate =0.0;
            
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            
            translateX=0;
            
            translateY=0;
            
            break;
            
    }

    UIGraphicsBeginImageContextWithOptions(rect.size, NO,[UIScreen mainScreen].scale);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //做CTM变换
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX,translateY);
    
    CGContextScaleCTM(context, scaleX,scaleY);
    
    //绘制图片
    
    CGContextDrawImage(context, CGRectMake(0,0,rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic =UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
    
}

+ (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width == 0 || height == 0){
        return image;
    }
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)aspectImageWithSize:(CGSize)size{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGSize aspectFitSize = CGSizeZero;
    if (self.size.width != 0 && self.size.height != 0) {
        CGFloat rateW = size.width / self.size.width;
        CGFloat rateH = size.height / self.size.height;
        CGFloat rate = MIN(rateW, rateH);
        aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
    }
    [self drawInRect:CGRectMake(0.f, 0.f, aspectFitSize.width, aspectFitSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image

{

UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);

CGContextRef ctx = UIGraphicsGetCurrentContext();

CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);

CGContextScaleCTM(ctx, 1, -1);

CGContextTranslateCTM(ctx, 0, -area.size.height);

CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

CGContextSetAlpha(ctx, alpha);

CGContextDrawImage(ctx, area, image.CGImage);

UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

UIGraphicsEndImageContext();

return newImage;

}

+ (UIImage*) imageToTransparent:(UIImage*) image

{
    
    // 分配内存
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
        
    {
        
        if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00) {
            
            // 此处把白色背景颜色给变为透明
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[0] = 0;
            
        }else{
            
            // 改成下面的代码，会将图片转成想要的颜色
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[3] = 0; //0~255
            
            ptr[2] = 0;
            
            ptr[1] = 0;
            
        }
        
    }
    
    // 将内存转成image
    
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderRelease);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true,kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
    
}

void ProviderRelease (void *info, const void *data, size_t size)

{

free((void*)data);

}


@end
