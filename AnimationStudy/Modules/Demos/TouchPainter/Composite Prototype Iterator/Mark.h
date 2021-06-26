//
//  Mark.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Mark <NSObject>

@property(nonatomic, strong) UIColor *color;

@property(nonatomic, assign) CGFloat size;

@property(nonatomic, assign) CGPoint location;

/// 子节点的个数
@property(nonatomic, assign) NSUInteger count;

@property(nonatomic, strong) id<Mark> lastChild;

- (id) copy;

- (void) addMark:(id <Mark>) mark;

- (void) removeMark:(id <Mark>) mark;

- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

@end

