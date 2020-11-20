//
//  NSArray+Extension.m
//  
//  Created by 唐伟明 on 2018/8/22.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)
-(NSArray *)compareWithBlock:(id (^)(id obj, NSUInteger idx))compareBlock{
    NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (compareBlock) {
            id num =  compareBlock(obj,idx);
            if (num) {
                [marr addObject:num];
            }
        }
    }];
    return marr.copy;
}
@end
