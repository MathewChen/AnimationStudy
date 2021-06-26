//
//  DLPurchasingModel.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/11.
//  Copyright © 2020 Star. All rights reserved.
//

#import "DLPurchasingModel.h"
#import "DLPurchasingModel+WCTTableCoding.h"

@implementation DLPurchasingModel

WCDB_IMPLEMENTATION(DLPurchasingModel)

//验签信息
WCDB_SYNTHESIZE(DLPurchasingModel, receiptData)

WCDB_SYNTHESIZE(DLPurchasingModel, transactionId)

WCDB_SYNTHESIZE(DLPurchasingModel, productIdentifier)

WCDB_SYNTHESIZE(DLPurchasingModel, productPrice)

WCDB_SYNTHESIZE(DLPurchasingModel, productQuantity)

WCDB_SYNTHESIZE(DLPurchasingModel, userId)


/// 获取内购验签表
+ (NSArray<DLPurchasingModel *> *)purchasingModel {
    
    WCTDatabase *database = [self database];

    NSArray<DLPurchasingModel *> *purchasingArray = [database getAllObjectsOfClass:DLPurchasingModel.class fromTable:kWC_TABLE_WCDB_NAME];
    
    return purchasingArray;
}

/// 插入一条验签数据
- (BOOL)insertPurchasingModel {
    
    BOOL result = NO;
    
    WCTDatabase *database = [DLPurchasingModel database];
    
    if ([database canOpen]) {
        result = [database insertObject:self into:kWC_TABLE_WCDB_NAME];
    }
    
    
    return result;
}

/// 删除一条验签数据
/// @param purchasing 验签数据
- (BOOL)deletePurchasingModel:(DLPurchasingModel *)purchasing {
    
    BOOL result = NO;
    
    WCTDatabase *database = [DLPurchasingModel database];
    
    if ([database canOpen]) {
        
        WCTCondition where = {DLPurchasingModel.userId == purchasing.userId};
        
        result = [database deleteObjectsFromTable:kWC_TABLE_WCDB_NAME where:where];
    }
    
    
    return result;
}

+ (BOOL)createTable {
    NSString *path = [self purchasingReceiptDataPath];
    
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    if (![database isTableExists:kWC_TABLE_WCDB_NAME]) {
        BOOL result = [database createTableAndIndexesOfName:kWC_TABLE_WCDB_NAME withClass:self.class];
        
        if (!result) {
            NSLog(@"创建数据库失败");
        }
        return result;
    }
    return YES;
}

+ (WCTDatabase *)database {
    
    NSString *path = [self purchasingReceiptDataPath];
    WCTDatabase *newDatabase = [[WCTDatabase alloc] initWithPath:path];
    return newDatabase;
}

+ (NSString *)purchasingReceiptDataPath {
    
    NSString *path = [NSString stringWithFormat:@"%@/ReceiptData/",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Creat Faild: %@", path);
        }
    }
    return [path stringByAppendingString:@"Store.sqlite"];
}
@end
