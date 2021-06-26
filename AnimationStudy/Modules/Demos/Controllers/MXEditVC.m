//
//  MXEditVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/4/8.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXEditVC.h"

#import "UndoManagerHelper.h"

#import "SceneView.h"

@interface MXEditVC ()<ItemDelegate>

@property (nonatomic, strong)  UndoManagerHelper *undoManagerHelper;

@property(nonatomic, strong) SceneView *sceneView;

@property (nonatomic, strong) CAShapeLayer *itemiDashesShapeLayer;
/// 绘制路径
@property (nonatomic, strong) UIBezierPath *itemiDashesPath;

@end

@implementation MXEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sceneView = [[SceneView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.sceneView];
    
    [self handleButtonBuild];
    
    [self.view.layer addSublayer:self.itemiDashesShapeLayer];
}

- (void)handleButtonBuild {
    QMUIButton *addButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SAFE_BOTTOM - 40, SCREEN_WIDTH / 4, 40)];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    addButton.backgroundColor = [UIColor randomColor];
    [self.sceneView addSubview:addButton];
    
    QMUIButton *rotateButton = [[QMUIButton alloc] initWithFrame:CGRectMake(addButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 40, SCREEN_WIDTH / 4, 40)];
    [rotateButton setTitle:@"旋转" forState:UIControlStateNormal];
    [rotateButton addTarget:self action:@selector(clickRotateButton) forControlEvents:UIControlEventTouchUpInside];
    rotateButton.backgroundColor = [UIColor randomColor];
    [self.sceneView addSubview:rotateButton];
    
    QMUIButton *addFontButton = [[QMUIButton alloc] initWithFrame:CGRectMake(rotateButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 40, SCREEN_WIDTH / 4, 40)];
    [addFontButton setTitle:@"增大" forState:UIControlStateNormal];
    [addFontButton addTarget:self action:@selector(clickFontButton:) forControlEvents:UIControlEventTouchUpInside];
    addFontButton.backgroundColor = [UIColor randomColor];
    addFontButton.tag = 0;
    [self.sceneView addSubview:addFontButton];
    
    QMUIButton *subFontButton = [[QMUIButton alloc] initWithFrame:CGRectMake(addFontButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 40, SCREEN_WIDTH / 4, 40)];
    [subFontButton setTitle:@"减小" forState:UIControlStateNormal];
    [subFontButton addTarget:self action:@selector(clickFontButton:) forControlEvents:UIControlEventTouchUpInside];
    subFontButton.backgroundColor = [UIColor randomColor];
    subFontButton.tag = 1;
    [self.sceneView addSubview:subFontButton];
    
    QMUIButton *topButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SAFE_BOTTOM - 80, SCREEN_WIDTH / 4, 40)];
    [topButton setTitle:@"向上" forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(clickDirectionButton:) forControlEvents:UIControlEventTouchUpInside];
    topButton.backgroundColor = [UIColor randomColor];
    topButton.tag = 0;
    [self.sceneView addSubview:topButton];
    
    QMUIButton *bottomButton = [[QMUIButton alloc] initWithFrame:CGRectMake(topButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 80, SCREEN_WIDTH / 4, 40)];
    [bottomButton setTitle:@"向下" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(clickDirectionButton:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.backgroundColor = [UIColor randomColor];
    bottomButton.tag = 2;
    [self.sceneView addSubview:bottomButton];
    
    QMUIButton *leftButton = [[QMUIButton alloc] initWithFrame:CGRectMake(bottomButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 80, SCREEN_WIDTH / 4, 40)];
    [leftButton setTitle:@"向左" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickDirectionButton:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.backgroundColor = [UIColor randomColor];
    leftButton.tag = 3;
    [self.sceneView addSubview:leftButton];
    
    QMUIButton *rightButton = [[QMUIButton alloc] initWithFrame:CGRectMake(leftButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 80, SCREEN_WIDTH / 4, 40)];
    [rightButton setTitle:@"向右" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickDirectionButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor = [UIColor randomColor];
    rightButton.tag = 1;
    [self.sceneView addSubview:rightButton];
    
    QMUIButton *leftAlimentButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SAFE_BOTTOM - 120, SCREEN_WIDTH / 4, 40)];
    [leftAlimentButton setTitle:@"居左" forState:UIControlStateNormal];
    [leftAlimentButton addTarget:self action:@selector(clickTextAliment:) forControlEvents:UIControlEventTouchUpInside];
    leftAlimentButton.backgroundColor = [UIColor randomColor];
    leftAlimentButton.tag = 0;
    [self.sceneView addSubview:leftAlimentButton];
    
    QMUIButton *centerAlimentButton = [[QMUIButton alloc] initWithFrame:CGRectMake(leftAlimentButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 120, SCREEN_WIDTH / 4, 40)];
    [centerAlimentButton setTitle:@"居中" forState:UIControlStateNormal];
    [centerAlimentButton addTarget:self action:@selector(clickTextAliment:) forControlEvents:UIControlEventTouchUpInside];
    centerAlimentButton.backgroundColor = [UIColor randomColor];
    centerAlimentButton.tag = 1;
    [self.sceneView addSubview:centerAlimentButton];
    
    QMUIButton *rightAlimentButton = [[QMUIButton alloc] initWithFrame:CGRectMake(centerAlimentButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 120, SCREEN_WIDTH / 4, 40)];
    [rightAlimentButton setTitle:@"居右" forState:UIControlStateNormal];
    [rightAlimentButton addTarget:self action:@selector(clickTextAliment:) forControlEvents:UIControlEventTouchUpInside];
    rightAlimentButton.backgroundColor = [UIColor randomColor];
    rightAlimentButton.tag = 2;
    [self.sceneView addSubview:rightAlimentButton];
    
    QMUIButton *undoButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SAFE_BOTTOM - 160, SCREEN_WIDTH / 4, 40)];
    [undoButton setTitle:@"撤销" forState:UIControlStateNormal];
    [undoButton addTarget:self action:@selector(clickUndoButton) forControlEvents:UIControlEventTouchUpInside];
    undoButton.backgroundColor = [UIColor randomColor];
    [self.sceneView addSubview:undoButton];
    
    QMUIButton *redoButton = [[QMUIButton alloc] initWithFrame:CGRectMake(undoButton.qmui_right, SCREEN_HEIGHT - SAFE_BOTTOM - 160, SCREEN_WIDTH / 4, 40)];
    [redoButton setTitle:@"恢复" forState:UIControlStateNormal];
    [redoButton addTarget:self action:@selector(clickRedoButton) forControlEvents:UIControlEventTouchUpInside];
    redoButton.backgroundColor = [UIColor randomColor];
    [self.sceneView addSubview:redoButton];
}

- (void)clickAddButton {
    BaseItem *baseItem = [self.sceneView.paperView addItem];
    baseItem.delegate = self;
}

- (void)clickRotateButton {
    
    BaseItem *baseItem = (BaseItem *)[self.sceneView.paperView.viewList firstObject];
    
    [self itemMove:baseItem UndoType:UndoAngle];
    
    [self.sceneView.paperView itemRotate:RotateStateTop];
}

- (void)clickFontButton:(QMUIButton *)button {
    [self.sceneView.paperView itemFontChange:button.tag];
}

- (void)clickDirectionButton:(QMUIButton *)button {
    
    [self.sceneView.paperView itemMove:button.tag];
     
}

- (void)clickTextAliment:(QMUIButton *)button {
    
    [self.sceneView.paperView itemTextAliment:button.tag];
}

#pragma mark - 撤销、恢复

- (void)clickUndoButton {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)clickRedoButton {
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

#pragma mark - ItemDelegate

- (void)itemFrameWillChange:(CGRect)frame {
    self.itemiDashesShapeLayer.hidden = NO;
}

- (void)itemFrameChanging:(CGRect)frame {
    NSLog(@"frame:%@",NSStringFromCGRect(frame));
    CGRect newFrame = frame;
    newFrame.origin.x = self.sceneView.paperView.qmui_left + frame.origin.x * self.sceneView.paperView.totalScale;
    newFrame.origin.y = self.sceneView.paperView.qmui_top + frame.origin.y * self.sceneView.paperView.totalScale;
    
    newFrame.size.width = frame.size.width * self.sceneView.paperView.totalScale;
    newFrame.size.height = frame.size.height * self.sceneView.paperView.totalScale;
    
    [self itemDashesMoveSceneFrame:self.view.frame itemFrame:newFrame angle:0];
}

//- (void)itemFrameChanged:(CGRect)frame {
//
//}

- (void)itemFrameChanged:(CGRect)frame Item:(id)item {
    self.itemiDashesShapeLayer.hidden = YES;
    
    [self itemMove:item UndoType:UndoFrame];
    
    NSLog(@"itemFrameChanged:%@",NSStringFromCGRect(frame));
}

#pragma mark - 虚线绘制

- (void)itemDashesMoveSceneFrame:(CGRect)sceneFrame itemFrame:(CGRect)itemFrame angle:(int)angle {
    //移除轨迹
    [_itemiDashesPath removeAllPoints];
    
    _itemiDashesPath = [UIBezierPath bezierPath];
    
    //item左边的线条
    [_itemiDashesPath moveToPoint:CGPointMake(itemFrame.origin.x, 0)];

    [_itemiDashesPath addLineToPoint:CGPointMake(itemFrame.origin.x, sceneFrame.size.height)];
    
    //item右边的线条
    [_itemiDashesPath moveToPoint:CGPointMake(itemFrame.origin.x + itemFrame.size.width, 0)];

    [_itemiDashesPath addLineToPoint:CGPointMake(itemFrame.origin.x + itemFrame.size.width, sceneFrame.size.height)];
    
    //item顶部的线条
    [_itemiDashesPath moveToPoint:CGPointMake(0, itemFrame.origin.y)];

    [_itemiDashesPath addLineToPoint:CGPointMake(sceneFrame.size.width, itemFrame.origin.y)];
    
    //item底部的线条
    [_itemiDashesPath moveToPoint:CGPointMake(0, itemFrame.origin.y + itemFrame.size.height)];

    [_itemiDashesPath addLineToPoint:CGPointMake(sceneFrame.size.width, itemFrame.origin.y + itemFrame.size.height)];
    
    self.itemiDashesShapeLayer.path = self.itemiDashesPath.CGPath;
}

#pragma mark - 移动撤销、恢复三部曲
- (void)itemBeforMove:(BaseItem *)item {
    [[self.undoManager prepareWithInvocationTarget:self] itemAfterMove:item];
    [self.undoManagerHelper itemBeforAction:item];
}

- (void)itemAfterMove:(BaseItem *)item {
    [[self.undoManager prepareWithInvocationTarget:self] itemBeforMove:item];
    [self.undoManagerHelper itemAfterAction:item];
}

- (void)itemMove:(BaseItem *)item UndoType:(UndoType)undotype {
    [[self.undoManager prepareWithInvocationTarget:self] itemBeforMove:item];
    [self.undoManagerHelper itemAction:item UndoType:undotype];
}


#pragma mark - 初始化
- (CAShapeLayer *)itemiDashesShapeLayer {
    if (!_itemiDashesShapeLayer) {
        _itemiDashesShapeLayer = [CAShapeLayer layer];
        _itemiDashesShapeLayer.lineWidth = 1 ;
        _itemiDashesShapeLayer.strokeColor = UIColor.yellowColor.CGColor;
        _itemiDashesShapeLayer.fillColor = nil; // 默认为blackColor
        _itemiDashesShapeLayer.lineDashPattern =  @[@(5),@(2)];
        _itemiDashesShapeLayer.path = self.itemiDashesPath.CGPath;
        _itemiDashesShapeLayer.hidden = YES;
    }
    return _itemiDashesShapeLayer;
}

- (UndoManagerHelper *)undoManagerHelper {
    if (!_undoManagerHelper) {
        _undoManagerHelper = [[UndoManagerHelper alloc] init];
    }
    return _undoManagerHelper;
}
@end
