//
//  DLPurchasingModel.h
//  AnimationStudy
//
//  Created by mingxing on 2020/12/11.
//  Copyright © 2020 dudian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWC_TABLE_WCDB_NAME @"WC_TABLE_WCDB_NAME_Dynamic"

@interface DLPurchasingModel : NSObject

@property(nonatomic, copy) NSString *receiptData;//验签字符串

@property(nonatomic, copy) NSString *transactionId;//App Store服务器唯一标识符

@property(nonatomic, copy) NSString *productIdentifier;//DLVIP000001

@property(nonatomic, copy) NSString *productPrice;//产品价格

@property(nonatomic, copy) NSString *productQuantity;//产品数量

@property(nonatomic, copy) NSString *userId;//用户ID?????

/// 创建表
+ (BOOL)createTable;

/// 获取内购验签表
+ (NSArray<DLPurchasingModel *> *)purchasingModel;

///// 插入一条验签数据
///// @param purchasing 验签数据
//- (BOOL)insertPurchasingModel:(DLPurchasingModel *)purchasing;
- (BOOL)insertPurchasingModel;

/// 删除一条验签数据
/// @param purchasing 验签数据
- (BOOL)deletePurchasingModel:(DLPurchasingModel *)purchasing;

@end

