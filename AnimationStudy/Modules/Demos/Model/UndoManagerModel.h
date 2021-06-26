//
//  UndoManagerModel.h
//  DLabel
//
//  Created by mingxing on 2018/10/9.
//  Copyright © 2018年 mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UndoFrame,
    UndoContent,
    UndoAngle,
    UndoFont,
    UndoCopy,
    UndoLineWidth,
    UndoLineLength
} UndoType;
@interface UndoManagerModel : NSObject

@property (nonatomic, assign) UndoType undoType;

@property (nonatomic, copy) NSString *labelContent;//label内容。

@property  (nonatomic, assign) CGRect undoRect;//理论上所有的移动都可以通过该属性收集，但现在有的还没有用。
/// 线条移动的撤销恢复
@property (nonatomic,assign) CGPoint undoPosition;
/// 线条长度
@property (nonatomic,assign) CGFloat lineLength;

@property (nonatomic, assign)int angle;//旋转角度

@property (nonatomic, assign)NSTextAlignment textAlign;//字体布局

@property (nonatomic, assign)NSInteger currentSegIndex;//文本对齐

@property (nonatomic, assign)CGFloat hsize;//字间距

@property (nonatomic, assign)CGFloat vsize;//行间距

@property (nonatomic, assign)int labelFontSize;//字体大小

@property (nonatomic, assign)BOOL isBold;//粗体

@property (nonatomic, assign)BOOL isItalic;//斜体

@property (nonatomic, assign)BOOL isUnderLine;//下划线

@property (nonatomic, assign)BOOL isDeleteLine;//删除线

@property (nonatomic, assign)BOOL isBlack;//黑体

@property (nonatomic, assign) int lineType;//线条类型

@property (nonatomic, assign) CGFloat lineWidth;//线条宽度

@property (nonatomic, assign) int graphicsType;//框类型（直角、圆角、椭圆）

@property (nonatomic, assign) BOOL isPattern;//是否填充

@property (nonatomic, assign) CGFloat radius;//圆角半径

@property (nonatomic, assign) BOOL isFlat;//是否平铺

@property (nonatomic, assign) int fontPosition;//文字位置

//@property (nonatomic, assign) ZXBarcodeFormat barcodeformat;//码制

@property (nonatomic, assign)int datasource;//数据源0：固定数据 1：数据库 2：序列号 3：日期 4：时间

@property (nonatomic, assign) int interval;//间隔

@property (nonatomic, copy) NSString *fontfamily;

@property (nonatomic, assign) NSInteger brightness;//亮度

@property (nonatomic, assign) NSInteger contrast;//对比度

@property (nonatomic, assign) NSInteger saturation;//饱和度

@property (nonatomic, assign) NSInteger threshold;//阀值

@property (nonatomic, assign) int imageType;


@end
