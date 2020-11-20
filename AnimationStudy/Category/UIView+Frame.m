//
//  UIView+Frame.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)sh_x
{
    return self.frame.origin.x;
}

- (void)setSh_x:(CGFloat)sh_x
{
    CGRect frame = self.frame;
    frame.origin.x = sh_x;
    self.frame = frame;
}

- (CGFloat)sh_y
{
    return self.frame.origin.y;
}

- (void)setSh_y:(CGFloat)sh_y
{
    CGRect frame = self.frame;
    frame.origin.y = sh_y;
    self.frame = frame;
}

#pragma mark - Shortcuts for the coords

- (CGFloat)sh_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSh_right:(CGFloat)sh_right
{
    CGRect frame = self.frame;
    frame.origin.x = sh_right - self.sh_width;
    self.frame = frame;
}

- (CGFloat)sh_bottom
{
    return self.sh_y + self.sh_height;
}

- (void)setSh_bottom:(CGFloat)sh_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = sh_bottom - self.sh_height;
    self.frame = frame;
}


- (CGFloat)sh_width
{
    return self.frame.size.width;
}
- (void)setSh_width:(CGFloat)sh_width
{
    CGRect frame = self.frame;
    frame.size.width = sh_width;
    self.frame = frame;
}

- (CGFloat)sh_height
{
    return self.frame.size.height;
}

- (void)setSh_height:(CGFloat)sh_height
{
    CGRect frame = self.frame;
    frame.size.height = sh_height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties
- (CGPoint)sh_origin {
    return self.frame.origin;
}

- (void)setSh_origin:(CGPoint)sh_origin {
    CGRect frame = self.frame;
    frame.origin = sh_origin;
    self.frame = frame;
}

- (CGSize)sh_size {
    return self.frame.size;
}

- (void)setSh_size:(CGSize)sh_size {
    CGRect frame = self.frame;
    frame.size = sh_size;
    self.frame = frame;
}

#pragma mark - Shortcuts for positions
- (CGFloat)sh_centerX {
    return self.center.x;
}

- (void)setSh_centerX:(CGFloat)sh_centerX {
    self.center = CGPointMake(sh_centerX, self.sh_centerY);
}

- (CGFloat)sh_centerY {
    return self.center.y;
}

- (void)setSh_centerY:(CGFloat)sh_centerY {
    self.center = CGPointMake(self.sh_centerX, sh_centerY);
}




+(CGRect)centerFrame{
    return CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT  - TOP_HEIGHT - BOTTOM_HEIGHT);
}



+(CGRect)bottomFrame{
    return CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT  - TOP_HEIGHT - SAFE_BOTTOM);
}
@end
