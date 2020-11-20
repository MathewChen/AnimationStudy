//
//  UIButton+SendCaptcha.m
//  Cloud
//
//  Created by paykee on 2017/5/8.
//  Copyright © 2017年 冀明达. All rights reserved.
//

#import "UIButton+SendCaptcha.h"

@implementation UIButton (SendCaptcha)

- (void)startTime:(NSInteger)time{
    __block int timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
//                [self setBackgroundColor:[UIColor whiteColor]];
                self.enabled = YES;
            });
        } else {
            NSString *strTime = [NSString stringWithFormat:@"%d%@", timeout,NSLocalizedString(@"秒后重试", nil)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:strTime forState:UIControlStateNormal];
//                [self setBackgroundColor:[UIColor whiteColor]];
                self.enabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
