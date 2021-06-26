//
//  FontItem.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import "FontItem.h"

@interface FontItem ()

@property(nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *postScript;

@end

@implementation FontItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildFontItemUI:(CGRect)frame];
    }
    return self;
}

/// 构造方法
- (void)buildFontItemUI:(CGRect)frame {
    
    self.prefixValue = @"";
    self.suffixValue = @"";
    self.value = @"我就是测试sdfsdfk";
    self.isBold = YES;
    self.isItalic = YES;
    self.isUnderLine = YES;
    self.isBlack = NO;
    
    self.hsize = 0;
    self.vsize = 0;
    self.labelFontSize = 16;
    self.currentSegIndex = 0;
    
    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.text = @"我就是测试sdfsdfk";
    self.label.textColor = [UIColor colorWithHexString:@"#125236"];
    self.label.font = FUNC_FONT(16);
    [self addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByCharWrapping;
}

- (void)baseItemPan {
    [super baseItemPan];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
}

- (void)leftHandlePan {
    [super leftHandlePan];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    
    if (self.bounds.size.height != self.label.bounds.size.height || self.bounds.size.width != self.label.bounds.size.width) {
        CGRect frame = self.bounds;
        frame.size.height = self.label.bounds.size.height;
//        frame.size.width = self.label.frame.size.width;
        self.bounds = frame;
    }
    NSLog(@"label.width = %f,label.height = %f",self.label.frame.size.width,self.label.frame.size.height);
    NSLog(@"self.width = %f,self.height = %f",self.frame.size.width,self.frame.size.height);
}

- (void)setCurrentSegIndex:(NSInteger)currentSegIndex {
    _currentSegIndex = currentSegIndex;
    
    self.label.textAlignment = currentSegIndex;
}


/// 属性设置
- (void)adjustmentLabelAttribute {
    
    NSString *labelValue = @"";
    if (self.datasource == 2) {
        labelValue = [NSString stringWithFormat:@"%@%@%@",self.prefixValue,self.value,self.suffixValue];
    }else {
        labelValue = self.value;
    }
    
    if (self.currentSegIndex == 3) {
        labelValue = [labelValue stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:labelValue];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:self.vsize];
    [paragraphStyle setAlignment:self.currentSegIndex];

    if (self.currentSegIndex == 3) {
        self.label.numberOfLines = 1;
        //计算文字宽度
        CGFloat wordsWidth = [labelValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.labelFontSize]} context:nil].size.width;
        
        ///计算文字间距
        NSUInteger textMargin = 0;
        //适配item宽度
//        if ([FitPCFrameUtil fontItemWidthCompareWordsWidth:wordsWidth ItemRect:self.frame Angle:self.angle]) {
//            self.frame = [FitPCFrameUtil justifiedAlimentWordsWidth:wordsWidth Rect:self.frame Angle:self.angle];
//        }else {
//            textMargin = (self.bounds.size.width - wordsWidth) / (labelValue.length - 1);
//        }
        textMargin = (self.bounds.size.width - wordsWidth) / (labelValue.length - 1);
        
        [attributeString addAttribute:NSKernAttributeName value:@(textMargin) range:NSMakeRange(0, labelValue.length)];
        NSLog(@"文字宽度------%f------%f--%d",wordsWidth,self.bounds.size.width,self.labelFontSize);
    }else {
        self.label.numberOfLines = 0;
        [attributeString addAttribute:NSKernAttributeName value:@(self.hsize) range:NSMakeRange(0, labelValue.length)];
    }
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelValue.length)];

    if (_isBold) {//粗体
        [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:_labelFontSize] range:NSMakeRange(0, labelValue.length)];
    }else {
        @try {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:self.postScript size:_labelFontSize] range:NSMakeRange(0, labelValue.length)];
        } @catch (NSException *exception) {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_labelFontSize] range:NSMakeRange(0, labelValue.length)];
        }
    }

    if (_isUnderLine) {//下划线
        [attributeString addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(0, labelValue.length)];
    }

    if (_isDeleteLine) {//删除线
        [attributeString addAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor blackColor]} range:NSMakeRange(0, labelValue.length)];
    }

    if (_isItalic) {//斜体
        [attributeString addAttribute:NSObliquenessAttributeName value:@(0.5) range:NSMakeRange(0, labelValue.length)];
    }

    if (_isBlack) {//黑底白字
        _label.backgroundColor = UIColor.blackColor;
        _label.textColor = UIColor.whiteColor;
    } else {
        _label.backgroundColor = UIColor.clearColor;
        _label.textColor = UIColor.blackColor;
    }

    [attributeString addAttribute:NSBackgroundColorAttributeName value:UIColor.clearColor range:NSMakeRange(0, labelValue.length)];
    _label.attributedText = attributeString;
    
}

- (void)setLabelFontSize:(int)labelFontSize {
    _labelFontSize = labelFontSize;
    
    [self adjustmentLabelAttribute];
    
    //这里，就需要通过计算了。如果直接用label去赋值。label还没有计算出来。
    
//    CGRect frame = self.bounds;
//    frame.size.height = self.label.bounds.size.height;
//    self.bounds = frame;
}
@end
