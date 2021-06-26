//
//  UndoManagerHelper.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/9.
//  Copyright © 2021 Star. All rights reserved.
//

#import "UndoManagerHelper.h"

#import "FontItem.h"

@interface UndoManagerHelper()

@property (nonatomic, strong) UndoManagerModel *undoManagerModel;

@end

@implementation UndoManagerHelper

- (void)itemBeforAction:(BaseItem*)baseItem {
    self.undoManagerModel = [baseItem.rectArray lastObject];
    switch (self.undoManagerModel.undoType) {
        case UndoFrame:
            [self itemBeforMove:baseItem];
            break;
        case UndoContent:
            [self itemBeforContent:baseItem];
            break;
        case UndoAngle:
            [self itemBeforAngle:baseItem];
            break;
        case UndoFont:
            [self itemBeforFont:baseItem];
            break;
        case UndoLineWidth:
            [self itemBeforLineWidth:baseItem];
            break;
        case UndoLineLength:
            [self itemBeforLineLength:baseItem];
            break;
        default:
            break;
    }
}

- (void)itemAction:(BaseItem*)baseItem UndoType:(UndoType)undoType {
    switch (undoType) {
        case UndoFrame:
            [self itemMove:baseItem];
            break;
        case UndoContent:
            [self itemContent:baseItem];
            break;
        case UndoAngle:
            [self itemAngle:baseItem];
            break;
        case UndoFont:
            [self itemFont:baseItem];
            break;
        case UndoLineWidth:
            [self itemLineWidth:baseItem];
            break;
        case UndoLineLength:
            [self itemLineLength:baseItem];
            break;
        default:
            break;
    }
}

- (void)itemAfterAction:(BaseItem*)baseItem {
    self.undoManagerModel = [baseItem.rectUndoArray lastObject];
    
    switch (self.undoManagerModel.undoType) {
        case UndoFrame:
            [self itemAfterMove:baseItem];
            break;
        case UndoContent:
            [self itemAfterContent:baseItem];
            break;
        case UndoAngle:
            [self itemAfterAngle:baseItem];
            break;
        case UndoFont:
            [self itemAfterFont:baseItem];
            break;
        case UndoLineWidth:
            [self itemAfterLineWidth:baseItem];
            break;
        case UndoLineLength:
            [self itemAfterLineLength:baseItem];
            break;
        default:
            break;
    }
}

#pragma mark - 移动撤销恢复

- (void)itemBeforMove:(BaseItem*)baseItem {

    CGRect undoRect = self.undoManagerModel.undoRect;
    self.undoManagerModel = nil;
    self.undoManagerModel.undoRect = baseItem.frame;
    self.undoManagerModel.undoType = UndoFrame;
    [baseItem.rectUndoArray addObject:self.undoManagerModel];
    baseItem.frame = undoRect;
    [baseItem setNeedsDisplay];
    [baseItem.rectArray removeLastObject];

}

- (void)itemMove:(BaseItem *)baseItem {
    
    self.undoManagerModel = nil;
    self.undoManagerModel.undoRect = baseItem.moveRect;
    self.undoManagerModel.undoType = UndoFrame;
    NSLog(@"frame: x = %f y = %f width = %f height = %f。 moveRect: x = %f y = %f width = %f height = %f",baseItem.frame.origin.x,baseItem.frame.origin.x,baseItem.frame.size.width,baseItem.frame.size.height,baseItem.moveRect.origin.x,baseItem.moveRect.origin.y,baseItem.moveRect.size.width,baseItem.moveRect.size.height);
    [baseItem.rectArray addObject:self.undoManagerModel];
    self.undoManagerModel = nil;

}

- (void)itemAfterMove:(BaseItem*)baseItem {

    CGRect undoRect = self.undoManagerModel.undoRect;
    self.undoManagerModel = nil;
    self.undoManagerModel.undoRect = baseItem.frame;
    [baseItem.rectArray addObject:self.undoManagerModel];
    baseItem.frame = undoRect;
    [baseItem setNeedsDisplay];
    [baseItem.rectUndoArray removeLastObject];

}

#pragma mark - 内容撤销恢复

- (void)itemBeforContent:(BaseItem*)baseItem {
    
    NSString *labelContent = self.undoManagerModel.labelContent;
    self.undoManagerModel = nil;
    if ([baseItem isMemberOfClass:[FontItem class]]) {
        FontItem *fontItem = (FontItem*)baseItem;
        self.undoManagerModel.labelContent = fontItem.value;
        fontItem.value = labelContent;
    }
    
    self.undoManagerModel.undoType = UndoContent;
    [baseItem.rectUndoArray addObject:self.undoManagerModel];
    [baseItem setNeedsDisplay];
    [baseItem.rectArray removeLastObject];
}

- (void)itemContent:(BaseItem *)baseItem {
    self.undoManagerModel = nil;
    if ([baseItem isMemberOfClass:[FontItem class]]) {
        FontItem *fontItem = (FontItem*)baseItem;
        self.undoManagerModel.labelContent = fontItem.value;
    }
    self.undoManagerModel.undoType = UndoContent;
    [baseItem.rectArray addObject:self.undoManagerModel];
    self.undoManagerModel = nil;
}

- (void)itemAfterContent:(BaseItem*)baseItem {
    
    NSString *labelContent = self.undoManagerModel.labelContent;
    self.undoManagerModel = nil;
    if ([baseItem isMemberOfClass:[FontItem class]]) {
        FontItem *fontItem = (FontItem*)baseItem;
        self.undoManagerModel.labelContent = fontItem.value;
        fontItem.value = labelContent;
    }
    
    self.undoManagerModel.undoType = UndoContent;
    [baseItem.rectArray addObject:self.undoManagerModel];
    [baseItem setNeedsDisplay];
    [baseItem.rectUndoArray removeLastObject];
}

#pragma mark - 旋转角度撤销恢复

- (void)itemBeforAngle:(BaseItem*)baseItem {
    
    int angle = self.undoManagerModel.angle;
    self.undoManagerModel = nil;
    self.undoManagerModel.angle = baseItem.angle;
    self.undoManagerModel.undoType = UndoAngle;
    [baseItem.rectUndoArray addObject:self.undoManagerModel];
    baseItem.angle = angle;
    baseItem.transform = CGAffineTransformRotate(baseItem.transform, 270 * M_PI / 180);
    [baseItem setNeedsDisplay];
    [baseItem.rectArray removeLastObject];

}

- (void)itemAngle:(BaseItem *)baseItem {
    self.undoManagerModel = nil;
    self.undoManagerModel.angle = baseItem.angle;
    self.undoManagerModel.undoType = UndoAngle;
    [baseItem.rectArray addObject:self.undoManagerModel];
    self.undoManagerModel = nil;
}

- (void)itemAfterAngle:(BaseItem*)baseItem {
    
    int angle = self.undoManagerModel.angle;
    self.undoManagerModel = nil;
    self.undoManagerModel.angle = baseItem.angle;
    self.undoManagerModel.undoType = UndoAngle;
    [baseItem.rectArray addObject:self.undoManagerModel];
    baseItem.angle = angle;
    baseItem.transform = CGAffineTransformRotate(baseItem.transform, 90 * M_PI / 180);
    [baseItem setNeedsDisplay];
    [baseItem.rectUndoArray removeLastObject];
    
}
#pragma mark - 字体变化

- (void)itemBeforFont:(BaseItem*)baseItem {

    if ([baseItem isMemberOfClass:[FontItem class]]) {
        [self fontItemWithFont:baseItem];
    }
    
    [baseItem.rectUndoArray addObject:self.undoManagerModel];

    [baseItem setNeedsDisplay];
    [baseItem.rectArray removeLastObject];
}

- (void)itemFont:(BaseItem *)baseItem {
    self.undoManagerModel = nil;
    self.undoManagerModel.undoType = UndoFont;
    self.undoManagerModel.datasource = baseItem.datasource;
    if ([baseItem isMemberOfClass:[FontItem class]]) {
        FontItem *fontItem = (FontItem*)baseItem;
        self.undoManagerModel.textAlign = fontItem.textAlign;
        self.undoManagerModel.currentSegIndex = fontItem.currentSegIndex;
        self.undoManagerModel.hsize = fontItem.hsize;
        self.undoManagerModel.vsize = fontItem.vsize;
        self.undoManagerModel.labelFontSize = fontItem.labelFontSize;
        self.undoManagerModel.isBold = fontItem.isBold;
        self.undoManagerModel.isItalic = fontItem.isItalic;
        self.undoManagerModel.isUnderLine = fontItem.isUnderLine;
        self.undoManagerModel.isDeleteLine = fontItem.isDeleteLine;
        self.undoManagerModel.isBlack = fontItem.isBlack;
        self.undoManagerModel.fontfamily = fontItem.fontfamily;
    }
    
    [baseItem.rectArray addObject:self.undoManagerModel];
    self.undoManagerModel = nil;
}

- (void)itemAfterFont:(BaseItem*)baseItem {
    
    if ([baseItem isMemberOfClass:[FontItem class]]) {
        [self fontItemWithFont:baseItem];
    }
    UIButton *sdf;
    [baseItem.rectArray addObject:self.undoManagerModel];
    [baseItem setNeedsDisplay];
    [baseItem.rectUndoArray removeLastObject];
}
//文本
- (void)fontItemWithFont:(BaseItem *)baseItem {
    NSTextAlignment textAlign = self.undoManagerModel.textAlign;
    NSInteger currentSegIndex = self.undoManagerModel.currentSegIndex;
    CGFloat hsize = self.undoManagerModel.hsize;
    CGFloat vsize = self.undoManagerModel.vsize;
    int labelFontSize = self.undoManagerModel.labelFontSize;
    int datasource = self.undoManagerModel.datasource;
    int interval = self.undoManagerModel.interval;
    BOOL isBold = self.undoManagerModel.isBold;
    BOOL isItalic = self.undoManagerModel.isItalic;
    BOOL isUnderLine = self.undoManagerModel.isUnderLine;
    BOOL isDeleteLine = self.undoManagerModel.isDeleteLine;
    BOOL isBlack = self.undoManagerModel.isBlack;
    NSString *fontFamily = self.undoManagerModel.fontfamily;
    self.undoManagerModel = nil;
    self.undoManagerModel.undoType = UndoFont;
    
    FontItem *fontItem = (FontItem*)baseItem;
    self.undoManagerModel.textAlign = fontItem.textAlign;
    self.undoManagerModel.currentSegIndex = fontItem.currentSegIndex;
    self.undoManagerModel.hsize = fontItem.hsize;
    self.undoManagerModel.vsize = fontItem.vsize;
    self.undoManagerModel.labelFontSize = fontItem.labelFontSize;
    self.undoManagerModel.isBold = fontItem.isBold;
    self.undoManagerModel.isItalic = fontItem.isItalic;
    self.undoManagerModel.isUnderLine = fontItem.isUnderLine;
    self.undoManagerModel.isDeleteLine = fontItem.isDeleteLine;
    self.undoManagerModel.isBlack = fontItem.isBlack;
    self.undoManagerModel.datasource = fontItem.datasource;
    self.undoManagerModel.interval = fontItem.interval;
    self.undoManagerModel.fontfamily = fontItem.fontfamily;
    fontItem.textAlign = textAlign;
    fontItem.currentSegIndex = currentSegIndex;
    fontItem.hsize = hsize;
    fontItem.vsize = vsize;
    fontItem.labelFontSize = labelFontSize;
    fontItem.isBold = isBold;
    fontItem.isItalic = isItalic;
    fontItem.isUnderLine = isUnderLine;
    fontItem.isDeleteLine = isDeleteLine;
    fontItem.isBlack = isBlack;
    fontItem.datasource = datasource;
    fontItem.interval = interval;
    fontItem.fontfamily = fontFamily;
}
////时间
//- (void)timeItemWithFont:(BaseItem *)baseItem {
//    NSTextAlignment textAlign = self.undoManagerModel.textAlign;
//    int currentSegIndex = self.undoManagerModel.currentSegIndex;
//    CGFloat hsize = self.undoManagerModel.hsize;
//    CGFloat vsize = self.undoManagerModel.vsize;
//    int labelFontSize = self.undoManagerModel.labelFontSize;
//    BOOL isBold = self.undoManagerModel.isBold;
//    BOOL isItalic = self.undoManagerModel.isItalic;
//    BOOL isUnderLine = self.undoManagerModel.isUnderLine;
//    BOOL isDeleteLine = self.undoManagerModel.isDeleteLine;
//    BOOL isBlack = self.undoManagerModel.isBlack;
//    NSString *fontFamily = self.undoManagerModel.fontfamily;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//
//    TimeItem *timeItem = (TimeItem*)baseItem;
//    self.undoManagerModel.textAlign = timeItem.textAlign;
//    self.undoManagerModel.currentSegIndex = timeItem.currentSegIndex;
//    self.undoManagerModel.hsize = timeItem.hsize;
//    self.undoManagerModel.vsize = timeItem.vsize;
//    self.undoManagerModel.labelFontSize = timeItem.labelFontSize;
//    self.undoManagerModel.isBold = timeItem.isBold;
//    self.undoManagerModel.isItalic = timeItem.isItalic;
//    self.undoManagerModel.isUnderLine = timeItem.isUnderLine;
//    self.undoManagerModel.isDeleteLine = timeItem.isDeleteLine;
//    self.undoManagerModel.isBlack = timeItem.isBlack;
//    self.undoManagerModel.fontfamily = timeItem.fontfamily;
//    timeItem.textAlign = textAlign;
//    timeItem.currentSegIndex = currentSegIndex;
//    timeItem.hsize = hsize;
//    timeItem.vsize = vsize;
//    timeItem.labelFontSize = labelFontSize;
//    timeItem.isBold = isBold;
//    timeItem.isItalic = isItalic;
//    timeItem.isUnderLine = isUnderLine;
//    timeItem.isDeleteLine = isDeleteLine;
//    timeItem.isBlack = isBlack;
//    timeItem.fontfamily = fontFamily;
//}
////条形码
//- (void)barcodeItemWithFont:(BaseItem *)baseItem {
//    NSTextAlignment textAlign = self.undoManagerModel.textAlign;
//    int currentSegIndex = self.undoManagerModel.currentSegIndex;
//    int labelFontSize = self.undoManagerModel.labelFontSize;
//    int datasource = self.undoManagerModel.datasource;
//    int interval = self.undoManagerModel.interval;
//    BOOL isBold = self.undoManagerModel.isBold;
//    BOOL isItalic = self.undoManagerModel.isItalic;
//    BOOL isUnderLine = self.undoManagerModel.isUnderLine;
//    BOOL isDeleteLine = self.undoManagerModel.isDeleteLine;
//    int fontPosition = self.undoManagerModel.fontPosition;
//    NSString *fontFamily = self.undoManagerModel.fontfamily;
//    ZXBarcodeFormat barcodeformat = self.undoManagerModel.barcodeformat;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//
//    BarcodeItem *barcodeItem = (BarcodeItem*)baseItem;
//    self.undoManagerModel.textAlign = barcodeItem.textAlign;
//    self.undoManagerModel.currentSegIndex = barcodeItem.currentSegIndex;
//    self.undoManagerModel.labelFontSize = barcodeItem.labelFontSize;
//    self.undoManagerModel.isBold = barcodeItem.isBold;
//    self.undoManagerModel.isItalic = barcodeItem.isItalic;
//    self.undoManagerModel.isUnderLine = barcodeItem.isUnderLine;
//    self.undoManagerModel.isDeleteLine = barcodeItem.isDeleteLine;
//    self.undoManagerModel.fontPosition = barcodeItem.fontPosition;
//    self.undoManagerModel.barcodeformat = barcodeItem.barcodeformat;
//    self.undoManagerModel.datasource = barcodeItem.datasource;
//    self.undoManagerModel.interval = barcodeItem.interval;
//    self.undoManagerModel.fontfamily = barcodeItem.fontfamily;
//    barcodeItem.textAlign = textAlign;
//    barcodeItem.currentSegIndex = currentSegIndex;
//    barcodeItem.labelFontSize = labelFontSize;
//    barcodeItem.isBold = isBold;
//    barcodeItem.isItalic = isItalic;
//    barcodeItem.isUnderLine = isUnderLine;
//    barcodeItem.isDeleteLine = isDeleteLine;
//    barcodeItem.fontPosition = fontPosition;
//    barcodeItem.barcodeformat = barcodeformat;
//    barcodeItem.datasource = datasource;
//    barcodeItem.interval = interval;
//    barcodeItem.fontfamily = fontFamily;
//}
////二维码
//- (void)barcodeItem2DWithFont:(BaseItem *)baseItem {
//    ZXBarcodeFormat barcodeformat = self.undoManagerModel.barcodeformat;
//    int datasource = self.undoManagerModel.datasource;
//    int interval = self.undoManagerModel.interval;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//    Barcode2DItem *barcode2DItem = (Barcode2DItem*)baseItem;
//    self.undoManagerModel.barcodeformat = barcode2DItem.barcodeFormat;
//    self.undoManagerModel.datasource = barcode2DItem.datasource;
//    self.undoManagerModel.interval = barcode2DItem.interval;
//    barcode2DItem.barcodeFormat = barcodeformat;
//    barcode2DItem.datasource = datasource;
//    barcode2DItem.interval = interval;
//}
////线段
//- (void)lineItemWithFont:(BaseItem *)baseItem {
//    int lineType = self.undoManagerModel.lineType;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//    LineItem *lineItem = (LineItem*)baseItem;
//    self.undoManagerModel.lineType = lineItem.lineType;
//    lineItem.lineType = lineType;
//}
////矩形
//- (void)graphicsItem2DWithFont:(BaseItem *)baseItem {
//    int graphicsType = self.undoManagerModel.graphicsType;
//    BOOL isPattern = self.undoManagerModel.isPattern;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//    GraphicsItem *graphicsItem = (GraphicsItem *)baseItem;
//    self.undoManagerModel.graphicsType = graphicsItem.graphicsType;
//    self.undoManagerModel.isPattern = graphicsItem.isPattern;
//    graphicsItem.graphicsType = graphicsType;
//    graphicsItem.isPattern = isPattern;
//}
////图片
//- (void)imageItemWithFont:(BaseItem *)baseItem {
//    BOOL isFlat = self.undoManagerModel.isFlat;
//    NSInteger brightness = self.undoManagerModel.brightness;
//    NSInteger contrast = self.undoManagerModel.contrast;
//    NSInteger saturation = self.undoManagerModel.saturation;
//    NSInteger threshold = self.undoManagerModel.threshold;
//    int imageType = self.undoManagerModel.imageType;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//    ImageItem *imageItem = (ImageItem *)baseItem;
//    self.undoManagerModel.isFlat = imageItem.isFlat;
//    self.undoManagerModel.brightness = imageItem.brightness;
//    self.undoManagerModel.contrast = imageItem.contrast;
//    self.undoManagerModel.saturation = imageItem.saturation;
//    self.undoManagerModel.threshold = imageItem.threshold;
//    self.undoManagerModel.imageType = imageItem.imageType;
//    imageItem.isFlat = isFlat;
//    imageItem.brightness = brightness;
//    imageItem.contrast = contrast;
//    imageItem.saturation = saturation;
//    imageItem.threshold = threshold;
//    imageItem.imageType = imageType;
//}
//
////图标
//- (void)logoWithFont:(BaseItem *)baseItem {
//    BOOL isFlat = self.undoManagerModel.isFlat;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoFont;
//    LogoItem *logoItem = (LogoItem *)baseItem;
//    self.undoManagerModel.isFlat = logoItem.isFlat;
//    logoItem.isFlat = isFlat;
//}

#pragma mark - 线条宽度撤销恢复

- (void)itemBeforLineWidth:(BaseItem*)baseItem {
//    CGFloat lineWidth = self.undoManagerModel.lineWidth;
//    CGFloat radius = self.undoManagerModel.radius;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoLineWidth;
//    self.undoManagerModel.lineWidth = baseItem.lineWidth;
//    if ([baseItem isMemberOfClass:[GraphicsItem class]]) {
//        GraphicsItem *graphicsItem = (GraphicsItem *)baseItem;
//        self.undoManagerModel.radius = graphicsItem.radius;
//        graphicsItem.radius = radius;
//    }
//    baseItem.lineWidth = lineWidth;
//    [baseItem.rectUndoArray addObject:self.undoManagerModel];
//    [baseItem setNeedsDisplay];
//    [baseItem.rectArray removeLastObject];
}

- (void)itemLineWidth:(BaseItem *)baseItem {
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoLineWidth;
//    self.undoManagerModel.lineWidth = baseItem.lineWidth;
//    if ([baseItem isMemberOfClass:[GraphicsItem class]]) {
//        GraphicsItem *graphicsItem = (GraphicsItem *)baseItem;
//        self.undoManagerModel.radius = graphicsItem.radius;
//    }
//    [baseItem.rectArray addObject:self.undoManagerModel];
//    self.undoManagerModel = nil;
}

- (void)itemAfterLineWidth:(BaseItem *)baseItem {
//    CGFloat lineWidth = self.undoManagerModel.lineWidth;
//    CGFloat radius = self.undoManagerModel.radius;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.lineWidth = baseItem.lineWidth;
//    self.undoManagerModel.undoType = UndoLineWidth;
//    if ([baseItem isMemberOfClass:[GraphicsItem class]]) {
//        GraphicsItem *graphicsItem = (GraphicsItem *)baseItem;
//        self.undoManagerModel.radius = graphicsItem.radius;
//        graphicsItem.radius = radius;
//    }
//    baseItem.lineWidth = lineWidth;
//    [baseItem.rectArray addObject:self.undoManagerModel];
//    [baseItem setNeedsDisplay];
//    [baseItem.rectUndoArray removeLastObject];
}

#pragma mark  线段长度撤销恢复
- (void)itemBeforLineLength:(BaseItem*)baseItem{
//    CGFloat lineLength = self.undoManagerModel.lineLength;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoLineLength;
//    self.undoManagerModel.lineLength = lineLength;
//    CGRect bounds = baseItem.layer.bounds;
//    bounds.size.width = [baseItem realSize:lineLength];
//    baseItem.layer.bounds = bounds;
//    [baseItem.rectUndoArray addObject:self.undoManagerModel];
//    [baseItem setNeedsDisplay];
//    [baseItem.rectArray removeLastObject];
}

- (void)itemLineLength:(BaseItem *)baseItem{
    
//    self.undoManagerModel = nil;
//    self.undoManagerModel.undoType = UndoLineLength;
//    self.undoManagerModel.lineLength = [baseItem scaleSize:baseItem.layer.bounds.size.width];
//    [baseItem.rectArray addObject:self.undoManagerModel];
//    self.undoManagerModel = nil;
    
}

- (void)itemAfterLineLength:(BaseItem *)baseItem{
//    CGFloat lineLength = self.undoManagerModel.lineLength;
//    self.undoManagerModel = nil;
//    self.undoManagerModel.lineLength = [baseItem scaleSize:baseItem.layer.bounds.size.width];
//    self.undoManagerModel.undoType = UndoLineLength;
//    CGRect bounds = baseItem.layer.bounds;
//    bounds.size.width = [baseItem realSize:lineLength];
//    baseItem.layer.bounds = bounds;
//    [baseItem.rectArray addObject:self.undoManagerModel];
//    [baseItem setNeedsDisplay];
//    [baseItem.rectUndoArray removeLastObject];
    
}

#pragma mark - 初始化
- (UndoManagerModel *)undoManagerModel {
    if (!_undoManagerModel) {
        _undoManagerModel = [[UndoManagerModel alloc] init];
    }
    return _undoManagerModel;
}
@end
