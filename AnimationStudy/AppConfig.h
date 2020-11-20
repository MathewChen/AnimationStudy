
//
//  AppConfig.h
//
//  Created by 唐伟明 on 2018/6/10.
//  Copyright © 2018年 唐伟明. All rights reserved.
//


#ifndef AppConfig_h
#define AppConfig_h

//屏幕尺寸
#define SCREEN_BOUNS       [UIScreen mainScreen].bounds
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
#define SCREEN_SCALE       [UIScreen mainScreen].scale
#define SCREEN_CENTER      (SCREEN_HEIGHT - TOP_HEIGHT - BOTTOM_HEIGHT)
#define ONE_PX             (1.0f/SCREEN_SCALE)//1px
#define SAFE_BOTTOM        (EXIST_SAFE ? 34:0)
#define TABBAR_HEIGHT      49.0f
#define NAVBAR_HEIGHT      44.0f
#define STATUBAR_HEIGHT    [[UIApplication sharedApplication] statusBarFrame].size.height
#define TOP_HEIGHT         (NAVBAR_HEIGHT + STATUBAR_HEIGHT)
#define BOTTOM_HEIGHT      (TABBAR_HEIGHT+SAFE_BOTTOM)
#define KEYWINDOW          [UIApplication sharedApplication].keyWindow
#define LRMARGIN           FUNC_W(10.f)
#define CR    4.f
#define CELL_HEIGHT    51.f
#define BUTTON_HEIGHT    44.f
//app版本
#define APP_VERSION        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//app构建号
#define APP_BUILD          [[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleVersion"]



//app名字
#define APP_NAME           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//全局pagesize
#define PAGESIZE           @"15"

//常见单利
#define KUSERDEFAULTS         [NSUserDefaults standardUserDefaults]
#define KNOTIFICATIONCENTER   [NSNotificationCenter defaultCenter]
#define KAPPLICATION          [UIApplication sharedApplication]
#define KAPPDELEGATE          ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

//参数量
//速度
#define KSpeedNormal         5
#define KSpeedMax            8
#define KSpeedMin            2
//浓度
#define KDensityNormal         8
#define KDensityMax            15
#define KDensityMin            1
//送纸偏移(mm)
#define KDeviationNormal         0
#define KDeviationMax            10
#define KDeviationMin            -10
//裁剪数量
#define KCutMin            1
#define KCutMax            99
//裁剪数量
#define KPrintNumMin           1
#define KPrintNumMax           9999
//时间偏移
#define KTimeOffsetNormal         0
#define KTimeOffsetMin           -99
#define KTimeOffsetMax           99
//字体大小
#define KFontSizeNormal         16
#define KFontSizeMin           6
#define KFontSizeMax           500

//框
#define KItemMin                1
#define KItemMax                190
//圆角
#define KRadiusMin          0.00
#define KRadiusMax          10.00
#define KRadiusChange          0.1

//线宽
#define KLineMin          0.1
#define KLineMax          10
#define KLineChange          0.1

//字间距
#define KHSizeMin          0
#define KHSizeMax          10
#define KHSizeChange          0.1
#define KHSizeNormal       0

//字间距
#define KVSizeMin          0
#define KVSizeMax          10
#define KVSizeChange          0.1
#define KVSizeNormal       0

//递变量Interval
#define KIntervalMin          -999999
#define KIntervalMax          999999
#define KIntervalChange          1

//标签名称长度
#define KLabelLengthMax          20

//标签排数
#define KLabelRowMin          1
#define KLabelRowMax          10

//标签间距
#define KLabelOffsetMin          1
#define KLabelOffsetMax          10
#define KLabelOffsetNormal          2

//左右间距
#define KSpacingMin          1
#define KSpacingMax          10
#define KSpacingNormal          2

//线条宽度
#define KLineWidthMin          0.10
#define KLineWidthMax          99
#define KLineWidthNormal          0.3
//线条长度
#define KLineLengthMin          1
#define KLineLengthMax          999
#define KLineLengthNormal        15

//纸张宽度
#define KLabelWidthMin          10
#define KLabelWidthMax          190
#define KLabelWidthNormal        40

//纸张高度
#define KLabelHightMin          10
#define KLabelHightMax          190
#define KLabelHightNormal        30

//纸张水平偏移x
#define KOffsetXMin          -10
#define KOffsetXMax          10
#define KOffsetXNormal        0

//纸张垂直偏移y
#define KOffsetYMin          -10
#define KOffsetYMax          10
#define KOffsetYNormal        0

//亮度
#define KBrightnessMin          -100
#define KBrightnessMax          100
#define KBrightnessNormal        0
#define KBrightnessChange          5

//对比度
#define KContrastMin          0
#define KContrastMax          100
#define KContrastNormal        25
#define KContrastChange          5

//饱和度
#define KSaturationMin          0
#define KSaturationMax          100
#define KSaturationNormal        50
#define KSaturationChange          5

//阀值
#define KThresholdMin          1
#define KThresholdMax          255
#define KThresholdNormal        100
#define KThresholdChange          5
#endif /* AppConfig_h */
