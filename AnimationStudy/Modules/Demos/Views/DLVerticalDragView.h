//
//  DLVerticalDragView.h
//  AnimationStudy
//
//  Created by mingxing on 2020/9/30.
//  Copyright © 2020 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLVerticalDragView : UIView

/// 拖拽控件名称
@property(nonatomic, copy) NSString *dragViewTitle;

/// 拖拽控件描述
@property(nonatomic, copy) NSString *dragViewDesStr;

@property (nonatomic, strong) UIView *bottomOperateView;

//最小的Y值
@property (nonatomic, assign, readwrite) CGFloat minY;
//中间的Y值
@property (nonatomic, assign, readwrite) CGFloat midY;
//最大的Y值
@property (nonatomic, assign, readwrite) CGFloat maxY;

- (void)buildUI;

- (void)levelTypeDidChange:(CGFloat)bottomOperateViewHeight;
@end
