//
//  XMDemoListVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/9/29.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "XMDemoListVC.h"
#import "XMDragVC.h"
#import "MXCellMoveVC.h"
#import "MXCalenderVC.h"

@interface XMDemoListVC ()

@end

@implementation XMDemoListVC

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"上下拖拽View", UIImageMake(@"icon_tabbar_uikit_selected"),@"cell移动", UIImageMake(@"icon_grid_theme"),
                       @"日历界面", UIImageMake(@"edit_icon_brush"),
                       nil];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"Demo";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_nav_about") target:self action:@selector(handleAboutItemEvent)];
    AddAccessibilityLabel(self.navigationItem.rightBarButtonItem, @"打开关于界面");
}

- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"上下拖拽View"]) {
        viewController = [[XMDragVC alloc] init];
    } else if([title isEqualToString:@"cell移动"]) {
        viewController = [[MXCellMoveVC alloc] init];
    } else if([title isEqualToString:@"日历界面"]) {
        viewController = [[MXCalenderVC alloc] init];
    }

    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)handleAboutItemEvent {
//    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

@end
