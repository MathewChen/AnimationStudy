//
//  AipGeneralVC.h
//  OCRLib
//
//  Created by Yan,Xiangda on 2017/2/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "MXCommonViewController.h"

@interface AipGeneralVC : MXCommonViewController


@property (nonatomic, copy) void (^handler)(UIImage *);


@end
