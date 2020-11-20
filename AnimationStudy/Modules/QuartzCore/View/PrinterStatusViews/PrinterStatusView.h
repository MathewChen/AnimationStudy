//
//  PrinterStatusView.h
//  AnimationStudy
//
//  Created by mingxing on 2020/7/21.
//  Copyright © 2020 dudian. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 打印机提示状态
typedef NS_ENUM(NSUInteger, PrinterStatusType) {
    //缺纸
    PrinterStatusTypeNoPaper = 0,
    //开盖
    PrinterStatusTypePrinterOpen,
};

@interface PrinterStatusView : UIView


/// 打印机提示View初始化
/// @param frame 提示frame
/// @param type 状态类型
- (instancetype)initWithFrame:(CGRect)frame PrinterStatusType:(PrinterStatusType)type;

@end
