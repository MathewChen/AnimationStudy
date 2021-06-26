//
//  UIViewController+DLCategory.m
//  DLabel
//
//  Created by 唐伟明 on 2019/10/11.
//  Copyright © 2019 Star. All rights reserved.
//

#import "UIViewController+DLCategory.h"


@implementation UIViewController (DLCategory)

- (void)configureLeftBarButtonUniformly {
    
    NSString * className = NSStringFromClass([self class]);
    
      UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(DLVc_Back:)];
       if (@available(iOS 10, *)) {
           self.navigationItem.leftBarButtonItem = btnItem;
       } else {
           UIBarButtonItem *fixedSpaceBarButtonItemMin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
           fixedSpaceBarButtonItemMin.width = -5.0f;
           self.navigationItem.leftBarButtonItems = @[fixedSpaceBarButtonItemMin,btnItem];
       }
    
}

- (void)DLVc_Back:(id)sender
{
    if (self.navigationController) {
        if ([self.navigationController.viewControllers[0] isEqual:self]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
