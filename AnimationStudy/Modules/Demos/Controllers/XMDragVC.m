//
//  XMDragVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/9/29.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "XMDragVC.h"
#import "MXVerticalDragView.h"
#import "DLVerticalDragView.h"
#import "DLFillPrintListView.h"
@interface XMDragVC ()

@end

@implementation XMDragVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MXVerticalDragView *dragView = [[MXVerticalDragView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 267 + 48 + SAFE_BOTTOM)];
//    MXVerticalDragView *dragView = [[MXVerticalDragView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    dragView.backgroundColor = UIColor.qmui_randomColor;
//    [self.view addSubview:dragView];
    
//    DLVerticalDragView *dragView = [[DLVerticalDragView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    dragView.backgroundColor = UIColor.qmui_randomColor;
//    dragView.dragViewTitle = @"标签";
//    dragView.dragViewDesStr = @"(24)";
//    [self.view addSubview:dragView];
    
    DLFillPrintListView *dragView = [[DLFillPrintListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    dragView.backgroundColor = UIColor.qmui_randomColor;
    dragView.dragViewTitle = @"标签";
    dragView.dragViewDesStr = @"(24)";
    [self.view addSubview:dragView];
    
    UIView *redView = [[UIView alloc] init];
    [self.view addSubview:redView];
    redView.backgroundColor = UIColor.redColor;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}


@end
