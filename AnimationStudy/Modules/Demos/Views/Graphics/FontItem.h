//
//  FontItem.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import "BaseItem.h"

@interface FontItem : BaseItem

@property (nonatomic, assign) NSTextAlignment textAlign;//对齐方式

@property (nonatomic, assign) NSInteger currentSegIndex;//文本对齐（可以实现）

@property (nonatomic, assign) BOOL isBold;//粗体
@property (nonatomic, assign) BOOL isItalic;//斜体
@property (nonatomic, assign) BOOL isUnderLine;//下划线
@property (nonatomic, assign) BOOL isDeleteLine;//删除线
@property (nonatomic, assign) BOOL isBlack;//黑体

@property (nonatomic, assign)CGFloat hsize;//字间距
@property (nonatomic, assign)CGFloat vsize;//行间距
@property (nonatomic, assign)int labelFontSize;//字体大小

@property (nonatomic, copy) NSString *fontfamily;//默认字体
@property (nonatomic, copy)NSString *value;//文本内容
@property (nonatomic, copy)NSString *prefixValue;//前缀
@property (nonatomic, copy)NSString *suffixValue;//后缀

@property (nonatomic, assign) int interval;//间隔
@end

