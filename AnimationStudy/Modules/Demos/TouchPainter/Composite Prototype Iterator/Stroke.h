//
//  Stroke.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
//轻抚
@interface Stroke : NSObject<Mark, NSCopying> {
@private
    
    UIColor *color_;
    CGFloat size_;
    NSMutableArray *children_;
    
}

@property(nonatomic, strong) UIColor *color;
@property(nonatomic, assign) CGFloat size;
@property(nonatomic, assign) CGPoint location;
@property(nonatomic, assign) NSUInteger count;
@property(nonatomic, strong) id<Mark> lastChild;

- (void) addMark:(id <Mark>) mark;

- (void) removeMark:(id <Mark>) mark;

- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

- (id)copyWithZone:(NSZone *)zone;

@end


