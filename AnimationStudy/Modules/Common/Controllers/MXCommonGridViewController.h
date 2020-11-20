//
//  MXCommonGridViewController.h
//  AnimationStudy
//
//  Created by mingxing on 2020/6/9.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXCommonViewController.h"

@interface MXCommonGridViewController : MXCommonViewController

@property(nonatomic, strong) QMUIOrderedDictionary<NSString *, UIImage *> *dataSource;
@property(nonatomic, strong, readonly) UIScrollView *scrollView;
@property(nonatomic, strong, readonly) QMUIGridView *gridView;

@end

@interface MXCommonGridViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;
@end

