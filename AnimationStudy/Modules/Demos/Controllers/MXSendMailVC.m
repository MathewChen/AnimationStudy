//
//  MXSendMailVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/14.
//  Copyright © 2020 Star. All rights reserved.
//  绑定邮箱必须是开启 IMAP/SMTP服务 的邮箱
//  然后用授权码作为密码来登录

#import "MXSendMailVC.h"
#import <MessageUI/MessageUI.h>
@interface MXSendMailVC ()<MFMailComposeViewControllerDelegate>

@end

@implementation MXSendMailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QMUIButton *tableButton = [[QMUIButton alloc] init];
    [self.view addSubview:tableButton];
    tableButton.backgroundColor = UIColor.qmui_randomColor;
    [tableButton setTitle:@"发送邮箱" forState:UIControlStateNormal];
    [tableButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [tableButton addTarget:self action:@selector(sendMail) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendMail {
    //先验证邮箱能否发邮件，不然会崩溃
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未配置邮箱账户，是否现在跳转邮箱配置？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:@"mailto://"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    //收件人邮箱，使用NSArray指定多个收件人
//    NSArray *toRecipients = [NSArray arrayWithObject:@"734763636@qq.com"];
    NSArray *toRecipients = [NSArray arrayWithObject:@"matthewchenqaq@163.com"];
    [picker setToRecipients:toRecipients];
    //抄送人邮箱，使用NSArray指定多个抄送人
    NSArray *ccRecipients = [NSArray arrayWithObject:@"734763636@qq.com"];
    [picker setCcRecipients:ccRecipients];
//    //密送人邮箱，使用NSArray指定多个密送人
//    NSArray *bccRecipients = [NSArray arrayWithObject:@"888888888@qq.com"];
//    [picker setToRecipients:bccRecipients];
    //邮件主题
    [picker setSubject:@"年兽邮件主题"];
    //邮件正文，如果正文是html格式则isHTML为yes，否则为no
    
    [picker setMessageBody:@"23入34邮件正文" isHTML:NO];
    //添加附件，附件将附加到邮件的结尾
//    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"icon.jpg"], 1.0);
//    [picker addAttachmentData:data mimeType:@"image/jpeg" fileName:@"new.png"];
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}
 
//代理
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    NSLog(@"send mail error:%@", error);
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"邮件发送取消");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"邮件保存成功");
            break;
        case MFMailComposeResultSent:
            NSLog(@"邮件发送成功");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"邮件发送失败");
            break;
        default:
            NSLog(@"邮件未发送");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
