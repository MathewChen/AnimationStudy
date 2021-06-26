//
//  DLPurchasingModel+WCTTableCoding.h
//  AnimationStudy
//
//  Created by mingxing on 2020/12/11.
//  Copyright © 2020 Star. All rights reserved.
//

#import "DLPurchasingModel.h"
#import <WCDB/WCDB.h>

@interface DLPurchasingModel ()<WCTTableCoding>

WCDB_PROPERTY(receiptData)

WCDB_PROPERTY(transactionId)

WCDB_PROPERTY(productIdentifier)

WCDB_PROPERTY(productPrice)

WCDB_PROPERTY(productQuantity)

WCDB_PROPERTY(userId)

@end

