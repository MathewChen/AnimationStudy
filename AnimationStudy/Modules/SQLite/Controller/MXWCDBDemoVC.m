//
//  MXWCDBDemoVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/11.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXWCDBDemoVC.h"

#import "DLPurchasingModel.h"
@interface MXWCDBDemoVC ()

@property(nonatomic, strong) QMUITextField *textFieldA;

@property(nonatomic, strong) QMUITextField *textFieldB;

@end

@implementation MXWCDBDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.qmui_randomColor;
    
    QMUIButton *tableButton = [[QMUIButton alloc] init];
    [self.view addSubview:tableButton];
    tableButton.backgroundColor = UIColor.qmui_randomColor;
    [tableButton setTitle:@"创建表" forState:UIControlStateNormal];
    [tableButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [tableButton addTarget:self action:@selector(clickTableButton) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *addButton = [[QMUIButton alloc] init];
    [self.view addSubview:addButton];
    addButton.backgroundColor = UIColor.qmui_randomColor;
    [addButton setTitle:@"添加一条信息" forState:UIControlStateNormal];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [addButton addTarget:self action:@selector(clickAddMessage) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *removeButton = [[QMUIButton alloc] init];
    [self.view addSubview:removeButton];
    removeButton.backgroundColor = UIColor.qmui_randomColor;
    [removeButton setTitle:@"删除一条信息" forState:UIControlStateNormal];
    [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [removeButton addTarget:self action:@selector(clickRemoveMessage) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *getButton = [[QMUIButton alloc] init];
    [self.view addSubview:getButton];
    getButton.backgroundColor = UIColor.qmui_randomColor;
    [getButton setTitle:@"获取表信息" forState:UIControlStateNormal];
    [getButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(removeButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [getButton addTarget:self action:@selector(clickGetMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleA = [[UILabel alloc] init];
    titleA.text = @"接收信息";
    titleA.textColor = UIColor.blackColor;
    titleA.font = FUNC_FONT(15);
    [self.view addSubview:titleA];
    [titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.right.equalTo(@-32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    QMUITextField *textFieldA = [[QMUITextField alloc] init];
    textFieldA.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:textFieldA];
    [textFieldA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleA.mas_bottom).offset(8);
        make.right.equalTo(@-32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    self.textFieldA = textFieldA;
    
    UILabel *titleB = [[UILabel alloc] init];
    titleB.text = @"UID";
    titleB.textColor = UIColor.blackColor;
    titleB.font = FUNC_FONT(15);
    [self.view addSubview:titleB];
    [titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textFieldA.mas_bottom).offset(8);
        make.right.equalTo(@-32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    QMUITextField *textFieldB = [[QMUITextField alloc] init];
    textFieldB.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:textFieldB];
    [textFieldB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleB.mas_bottom).offset(8);
        make.right.equalTo(@-32);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    self.textFieldB = textFieldB;
}

- (void)clickTableButton {
    [DLPurchasingModel createTable];
}

- (void)clickAddMessage {
    /*
     @property(nonatomic, copy) NSString *receiptData;

     @property(nonatomic, copy) NSString *transactionId;

     @property(nonatomic, copy) NSString *productIdentifier;

     @property(nonatomic, copy) NSString *productPrice;

     @property(nonatomic, copy) NSString *productQuantity;

     @property(nonatomic, copy) NSString *userId;
     */
    DLPurchasingModel *model = [[DLPurchasingModel alloc] init];
    model.receiptData = self.textFieldA.text;
    model.transactionId = @"transactionId";
    model.productIdentifier = @"productIdentifier";
    model.productPrice = @"productPrice";
    model.productQuantity = @"productQuantity";
    model.userId = self.textFieldB.text;
    
    if ([self.textFieldA.text isEqual:@""] || self.textFieldA.text == nil) {
        [QMUITips showError:@"textFieldA无内容" inView:self.view hideAfterDelay:1.0];
        return;
    }
    if ([self.textFieldB.text isEqual:@""] || self.textFieldB.text == nil) {
        [QMUITips showError:@"textFieldB无内容" inView:self.view hideAfterDelay:1.0];
        return;
    }
    
    if ([model insertPurchasingModel]) {
        [QMUITips showSucceed:@"插入成功" inView:self.view hideAfterDelay:1.0];
    }else {
        [QMUITips showError:@"插入失败" inView:self.view hideAfterDelay:1.0];
    }
}

- (void)clickRemoveMessage {
    DLPurchasingModel *model = [[DLPurchasingModel alloc] init];
    model.receiptData = self.textFieldA.text;
    model.transactionId = @"transactionId";
    model.productIdentifier = @"";
    model.productPrice = @"";
    model.productQuantity = @"";
    model.userId = self.textFieldB.text;
    
    if ([self.textFieldA.text isEqual:@""] || self.textFieldA.text == nil) {
        [QMUITips showError:@"textFieldA无内容" inView:self.view hideAfterDelay:1.0];
        return;
    }
    if ([self.textFieldB.text isEqual:@""] || self.textFieldB.text == nil) {
        [QMUITips showError:@"textFieldB无内容" inView:self.view hideAfterDelay:1.0];
        return;
    }
    
    if ([model deletePurchasingModel:model]) {
        [QMUITips showSucceed:@"删除成功" inView:self.view hideAfterDelay:1.0];
    }else {
        [QMUITips showError:@"删除失败" inView:self.view hideAfterDelay:1.0];
    }
}

- (void)clickGetMessage {
    NSArray <DLPurchasingModel *>*array = [DLPurchasingModel purchasingModel];
    
    NSLog(@"array %zd",array.count);
}
@end
