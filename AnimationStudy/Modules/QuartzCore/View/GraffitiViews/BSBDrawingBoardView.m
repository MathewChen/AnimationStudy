//
//  BSBDrawingBoardView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/7/10.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "BSBDrawingBoardView.h"
#import "MyUIBezierPath.h"

@interface BSBDrawingBoardView ()

@property(nonatomic, assign) NSInteger lineWidth;

@property(nonatomic,strong) UIImageView *penImageView;

//此数组用来管理画板上所有的路径
@property(nonatomic,strong) NSMutableArray *linePaths;

//
@property(nonatomic,strong) NSMutableArray *redoPaths;

@end

@implementation BSBDrawingBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.lineRecordWidth = 10;
}

- (NSMutableArray *)linePaths {
    if(!_linePaths){
        _linePaths=[NSMutableArray array];
    }
    return _linePaths;
}

- (NSMutableArray *)redoPaths {
    if (!_redoPaths) {
        _redoPaths = [[NSMutableArray alloc] init];
    }
    return _redoPaths;
}

//清除
- (void)clean{
    [self.linePaths removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}

//撤销
- (void)undo{
    
    if (self.linePaths.count > 0) {
        [self.redoPaths addObject:self.linePaths.lastObject];
        [self.linePaths removeLastObject];
        //重绘
        [self setNeedsDisplay];
    }
}

//撤销
- (void)redo{
    
    if (self.redoPaths.count > 0) {
        [self.linePaths addObject:self.redoPaths.lastObject];
        [self.redoPaths removeLastObject];
        //重绘
        [self setNeedsDisplay];
        
    }
}

//橡皮擦
- (void)eraser{
    _lineColor = self.backgroundColor;
    _lineWidth = self.lineRecordWidth * 2;
}

- (void)pen {
    _lineColor= UIColor.blackColor;
    _lineWidth = self.lineRecordWidth;
}

//保存
- (void) save {
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //截屏
    [self.layer renderInContext:context];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    
    
}

//保存图片的回调
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
    }else{
        message = [error description];
    }
    NSLog(@"message is %@",message);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取触摸对象
    UITouch *touch=[touches anyObject];
    // 获取手指的位置
    CGPoint point=[touch locationInView:touch.view];
    //当手指按下的时候就创建一条路径
    MyUIBezierPath *path=[MyUIBezierPath bezierPath];
    //设置画笔宽度
    if(_lineWidth<=0){
        [path setLineWidth:5];
    }else{
        [path setLineWidth:_lineWidth];
    }
    //设置画笔颜色
    [path setLineColor:_lineColor];
    //设置起点
    [path moveToPoint:point];
    // 把每一次新创建的路径 添加到数组当中
    [self.linePaths addObject:path];
    NSLog(@"touchesBegan");
    
    [self.redoPaths removeAllObjects];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取触摸对象
    UITouch *touch=[touches anyObject];
    // 获取手指的位置
    CGPoint point=[touch locationInView:touch.view];
    // 连线的点
    [[self.linePaths lastObject] addLineToPoint:point];
    // 重绘
    [self setNeedsDisplay];
    NSLog(@"touchesMoved");
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (MyUIBezierPath *path in self.linePaths) {
        //设置颜色
        [path.lineColor set];
        // 设置连接处的样式
        [path setLineJoinStyle:kCGLineJoinRound];
        // 设置头尾的样式
        [path setLineCapStyle:kCGLineCapRound];
        //渲染
        [path stroke];
    }
    NSLog(@"linePathscount = %tu",self.linePaths.count);
    self.linePathsCounts = self.linePaths.count;
    self.redoPathsCounts = self.redoPaths.count;
}

@end
