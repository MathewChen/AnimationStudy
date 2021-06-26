//
//  SimpleView.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/6.
//  Copyright © 2021 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SimpleViewDelegate <NSObject>

- (void)sipmleViewFrameWillChange:(CGRect)frame;

- (void)sipmleViewFrameChanging:(CGRect)frame;

- (void)sipmleViewFrameChanged:(CGRect)frame;

@end

@interface SimpleView : UIView

typedef NS_ENUM(NSInteger, RotateState) {
    RotateStateTop = 0,
    RotateStateRight,
    RotateStateBottom,
    RotateStateLeft
};

/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state;

@property(nonatomic, weak) id<SimpleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
