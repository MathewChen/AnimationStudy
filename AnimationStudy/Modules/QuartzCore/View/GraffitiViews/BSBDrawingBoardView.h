//
//  BSBDrawingBoardView.h
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 dudian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSBDrawingBoardView : UIView

@property(nonatomic, assign) NSInteger lineRecordWidth;//画笔宽度

@property(nonatomic,strong) UIColor* lineColor;//画笔颜色

//线条数量
@property(nonatomic,assign) NSInteger linePathsCounts;

//撤销数量
@property(nonatomic,assign) NSInteger redoPathsCounts;

- (void)clean;//清除画板
- (void)undo;//回退上一步
- (void)redo;
- (void)pen;
- (void)eraser;//橡皮擦
- (void)save;//保存到相册

@end

NS_ASSUME_NONNULL_END
