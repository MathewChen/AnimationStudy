

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat sh_x;
@property (nonatomic, assign) CGFloat sh_y;

@property (nonatomic) CGFloat sh_centerX;
@property (nonatomic) CGFloat sh_centerY;

@property (nonatomic) CGFloat sh_bottom;
@property (nonatomic) CGFloat sh_right;


@property (nonatomic) CGFloat sh_width;
@property (nonatomic) CGFloat sh_height;

@property (nonatomic, assign) CGPoint sh_origin;
@property (nonatomic, assign) CGSize sh_size;



+(CGRect)centerFrame;



+(CGRect)bottomFrame;
@end
