//
//  CanvasViewController.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/12.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXCommonViewController.h"

#import "CanvasView.h"
#import "CanvasViewGenerator.h"

@interface CanvasViewController : MXCommonViewController

@property(nonatomic, strong) CanvasView *canvasView;

- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator;
@end


