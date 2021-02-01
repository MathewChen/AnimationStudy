//
//  MXYYTextTestVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/1/22.
//  Copyright © 2021 dudian. All rights reserved.
//

#import "MXYYTextTestVC.h"
#import <CoreML/CoreML.h>
//#import <YYKit/YYLabel.h>
@interface MXYYTextTestVC ()

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) YYLabel *yyLabel;

@property(nonatomic, strong) YYLabel *yyLabelTuwen;

@property(nonatomic, strong) YYLabel *linePositionModifierLabel;

@end

@implementation MXYYTextTestVC

- (void)didInitialize {
    [super didInitialize];
}

- (void)initSubviews {
    [super initSubviews];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = UIColor.qmui_randomColor;
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    
    //1、高亮点击
    [self yyLabelHighlightClick];
    
    //图文混排
    [self yyLabelImageTextLayout];
    
    // YYText文本行位置调整
    [self yyLabelLinePositionModifier];
    
    //字体效果
    [self yyLabelAttrituted];
}

/// yylabel高亮点击
- (void)yyLabelHighlightClick {
    self.yyLabel = [[YYLabel alloc] init];
    [self.yyLabel sizeToFit];
    self.yyLabel.font = UIFontMake(18);
    self.yyLabel.textColor = UIColor.qd_tintColor;
    self.yyLabel.backgroundColor = UIColor.qmui_randomColor;
    self.yyLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.yyLabel];
    
    NSString *serverStr = @"《隐私协议》";
    NSString *andStr = @" 和 ";
    NSString *privacyStr = @"《服务协议》";
    NSRange serverRange = NSMakeRange(0, serverStr.length);
    NSRange privacyRange = NSMakeRange(serverStr.length + andStr.length, privacyStr.length);
    NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",serverStr,andStr,privacyStr]];
    //为文本设置属性
    labelString.font = [UIFont boldSystemFontOfSize:16];
    labelString.color = UIColor.qd_tintColor;
    labelString.lineSpacing = 10;
    labelString.alignment = NSTextAlignmentCenter;
    
    
    [labelString setTextHighlightRange:serverRange
                            color:[UIColor blueColor]
                  backgroundColor:[UIColor grayColor]
                        tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                            NSLog(@"tap text range:...");
                        }];
    
    [labelString setTextHighlightRange:privacyRange
                            color:[UIColor yellowColor]
                  backgroundColor:[UIColor grayColor]
                        tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                            NSLog(@"tap text privacyRange:...");
                        }];
    
    self.yyLabel.attributedText = labelString;
    
    self.yyLabel.frame = CGRectMake(32, self.scrollView.qmui_top + 32, SCREEN_WIDTH - 32 * 2, 40);
}

///图文混排
- (void)yyLabelImageTextLayout {
    
    self.yyLabelTuwen = [[YYLabel alloc] init];
    [self.yyLabelTuwen sizeToFit];
    self.yyLabelTuwen.font = UIFontMake(18);
    self.yyLabelTuwen.textColor = UIColor.qd_tintColor;
    self.yyLabelTuwen.backgroundColor = UIColor.qmui_randomColor;
    self.yyLabelTuwen.textAlignment = NSTextAlignmentCenter;
    self.yyLabelTuwen.numberOfLines = 0;
    [self.scrollView addSubview:self.yyLabelTuwen];
    
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:@"明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间。"];
    textStr.font = UIFontMake(16);
    UIImage *image = UIImageMake(@"icon_list");
    NSMutableAttributedString *attachment = nil;
    attachment = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:UIFontMake(16) alignment:YYTextVerticalAlignmentCenter];
    // 嵌入 UIImage
    [textStr appendAttributedString:attachment];
    
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc] initWithString:@"转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。"];
    text1.font = UIFontMake(16);
    [textStr appendAttributedString: text1];
    
    // 嵌入 UIImage
    UIImage *image1 = [UIImage imageNamed:@"icon_YYLabel"];
    NSMutableAttributedString *attachment1 = nil;
    attachment1 = [NSMutableAttributedString attachmentStringWithContent:image1 contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:UIFontMake(16) alignment:YYTextVerticalAlignmentCenter];
    [textStr appendAttributedString: attachment1];
    
    self.yyLabelTuwen.attributedText = textStr;
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - 32 * 2, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:textStr];
    NSLog(@"---%@",NSStringFromCGSize(layout.textBoundingSize));
    
    self.yyLabelTuwen.frame = CGRectMake(32, self.yyLabel.qmui_bottom + 32, 360, 197);
}

/// YYText文本行位置调整
- (void)yyLabelLinePositionModifier {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"旧时月色,算几番照我,梅边吹笛?唤起玉人,不管清寒与攀摘.何逊而今渐老,都忘却,春风词笔.women我们！！！！！！!!!!!!!!,梅边吹笛?唤起玉人,AAAQIWBNMwdpnumberOfLinesnumberOfLinesbiaoqian☆★♀♂ O(∩_∩)O~ (=@__@=) (*^__^*) %>_<% └(^o^)┘; ^ˇ^≡ ‘(*>﹏<*)′ ~(@^_^@)~ (*+﹏+*)~ (^_^)∠※.这都是什么字什么字什么字";
    label.numberOfLines = 0;
    label.frame = CGRectMake(0.0, self.yyLabelTuwen.qmui_bottom, self.view.bounds.size.width, 250.0);
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    [self.scrollView addSubview:label];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString: @"旧时月色,算几番照我,梅边吹笛?唤起玉人,不管清寒与攀摘.何逊而今渐老,都忘却,春风词笔.women我们！！！！！！!!!!!!!!,梅边吹笛?唤起玉人,AAAQIWBNMwdpnumberOfLinesnumberOfLinesbiaoqian☆★♀♂ O(∩_∩)O~ (=@__@=) (*^__^*) %>_<% └(^o^)┘; ^ˇ^≡ ‘(*>﹏<*)′ ~(@^_^@)~ (*+﹏+*)~ (^_^)∠※.这都是什么字什么字什么字"];
    attrStr.color= [UIColor blueColor];
    attrStr.font = [UIFont boldSystemFontOfSize:20.0];
    
    YYTextLinePositionSimpleModifier *modifier = [[YYTextLinePositionSimpleModifier alloc] init];
    modifier.fixedLineHeight = 30;
    
    YYLabel *linePositionModifierLabel = [[YYLabel alloc] init];
    linePositionModifierLabel.numberOfLines = 0;
    linePositionModifierLabel.frame = CGRectMake(0.0, label.qmui_bottom, self.view.bounds.size.width, 300.0);
    linePositionModifierLabel.linePositionModifier = modifier;
    linePositionModifierLabel.attributedText = attrStr;
    [self.scrollView addSubview:linePositionModifierLabel];
    self.linePositionModifierLabel = linePositionModifierLabel;
    
    CGSize size = CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attrStr];
    NSLog(@"label2---%@",NSStringFromCGSize(layout.textBoundingSize));
}

- (void)yyLabelAttrituted {
    __weak typeof(self) _self = self;
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    //阴影
    NSMutableAttributedString *shadow = [[NSMutableAttributedString alloc] initWithString:@"阴影"];
    shadow.font = UIFontBoldMake(30);
    shadow.color = UIColorWhite;
    YYTextShadow *shadowTextShadow = [YYTextShadow new];
    shadowTextShadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
    shadowTextShadow.offset = CGSizeMake(0, 1);
    shadowTextShadow.radius = 5;
    shadow.textShadow = shadowTextShadow;
    [text appendAttributedString:shadow];
    [text appendAttributedString:[self padding]];
    
    
    //内部阴影
    NSMutableAttributedString *innerShadow = [[NSMutableAttributedString alloc] initWithString:@"内部阴影"];
    innerShadow.font = UIFontBoldMake(30);
    innerShadow.color = UIColorWhite;
    YYTextShadow *innerShadowTextShadow = [YYTextShadow new];
    innerShadowTextShadow.color = [UIColor colorWithWhite:0.000 alpha:0.40];
    innerShadowTextShadow.offset = CGSizeMake(0, 1);
    innerShadowTextShadow.radius = 1;
    innerShadow.textInnerShadow = innerShadowTextShadow;
    [text appendAttributedString:innerShadow];
    [text appendAttributedString:[self padding]];
    
    //多阴影组合
    NSMutableAttributedString *mulShadow = [[NSMutableAttributedString alloc] initWithString:@"多阴影组合"];
    mulShadow.font = UIFontBoldMake(30);
    mulShadow.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
    
    YYTextShadow *mulOutShadow = [YYTextShadow new];
    //阴影颜色
    mulOutShadow.color = UIColorRed;
    //阴影分布
    mulOutShadow.offset = CGSizeMake(0, -1);
    mulOutShadow.radius = 1.5;

    //给上面的阴影多加阴影。（上面是文字上方是红色阴影，下方是蓝色阴影）
    YYTextShadow *mulSubShadow = [YYTextShadow new];
    mulSubShadow.color = UIColorBlue;
    mulSubShadow.offset = CGSizeMake(0, 1);
    mulSubShadow.radius = 1.5;;
    
    YYTextShadow *mulInnerShadow = [YYTextShadow new];
    mulInnerShadow.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
    mulInnerShadow.offset = CGSizeMake(0, 1);
    mulInnerShadow.radius = 1;
    
    mulOutShadow.subShadow = mulSubShadow;
    mulShadow.textShadow = mulOutShadow;
    mulShadow.textInnerShadow = mulInnerShadow;
    
    [text appendAttributedString:mulShadow];
    [text appendAttributedString:[self padding]];
    
    //图片背景
    NSMutableAttributedString *imageStr = [[NSMutableAttributedString alloc] initWithString:@"图片背景"];
    imageStr.font = UIFontBoldMake(30);
    imageStr.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
    
    CGSize size = CGSizeMake(20, 20);
    UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        UIColor *c0 = [UIColor colorWithRed:0.054 green:0.879 blue:0.000 alpha:1.000];
        UIColor *c1 = [UIColor colorWithRed:0.869 green:1.000 blue:0.030 alpha:1.000];
        [c0 setFill];
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        [c1 setStroke];
        CGContextSetLineWidth(context, 2);
        for (int i = 0; i < size.width * 2; i+= 4) {
            CGContextMoveToPoint(context, i, -2);
            CGContextAddLineToPoint(context, i - size.height, size.height + 2);
        }
        CGContextStrokePath(context);
    }];

    imageStr.color = [UIColor colorWithPatternImage:background];
    
    [text appendAttributedString:imageStr];
    [text appendAttributedString:[self padding]];

    NSMutableAttributedString *borderStr = [[NSMutableAttributedString alloc] initWithString:@"Border"];
    borderStr.font = UIFontBoldMake(30);
    borderStr.color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
    
    YYTextBorder *borderStrBorder = [YYTextBorder new];
    borderStrBorder.strokeColor = [UIColor redColor];
    borderStrBorder.strokeWidth = 3;
    borderStrBorder.lineStyle = YYTextLineStylePatternCircleDot;
    borderStrBorder.cornerRadius = 3;
    borderStrBorder.insets = UIEdgeInsetsMake(0, -4, 0, -4);
    borderStr.textBackgroundBorder = borderStrBorder;
    
    [text appendAttributedString:[self padding]];
    [text appendAttributedString:borderStr];
    [text appendAttributedString:[self padding]];
    [text appendAttributedString:[self padding]];
    [text appendAttributedString:[self padding]];
    [text appendAttributedString:[self padding]];
    
    //文字5
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        border.strokeWidth = 3;
        border.lineStyle = YYTextLineStylePatternCircleDot;
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        one.textBackgroundBorder = border;
        
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
    }
    
    //文字6
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.underlineStyle = NSUnderlineStyleSingle;
        
        /// 1. you can set a highlight with these code
        /*
         one.color = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
         
         YYTextBorder *border = [YYTextBorder new];
         border.cornerRadius = 3;
         border.insets = UIEdgeInsetsMake(-2, -1, -2, -1);
         border.fillColor = [UIColor colorWithWhite:0.000 alpha:0.220];
         
         YYTextHighlight *highlight = [YYTextHighlight new];
         [highlight setBorder:border];
         highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
         [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
         };
         [one setTextHighlight:highlight range:one.rangeOfAll];
         */
        
        /// 2. or you can use the convenience method
        [one setTextHighlightRange:one.rangeOfAll
                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        }];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    
    //文字7
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor redColor];
        
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 50;
        border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        border.strokeWidth = 0.5;
        border.strokeColor = one.color;
        border.lineStyle = YYTextLineStyleSingle;
        one.textBackgroundBorder = border;
        
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = one.color;
        highlightBorder.fillColor = one.color;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[self padding]];
    }
    
    //文字8
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor whiteColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [text appendAttributedString:one];
    }
    
    
    YYLabel *label = [YYLabel new];
    label.attributedText = text;
    label.width = self.view.width;
    label.height = 400;
    label.top = self.linePositionModifierLabel.qmui_bottom + 32;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.scrollView addSubview:label];
    
    /*
     If the 'highlight.tapAction' is not nil, the label will invoke 'highlight.tapAction'
     and ignore 'label.highlightTapAction'.
     
     If the 'highlight.tapAction' is nil, you can use 'highlightTapAction' to handle
     all tap action in this label.
     */
    label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
    };
}

#pragma mark - Object Private Function

- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}

- (void)showMessage:(NSString *)msg {
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    label.width = self.view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
    
    label.bottom = (kiOS7Later ? 150 : 0);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = (kiOS7Later ? 150 : 0);
    }
                     completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.bottom = (kiOS7Later ? 150 : 0);
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}


@end
