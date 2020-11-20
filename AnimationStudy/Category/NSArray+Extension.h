//
//  NSArray+Extension.h
//  
//
//  Created by 唐伟明 on 2018/8/22.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
-(NSArray *)compareWithBlock:(id (^)(id obj, NSUInteger idx))compareBlock;
@end
