
#import <UIKit/UIKit.h>

@interface UIImageView (Factory)
+ (UIImageView *)imageViewFrame:(CGRect)frame WithImageName:(NSString *)imageName;
+ (UIImageView *)imageViewWithImageName:(NSString *)imageName;
@end
