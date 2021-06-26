//
//  Stroke.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "Stroke.h"


@implementation Stroke

@synthesize color = color_, size = size_;

- (instancetype)init {
    if (self = [super init]) {
        children_ = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return self;
}

- (void)setLocation:(CGPoint)location {
    
}

- (CGPoint)location {
#warning 这里目前有问题
    //返回第一个子节点的位置。(这里目前有问题)
    if ([children_ count] > 0) {
//        CGPoint point = CGPointZero;
//        Mark mark = [children_ objectAtIndex:0];
//        CGPoint point = [children_ objectAtIndex:0];
//        return mark.;
    }
    
    //否则返回第一个子节点的位置。
    return CGPointZero;
}

- (void)addMark:(id<Mark>)mark {
    [children_ addObject:mark];
}

- (void)removeMark:(id<Mark>)mark {
    // 如果mark在这一层，讲起移除并返回
    // 否则，让每个子节点去找它
    if ([children_ containsObject:mark]) {
        [children_ removeObject:mark];
    }else {
        [children_ makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }
}

- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    if (index >= children_.count) {
        return nil;
    }
    
    return [children_ objectAtIndex:index];
}

///返回最后子节点的便利方法
- (id<Mark>)lastChild {
    return [children_ lastObject];
}

///返回子节点数
- (NSUInteger)count {
    return [children_ count];
}

//- (void)dealloc {
//    [color_ release];
//    [children_ release];
//    [super dealloc];
//}

#pragma mark - NSCopying method

- (id)copyWithZone:(NSZone *)zone {
    Stroke *strokeCopy = [[[self class] allocWithZone:zone] init];
    
    // 复制color
    [strokeCopy setColor:[UIColor colorWithCGColor:[color_ CGColor]]];
    
    // 复制size
    [strokeCopy setSize:size_];
    
    // 复制children
    for (id <Mark> child in children_) {
        id <Mark> childCopy = [child copy];
        [strokeCopy addMark:childCopy];
    }
    
    return strokeCopy;
}
@end
