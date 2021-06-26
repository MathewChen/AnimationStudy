//
//  Dot.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "Vertex.h"

//点
@interface Dot : Vertex {
    @private
    UIColor *color_;
    CGFloat size_;
}

@property(nonatomic, strong) UIColor *color;

@property(nonatomic, assign) CGFloat size;

- (id)copyWithZone:(NSZone *)zone;
@end


