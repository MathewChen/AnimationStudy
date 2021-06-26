//
//  MXCacheTestModel.h
//  AnimationStudy
//
//  Created by mingxing on 2020/8/11.
//  Copyright © 2020 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXCacheTestModel : NSObject<NSCoding>

@property(nonatomic, strong) UIImage *testImage;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *des;

@property(nonatomic, assign) NSInteger age;

@property(nonatomic, assign) NSInteger changeTime;

@end

NS_ASSUME_NONNULL_END
