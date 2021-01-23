//
//  MXYYTextTestVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/1/22.
//  Copyright © 2021 dudian. All rights reserved.
//

#import "MXYYTextTestVC.h"

//#import <YYKit/YYLabel.h>
@interface MXYYTextTestVC ()

@property(nonatomic, strong) YYLabel *yyLabel;

@end

@implementation MXYYTextTestVC

- (void)didInitialize {
    [super didInitialize];
}

- (void)initSubviews {
    [super initSubviews];
    
    self.yyLabel = [[YYLabel alloc] init];
    [self.yyLabel sizeToFit];
    self.yyLabel.font = UIFontMake(18);
    self.yyLabel.textColor = UIColor.qd_tintColor;
    self.yyLabel.backgroundColor = UIColor.qmui_randomColor;
    self.yyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.yyLabel];
    
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
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.yyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view).offset(32);
        make.right.mas_equalTo(self.view).offset(-32);
        make.height.mas_equalTo(40);
    }];
}


@end
