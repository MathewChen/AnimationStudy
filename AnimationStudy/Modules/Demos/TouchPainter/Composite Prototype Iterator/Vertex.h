//
//  Vertex.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

//顶点
@interface Vertex : NSObject<Mark> {
@protected
    CGPoint location_;
}

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) id <Mark> lastChild;

- (id) initWithLocation:(CGPoint) location;
- (void) addMark:(id <Mark>) mark;
- (void) removeMark:(id <Mark>) mark;
- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

// for the Prototype pattern
- (id) copyWithZone:(NSZone *)zone;
@end


