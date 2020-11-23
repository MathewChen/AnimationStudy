//
//  MXQuartzCoreMineVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/5/25.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXQuartzCoreMainVC.h"
#import "MXTuyaVC.h"
#import "MXIconVC.h"
#import "MXPrinterStatuVC.h"
#import "MXCacheTestVC.h"
#import "MXVisualEffectVC.h"
@interface MXQuartzCoreMainVC ()

@end

@implementation MXQuartzCoreMainVC

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"QMUIButton", UIImageMake(@"icon_tabbar_uikit_selected"),
                       @"涂鸦功能", UIImageMake(@"icon_tabbar_uikit"),
                       @"打印机状态", UIImageMake(@"icon_grid_alert"),
                       @"YYCache", UIImageMake(@"edit_icon_brush"),@"视觉效果", UIImageMake(@"edit_icon_empty"),
                       nil];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"QuartzCore";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_nav_about") target:self action:@selector(handleAboutItemEvent)];
    AddAccessibilityLabel(self.navigationItem.rightBarButtonItem, @"打开关于界面");
}

- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"涂鸦功能"]) {
        viewController = [[MXTuyaVC alloc] init];
    }else if ([title isEqualToString:@"QMUIButton"]) {
        viewController = [[MXIconVC alloc] init];
    }else if ([title isEqualToString:@"打印机状态"]) {
        viewController = [[MXPrinterStatuVC alloc] init];
    }else if ([title isEqualToString:@"YYCache"]) {
        viewController = [[MXCacheTestVC alloc] init];
    }else if ([title isEqualToString:@"视觉效果"]) {
        viewController = [[MXVisualEffectVC alloc] init];
    }

    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)handleAboutItemEvent {
//    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

@end
