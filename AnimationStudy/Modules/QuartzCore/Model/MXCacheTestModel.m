//
//  MXCacheTestModel.m
//  AnimationStudy
//
//  Created by mingxing on 2020/8/11.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXCacheTestModel.h"

@implementation MXCacheTestModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.testImage forKey:@"testImage"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.des forKey:@"des"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeInteger:self.changeTime forKey:@"changeTime"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.testImage = [aDecoder decodeObjectForKey:@"testImage"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.des = [aDecoder decodeObjectForKey:@"des"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.changeTime = [aDecoder decodeIntegerForKey:@"changeTime"];
    return self;
}

@end
