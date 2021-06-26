//
//  XMDemoListVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/9/29.
//  Copyright © 2020 Star. All rights reserved.
//

#import "XMDemoListVC.h"
#import "XMDragVC.h"
#import "MXCellMoveVC.h"
#import "MXCalenderVC.h"
#import "AipGeneralVC.h"
#import "MXSendMailVC.h"
#import "MXFontOtfVC.h"
#import "MXBarcodeDemoVC.h"
#import "MXYYTextTestVC.h"
#import "MXTableViewTestVC.h"
#import "MXPinchVC.h"
#import "MXPanVC.h"
#import "MXEditVC.h"
#import "CanvasViewController.h"
#import "MXInputVC.h"
#import "MXShopDetailVC.h"
#import "MXCompressVC.h"
#import "MXRuntimeStudy.h"

@interface XMDemoListVC ()

@end

@implementation XMDemoListVC

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"上下拖拽View", UIImageMake(@"icon_tabbar_uikit_selected"),@"cell移动", UIImageMake(@"icon_grid_theme"),
                       @"日历界面", UIImageMake(@"edit_icon_brush"),@"扫码界面", UIImageMake(@"edit_icon_brush"),@"发送邮件", UIImageMake(@"icon_grid_console"),@"字体测试", UIImageMake(@"icon_grid_collection"),@"条码测试", UIImageMake(@"icon_barcode_demo"),@"YYTest测试", UIImageMake(@"icon_YYLabel"),@"TableViewTest测试", UIImageMake(@"icon_list"),@"捏合测试", UIImageMake(@"gesture_pinch"),@"拖动测试",UIImageMake(@"gesture_pan"),@"编辑测试",UIImageMake(@"icon_edit"),@"绘画Demo",UIImageMake(@"icon_painter"),@"输入框Demo",UIImageMake(@"icon_input"),@"嵌套CategoryView",UIImageMake(@"icon_pageCategory"),@"学习Runtime",UIImageMake(@"icon_runtime"),
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
    } else if([title isEqualToString:@"扫码界面"]) {
        viewController = [[AipGeneralVC alloc] init];
    } else if([title isEqualToString:@"发送邮件"]) {
        viewController = [[MXSendMailVC alloc] init];
    } else if([title isEqualToString:@"字体测试"]) {
        viewController = [[MXFontOtfVC alloc] init];
    } else if([title isEqualToString:@"条码测试"]) {
        viewController = [[MXBarcodeDemoVC alloc] init];
    } else if([title isEqualToString:@"条码测试"]) {
        viewController = [[MXBarcodeDemoVC alloc] init];
    } else if([title isEqualToString:@"YYTest测试"]) {
        viewController = [[MXYYTextTestVC alloc] init];
    } else if([title isEqualToString:@"TableViewTest测试"]) {
        viewController = [[MXTableViewTestVC alloc] init];
    } else if([title isEqualToString:@"捏合测试"]) {
        viewController = [[MXPinchVC alloc] init];
    } else if([title isEqualToString:@"拖动测试"]) {
        viewController = [[MXPanVC alloc] init];
    } else if([title isEqualToString:@"编辑测试"]) {
        viewController = [[MXEditVC alloc] init];
    } else if([title isEqualToString:@"绘画Demo"]) {
        viewController = [[CanvasViewController alloc] init];
    } else if([title isEqualToString:@"输入框Demo"]) {
        viewController = [[MXInputVC alloc] init];
    } else if ([title isEqualToString:@"嵌套CategoryView"]) {
//        viewController = [[MXShopDetailVC alloc] init];
        viewController = [[MXCompressVC alloc] init];
    } else if ([title isEqualToString:@"学习Runtime"]) {
                viewController = [[MXRuntimeStudy alloc] init];
            }
    
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)handleAboutItemEvent {
//    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

@end
