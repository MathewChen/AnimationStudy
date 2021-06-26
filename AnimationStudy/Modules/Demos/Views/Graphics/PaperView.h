//
//  PaperView.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseItem.h"
#import "FontItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaperView : UIView

@property(nonatomic, assign) CGFloat totalScale;

@property (nonatomic, copy) NSMutableArray<BaseItem *> *viewList;

@property (nonatomic, copy) NSMutableArray<BaseItem *> *selectedItemArray;//选中的数组

/// 添加图元
- (BaseItem *)addItem;

/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state;

/// item移动
/// @param state 旋转方式
- (void)itemMove:(RotateState)state;

/// item文字对齐方式
/// @param aliment 对齐方式
- (void)itemTextAliment:(NSInteger)aliment;

/// item字体大小
/// @param state 旋转方式
- (void)itemFontChange:(NSInteger)state;
@end

NS_ASSUME_NONNULL_END
