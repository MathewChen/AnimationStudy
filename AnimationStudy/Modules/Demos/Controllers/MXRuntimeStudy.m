//
//  MXRuntimeStudy.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/21.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXRuntimeStudy.h"
#import "MXRuntimeTest.h"
@interface MXRuntimeStudy ()

@end

@implementation MXRuntimeStudy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MXRuntimeTest *runtimeTest = [[MXRuntimeTest alloc] init];
    [runtimeTest test]; 
}


@end
