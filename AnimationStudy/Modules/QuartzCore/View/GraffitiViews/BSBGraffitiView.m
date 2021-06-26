//
//  TTLGraffitiView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 Star. All rights reserved.
//

#import "BSBGraffitiView.h"
#import "BSBDrawingBoardView.h"
#import "UIImage+Screenshot.h"
@interface BSBGraffitiView ()

@property (nonatomic, strong) QMUIButton *cleanButton;

@property (nonatomic, strong) QMUIButton *penButton;

@property (nonatomic, strong) QMUIButton *eraserButton;

@property (nonatomic, strong) QMUIButton *undoButton;

@property (nonatomic, strong) QMUIButton *redoButton;

@property (nonatomic, strong) UIButton *ensureButton;

@property (nonatomic, strong) BSBDrawingBoardView *boardView;

@property (nonatomic, strong) QMUIButton *penStatusButton;

@end

@implementation BSBGraffitiView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - FUNC_W(305), SCREEN_WIDTH, FUNC_W(305))];
    [contentView cuttingViewbyRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadiusWidth:24.f];
    contentView.backgroundColor = UIColor.whiteColor;
    [self addSubview:contentView];

    UIView *funcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    funcView.backgroundColor = UIColor.whiteColor;
    [contentView addSubview:funcView];

    CGFloat buttonWidth = FUNC_W(42);
    CGFloat buttonHeight = FUNC_W(32);
    CGFloat buttonTop = FUNC_W(10);
    
    QMUIButton *cleanButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16 * 1 + buttonWidth * 0, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:cleanButton];
    cleanButton.layer.cornerRadius = 4.f;
    cleanButton.backgroundColor = UIColor.whiteColor;
    [cleanButton setImage:UIImageMake(@"edit_icon_empty") forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(clickCleanButton) forControlEvents:UIControlEventTouchUpInside];
    self.cleanButton = cleanButton;

    QMUIButton *penButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16 * 2 + buttonWidth * 1, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:penButton];
    penButton.layer.cornerRadius = 4.f;
    penButton.backgroundColor = [UIColor colorWithHexString:@"2274E6" alpha:0.1];
    [penButton setImage:UIImageMake(@"edit_icon_brush") forState:UIControlStateNormal];
    [penButton addTarget:self action:@selector(clickPenButton) forControlEvents:UIControlEventTouchUpInside];
    self.penButton = penButton;

    QMUIButton *eraserButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16 * 3 + buttonWidth * 2, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:eraserButton];
    eraserButton.layer.cornerRadius = 4.f;
    eraserButton.backgroundColor = UIColor.whiteColor;
    [eraserButton setImage:UIImageMake(@"edit_icon_eraser") forState:UIControlStateNormal];
    [eraserButton addTarget:self action:@selector(clickEraserButton) forControlEvents:UIControlEventTouchUpInside];
    self.eraserButton = eraserButton;

    QMUIButton *undoButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16 * 4 + buttonWidth * 3, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:undoButton];
    undoButton.layer.cornerRadius = 4.f;
    undoButton.backgroundColor = UIColor.whiteColor;
    [undoButton setImage:UIImageMake(@"edit_icon_undo_hide") forState:UIControlStateNormal];
    [undoButton addTarget:self action:@selector(clickUndoButton) forControlEvents:UIControlEventTouchUpInside];
    self.undoButton = undoButton;

    QMUIButton *redoButton = [[QMUIButton alloc] initWithFrame:CGRectMake(16 * 5 + buttonWidth * 4, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:redoButton];
    redoButton.layer.cornerRadius = 4.f;
    redoButton.backgroundColor = UIColor.whiteColor;
    [redoButton setImage:UIImageMake(@"edit_icon_redo_hide") forState:UIControlStateNormal];
    [redoButton addTarget:self action:@selector(clickRedoButton) forControlEvents:UIControlEventTouchUpInside];
    self.redoButton = redoButton;

    UIButton *ensureButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - buttonWidth - 16, buttonTop, buttonWidth, buttonHeight)];
    [funcView addSubview:ensureButton];
    ensureButton.layer.cornerRadius = 4.f;
    [ensureButton.titleLabel setFont:FUNC_FONT(14)];
    ensureButton.backgroundColor = UIColor.whiteColor;
//    [ensureButton setTitleColor:UIColor.theme forState:UIControlStateNormal];
    [ensureButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [ensureButton setTitle:NSLocalizedString(@"搜狗", nil) forState:UIControlStateNormal];
    [ensureButton addTarget:self action:@selector(clickenSureButton) forControlEvents:UIControlEventTouchUpInside];
    self.ensureButton = ensureButton;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, funcView.sh_bottom, SCREEN_WIDTH, FUNC_W(1))];
    lineView.backgroundColor = FUNC_COLOR_HEXSTRING(@"E5E5E5");
    [funcView addSubview:lineView];
    
    BSBDrawingBoardView *drawView = [[BSBDrawingBoardView alloc] init];
    drawView.frame = CGRectMake(0, FUNC_W(49), SCREEN_WIDTH, FUNC_W(256));
    [contentView addSubview:drawView];
    
    
    self.boardView = drawView;
    //设置画板背景颜色
    self.boardView.backgroundColor=[UIColor whiteColor];
    //设置画笔宽度
    self.boardView.lineRecordWidth = 5;
    //设置画笔颜色
    self.boardView.lineColor = UIColor.blackColor;
    

    //监听
    @weakify(self);
    [RACObserve(self.boardView, linePathsCounts) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        if ([x intValue] == 0) {
            [self.undoButton setImage:UIImageMake(@"edit_icon_undo_hide") forState:UIControlStateNormal];
        }else {
            [self.undoButton setImage:UIImageMake(@"edit_icon_undo_normal") forState:UIControlStateNormal];
        }
    }];
    [RACObserve(self.boardView, redoPathsCounts) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x intValue] == 0) {
            [self.redoButton setImage:UIImageMake(@"edit_icon_redo_hide") forState:UIControlStateNormal];
        }else {
            [self.redoButton setImage:UIImageMake(@"edit_icon_redo_normal") forState:UIControlStateNormal];
        }
    }];
}

- (void)clickCleanButton {
    
    NSLog(@"clickCleanButton");
//    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"是否清空所有涂鸦?", nil) style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"确定", nil) actionHandler:nil cancelHandler:^(LGAlertView * _Nonnull alertView) {
//
//    } destructiveHandler:^(LGAlertView * _Nonnull alertView) {
//        [self.boardView clean];
//    }];
//    alertView.cancelButtonTitleColor = FUNC_COLOR_HEXSTRING(kMainColor);
//    alertView.cancelButtonFont = FUNC_FONT(16);
//    alertView.cancelButtonBackgroundColorHighlighted = [FUNC_COLOR_HEXSTRING(kMainColor)colorWithAlphaComponent:0.7];
//    alertView.destructiveButtonTitleColor =  FUNC_COLOR_HEXSTRING(kMainColor);
//    alertView.destructiveButtonBackgroundColorHighlighted = [FUNC_COLOR_HEXSTRING(kMainColor)colorWithAlphaComponent:0.7];
//    alertView.destructiveButtonFont = FUNC_FONT(16);
//    [alertView showAnimated];
}

- (void)clickPenButton {
    NSLog(@"clickPenButton");
    self.penButton.backgroundColor = [UIColor colorWithHexString:@"2274E6" alpha:0.1];
    self.eraserButton.backgroundColor = UIColor.whiteColor;
    [self.boardView pen];
}

- (void)clickEraserButton {
    self.penButton.backgroundColor = UIColor.whiteColor;
    self.eraserButton.backgroundColor = [UIColor colorWithHexString:@"2274E6" alpha:0.1];
    [self.boardView eraser];
    NSLog(@"clickEraserButton");
}

- (void)clickRedoButton {
    [self.boardView redo];
    NSLog(@"clickRedoButton");
}

- (void)clickUndoButton {
    [self.boardView undo];
    NSLog(@"clickUndoButton");
}

- (void)clickenSureButton {
    NSLog(@"clickenSureButton");
    if (self.graffitiImageBlock) {
//        self.graffitiImageBlock([[UIImage qmui_imageWithView:self.boardView] qmui_imageWithTintColor:UIColor.yellowColor]);
        self.graffitiImageBlock([UIImage imageToTransparent:[UIImage getImageViewWithView:self.boardView]]);
//        self.graffitiImageBlock([UIImage getImageViewWithView:self.boardView]);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [UIView animateWithDuration:0.25 delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = self.frame;
        frame.origin.y = UIScreen.mainScreen.bounds.size.height;
        self.frame = frame;

    } completion:^(BOOL finished) {
        
    }];
    
}
@end

