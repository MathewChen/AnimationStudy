//
//  UITextField+Extension.m
//  
//
//  Created by 唐伟明 on 2018/1/26.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
-(void)placeholderTextColor:(UIColor *)color{
   [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];  
}


#pragma mark - 添加回收键盘的完成按钮

- (void)textFieldWithFinishButton
{
//    UIView *inputview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    inputview.layer.borderColor = [UIColor whiteColor].CGColor;
//    inputview.layer.borderWidth = 0.4;
//    inputview.backgroundColor = FUNC_COLOR_HEXSTRING(@"f2f2f2");
//
//    UIButton *buttonfinish = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    buttonfinish.frame = CGRectMake(SCREEN_WIDTH - 55, 5, 50, 30);
//    buttonfinish.backgroundColor = [UIColor clearColor];
//    [buttonfinish setTitle:@"完成" forState:(UIControlStateNormal)];
//    [buttonfinish addTarget:self action:@selector(finishEditting) forControlEvents:(UIControlEventTouchUpInside)];
//    [buttonfinish setTitleColor:[UIColor themeColor] forState:(UIControlStateNormal)];
//    buttonfinish.titleLabel.font = [UIFont systemFontOfSize:17];
//    [inputview addSubview:buttonfinish];
//    self.inputAccessoryView = inputview;
    
}
- (void)finishEditting
{
    [self endEditing:YES];
}
@end
