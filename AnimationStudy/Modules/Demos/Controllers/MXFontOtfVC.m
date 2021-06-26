//
//  MXFontOtfVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/17.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXFontOtfVC.h"

@interface MXFontOtfVC ()

@end

@implementation MXFontOtfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleA = [[UILabel alloc] init];
    titleA.text = @"接收信息ABC";
    titleA.textColor = UIColor.blackColor;
    titleA.font = FUNC_FONT(20);
    [self.view addSubview:titleA];
    [titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    UILabel *titleB = [[UILabel alloc] init];
    titleB.text = @"接收信息ABC";
    titleB.textColor = UIColor.blackColor;
    titleB.font = [UIFont fontWithName:@"NotoSansCJKsc-Black" size:20];
    [self.view addSubview:titleB];
    [titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleA.mas_bottom);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
