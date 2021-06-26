//
//  BaseItemView.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/7.
//  Copyright © 2021 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Barcode,
    Barcode2d,
    Line,
    Image,
    Font,
    Graphics,
    Time,
    Logo,
    Form,//增加表格类型
    NoneType,
}ItemType;

typedef NS_ENUM(NSInteger, RotateState) {
    RotateStateTop = 0,
    RotateStateRight,
    RotateStateBottom,
    RotateStateLeft
};

@class BaseItem;
@protocol ItemDelegate <NSObject>

- (void)itemFrameWillChange:(CGRect)frame;

- (void)itemFrameChanging:(CGRect)frame;

- (void)itemFrameChanged:(CGRect)frame Item:(BaseItem *)item;

@end

@interface BaseItem : UIView

@property(nonatomic, weak) id<ItemDelegate> delegate;

@property (nonatomic, assign)ItemType itemType;//图元类型

@property (nonatomic, assign)int datasource;//数据源0：固定数据 1：Excel导入 2：序列号 3：日期 4：时间

@property (nonatomic, assign)int angle;//旋转角度

@property (nonatomic, assign)CGRect moveRect;

@property (nonatomic, copy) NSMutableArray *rectArray;

@property (nonatomic, copy) NSMutableArray *rectUndoArray;

/// 创建Item
/// @param type item类型
/// @param image item图片
/// @param rect itemrect
/// @param url item的图片地址
+ (BaseItem *)createItemWidthType:(ItemType)type image:(UIImage *)image AndFrame:(CGRect)rect ImgUrl:(NSString *)url;

/// item旋转
/// @param state 旋转方式
- (void)itemRotate:(RotateState)state;

- (void)baseItemPan;
- (void)leftHandlePan;
@end
