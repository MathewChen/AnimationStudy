//
//  MXPrinterStatuVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/21.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXPrinterStatuVC.h"
#import "PrinterStatusView.h"

@interface MXPrinterStatuVC ()

@end

@implementation MXPrinterStatuVC

- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.qmui_randomColor;
    
    QMUIButton *showButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16, 100, 100, 40)];
    showButton.backgroundColor = UIColor.qmui_randomColor;
    [self.view addSubview:showButton];
    [showButton addTarget:self action:@selector(showPrinterStatusView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPrinterStatusView {
    
}

- (void)initDataSource {
    
}


@end
