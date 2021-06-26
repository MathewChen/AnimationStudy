//
//  ClothCanvasViewGenerator.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "ClothCanvasViewGenerator.h"
#import "ClothCanvasView.h"
@implementation ClothCanvasViewGenerator

- (CanvasView *)canvasViewWithFrame:(CGRect)aFrame {
    return [[ClothCanvasView alloc] initWithFrame:aFrame];
}
@end
