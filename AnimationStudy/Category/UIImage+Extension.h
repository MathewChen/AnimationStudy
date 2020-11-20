


#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//创建不被渲染的image
+(UIImage *)originalImageNamed:(NSString *)name;

//自定义颜色的image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//自定义颜色的image 1*1 size的大小
+ (UIImage *)imageWithColor:(UIColor *)color;

//主色调
-(UIColor*)mostColor;

//截图
+(UIImage *)captureScreenForView:(UIView *)currentView;

- (UIImage *)imageChangeColor:(UIColor *)color;
@end
