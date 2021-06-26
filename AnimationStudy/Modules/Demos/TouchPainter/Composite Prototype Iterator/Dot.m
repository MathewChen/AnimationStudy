//
//  Dot.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "Dot.h"

@implementation Dot

@synthesize size = size_, color = color_;
//- (void)dealloc {
//    [color_ release];
//    [super dealloc];
//}

#pragma mark - NSCopying deletgate Method
- (id)copyWithZone:(NSZone *)zone {
    Dot *dotCopy = [[[self class] allocWithZone:zone] initWithLocation:location_];
    
    // 赋值color
    [dotCopy setColor:[UIColor colorWithCGColor:[color_ CGColor]]];
    
    // 复制size
    [dotCopy setSize:size_];
    
    return dotCopy;
}

@end
