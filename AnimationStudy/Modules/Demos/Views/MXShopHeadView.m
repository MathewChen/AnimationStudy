//
//  MXShopHeadView.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/9.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXShopHeadView.h"

@interface MXShopHeadView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect imageViewFrame;

@end

@implementation MXShopHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei.jpg"]];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        
        self.imageViewFrame = self.imageView.frame;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 30, 200, 30)];
        label.font = [UIFont systemFontOfSize:20];
        label.text = @"Monkey·D·路飞";
        label.textColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}


@end
