//
//  MXRuntimeTest.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/23.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXRuntimeTest.h"
#import <objc/runtime.h>
#import "Student.h"

@implementation MXRuntimeTest

- (void)other {
    NSLog(@"%s", __func__);
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(test)) {
//        //获取 other 方法信息
//        Method method = class_getInstanceMethod(self, @selector(other));
//        //动态天机 test 方法的实现
//        class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
//        // 返回 yes 代表有动态添加方法
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//    
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(test)) {
//        // objc_msgSend([[Student alloc] init], aSelector);
//        return [[Student alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 方法签名：返回值类型、参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        
        NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
        NSLog(@"%zd",signature.numberOfArguments);
        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// NSInvocation 封装了一个方法调用，包括：方法调用者、方法名、方法参数
// 方法调用者：anInvocation.target
// 方法名：anInvocation.selector
// 方法参数：[anInvocation getArgument:NULL atIndex:0];
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 等同与 [anInvocation invokeWithTarget:[[Student alloc] init]];
    
    [anInvocation invokeWithTarget:[[Student alloc] init]];


}

@end
