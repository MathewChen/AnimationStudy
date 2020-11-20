//
//  PrinterStatusView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/21.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "PrinterStatusView.h"
#import <SDWebImage/UIImage+GIF.h>
@interface PrinterStatusView ()

@property (nonatomic, strong) UIView *printerStatusView;

@property (nonatomic, strong) UIImageView *printerStatusImageView;

@property (nonatomic, strong) UILabel *printerStatusLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger countdown;
@end


@implementation PrinterStatusView

- (instancetype)initWithFrame:(CGRect)frame PrinterStatusType:(PrinterStatusType)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIPrinterStatusType:type];
    }
    return self;
}

- (void)setupUIPrinterStatusType:(PrinterStatusType)type {
    
    //不同状态显示
    NSString *statusGifPathStr = @"";
    NSString *statusStr = @"";
    if (type == PrinterStatusTypeNoPaper) {
        statusGifPathStr = @"noPaperAnimation.gif";
        statusStr = @"设备纸仓缺纸了，请检查下吧";
    }else {
        statusGifPathStr = @"openCoverAnimation.gif";
        statusStr = @"设备上盖开启了，请检查下吧";
    }
    
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    
    self.printerStatusView = [[UIView alloc] initWithFrame:CGRectMake(FUNC_W(58), FUNC_H(229), FUNC_W(260), FUNC_W(180))];
    self.printerStatusView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.printerStatusView];
    [self.printerStatusView addCornerRadius:4.f];
    
    //Gif
    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:statusGifPathStr ofType:nil];
    NSData *imagedata = [NSData dataWithContentsOfFile:filepath];
    self.printerStatusImageView = [[UIImageView alloc] init];
    self.printerStatusImageView.sh_y = 0;
    self.printerStatusImageView.sh_size = CGSizeMake(FUNC_W(136), FUNC_W(136));
    self.printerStatusImageView.sh_x = (self.printerStatusView.sh_width - self.printerStatusImageView.sh_width) / 2;
    self.printerStatusImageView.image= [UIImage sd_animatedGIFWithData:imagedata];
    [self.printerStatusView addSubview:self.printerStatusImageView];
    
    //提示语
    self.printerStatusLabel = [[UILabel alloc] init];
    self.printerStatusLabel.frame = CGRectMake(0, self.printerStatusImageView.sh_bottom, self.printerStatusView.sh_width, 20);
    self.printerStatusLabel.font = FUNC_FONT(14);
    self.printerStatusLabel.textColor = [UIColor colorWithHexString:@"3C3C3C"];
    self.printerStatusLabel.text = statusStr;
    self.printerStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self.printerStatusView addSubview:self.printerStatusLabel];
    
    self.countdown = 4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.countdown -= 1;
        if (self.countdown == 0) {
            [self printerStatusViewDismiss];
        }
    }];
    [self.timer fire];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self printerStatusViewDismiss];
}

/// 收起界面
- (void)printerStatusViewDismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.timer invalidate];
        self.timer = nil;
        [self removeFromSuperview];
    }];
}
@end
