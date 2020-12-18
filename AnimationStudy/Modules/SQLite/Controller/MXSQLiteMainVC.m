//
//  MXSQLiteMainVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/5/25.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXSQLiteMainVC.h"
#import "MXWCDBDemoVC.h"

@interface MXSQLiteMainVC ()

@end

@implementation MXSQLiteMainVC

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"WCDB", UIImageMake(@"icon_tabbar_uikit_selected"),
                       nil];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"SQLine";
    
}

- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"WCDB"]) {
        viewController = [[MXWCDBDemoVC alloc] init];
    }

    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
