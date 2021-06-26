//
//  TTLGraffitiView.h
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 Star. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BSBGraffitiView : UIView

@property (nonatomic, copy) void(^graffitiImageBlock)(UIImage *graffitiImage);

@end

