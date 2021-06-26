//
//  Vertex.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (id)initWithLocation:(CGPoint)location {
    if (self = [super init]) {
        [self setLocation:location];
    }
    
    return self;
}

#pragma mark - 默认属性什么也不做
- (void)setColor:(UIColor *)color {
    
}

- (UIColor *)color {
    return nil;
}

- (void)setSize:(CGFloat)size {
    
}

- (CGFloat)size {
    return 0.0;
}

#pragma mark - Mark操作什么也不做
- (void)addMark:(id<Mark>)mark {
    
}

- (void)removeMark:(id<Mark>)mark {
    
}

- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    return nil;
}

- (NSUInteger)count {
    return 0;
}

- (NSEnumerator *)enumerator {
    return nil;
}

#pragma mark - NSCopying method

// 此方法需要实现，以支持备忘录
- (id)copyWithZone:(NSZone *)zone {
    
    /*
     在重载的copyWithZone:方法中，使用[[self class] allocWithZone :zone]生成新的Vertex实例，并用当前位置进行初始化。使用[self class]是因为我们希望其子类也能够 复用这个复制方法。要是直接用[vertex alloc], 其子类就只会返回Vertex而不是它的实际类型的副本。Vertex只实现了location属性，因此新副本用当前位置进行了初始化之后，就返回vertexCopy。
     */
    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:location_];
    
    return vertexCopy;
}
@end
