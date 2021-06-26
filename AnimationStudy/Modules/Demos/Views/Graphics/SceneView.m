//
//  SceneView.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import "SceneView.h"

@implementation SceneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(self.paperView == nil) {
        
            
            self.paperView = [[PaperView alloc]initWithFrame:CGRectMake(16, TOP_HEIGHT, 320, 240)];
            self.backgroundColor = UIColor.redColor;
            
            [self addSubview:self.paperView];
        }
        
        self.backgroundColor = UIColor.randomColor;
        
        
    }
    
    return self;
}


@end
