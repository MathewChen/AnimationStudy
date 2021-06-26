//
//  CompressionTest.h
//  AnimationStudy
//
//  Created by mingxing on 2021/6/10.
//  Copyright © 2021 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompressionTest : NSObject

+ (NSData *)compress: (NSData *)data;

+ (NSData *)decompress: (NSData *)data;

@end

NS_ASSUME_NONNULL_END
