//
//  FunctionMacro.h
//
//
//  Created by 唐伟明 on 2018/5/12.
//  Copyright © 2018年 唐伟明. All rights reserved.
//
#ifndef FunctionMacro_h
#define FunctionMacro_h

//字符串判空
#define FUNC_STRING_CHECK(obj) ([obj isKindOfClass:[NSString class]] && [obj length] > 0)

//安全取字符串
#define FUNC_GET_STRING(obj)    (FUNC_STRING_CHECK(obj)?obj:@" ")
#define FUNC_SAFE_STRING(obj)   (FUNC_STRING_CHECK(obj)?obj:@"")

//数组判空
#define FUNC_AYYAR_CHECK(obj)  (obj && [obj isKindOfClass:[NSArray class]] && ([obj count] > 0))
//字典判空
#define FUNC_DIC_CHECK(obj)    ([obj isKindOfClass:[NSDictionary class]] && [[obj allKeys] count]> 0)
//判空对象
#define FUNC_OBJ_CHECK(obj)    (!obj || [obj isKindOfClass:[NSNull class]])

//适配相关
#define FUNC_W(w) (w/375.0 * SCREEN_WIDTH)
#define FUNC_H(h) (h/667.0 * SCREEN_HEIGHT)

//创建url
#define FUNC_URL(str)              [NSURL URLWithString:FUNC_SAFE_STRING(str)]

//创建font
#define FUNC_FONT(size)             [UIFont systemFontOfSize:size]

#define PingFangSC_Light(Size)   [UIFont fontWithName:@"PingFangSC-Light" size:(Size)]

//根据宽度创建font
#define FUNC_FONTW(size)            [UIFont systemFontOfSize:FUNC_W(size)]

//快速创建颜色
#define FUNC_COLOR_HEXSTRING(string) [UIColor colorWithHexString:string]

//iPhone尺寸判断
#define IPHONE4_0  (SCREEN_WIDTH == 320.0 && SCREEN_HEIGHT == 568.0)//4寸屏幕
#define IPHONE4_7  (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 667.0)//4.7寸屏幕
#define IPHONE5_5  (SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 736.0)//5.5寸屏幕
#define IPHONE_X   (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0)//iPhoneX的屏幕
#define IPHONE_XR  (SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 896.0)//iPhoneXR的屏幕
#define IPHONE_XS  (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0)//iPhoneXS的屏幕
#define IPHONE_XSMax  (SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 896.0)//iPhoneXS的屏幕
#define EXIST_SAFE    (IPHONE_X||IPHONE_XR||IPHONE_XS||IPHONE_XSMax)//是否存在安全距离


//国际化
#define MTLocalizedString(key)  NSLocalizedString(key, nil)

//弹出消息
#define SHOWCENTERTOAST(msg)  [KEYWINDOW makeCenterToast:msg];

//弹出消息
#define SHOWERROR       SHOWCENTERTOAST(FUNC_SAFE_STRING(result.msg))

//弹出hud
#define SHOWHUD(view)       [view showHUD];
#define SHOWHUDKEYWINDOW    SHOWHUD(KEYWINDOW)

//弹出hud带文字
#define SHOWTITLEHUD(view,msg)   [view showHUD:msg];

//隐藏hud
#define HIDEHUD(view)      [view hideHUD];
#define HIDEHUDKEYWINDOW   [KEYWINDOW hideHUD];


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* FunctionMacro_h */
