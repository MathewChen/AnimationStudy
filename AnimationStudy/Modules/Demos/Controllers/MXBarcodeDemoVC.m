//
//  MXBarcodeDemoVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/21.
//  Copyright © 2020 dudian. All rights reserved.
//

#import "MXBarcodeDemoVC.h"
#import <ZXingObjC/ZXingObjC.h>

@interface MXBarcodeDemoVC ()

@property(nonatomic, strong) UIImageView *barcodeImageView;

@end

@implementation MXBarcodeDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.qmui_randomColor;
    
    QMUIButton *barcodeButton = [[QMUIButton alloc] init];
    [self.view addSubview:barcodeButton];
    barcodeButton.backgroundColor = UIColor.qmui_randomColor;
    [barcodeButton setTitle:@"生成条码" forState:UIControlStateNormal];
    [barcodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [barcodeButton addTarget:self action:@selector(clickBarcodeButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *barcodeImageView = [[UIImageView alloc] init];
    [self.view addSubview:barcodeImageView];
    [barcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(barcodeButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(300, 100));
    }];
    self.barcodeImageView = barcodeImageView;
}

- (void)clickBarcodeButton {
    
    CGImageRef cgimg =  CGImageRetain([[self create:@"1234567890128" format:kBarcodeFormatUPCEANExtension] cgimage]);
    UIImage *image =  [[UIImage alloc]init];
    image = [UIImage imageWithCGImage:cgimg];
    
    self.barcodeImageView.image = image;
}

-(ZXImage *)create:(NSString *)value format:(ZXBarcodeFormat)format {
    @try{
        NSError *error = nil;
        ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
        ZXBitMatrix *result = [writer encode:value
                                      format:format
                                       width:500
                                      height:500
                                       error:&error];
        
        ZXBitMatrix *noWhite = [self deleteWrite:result];
        if (result) {
            ZXImage *image = [ZXImage imageWithMatrix:noWhite];
            return image;
        } else {
            [error localizedDescription];
            return nil;
        }
    }@catch (NSException *e){
        return nil;
    }
}

- (ZXBitMatrix *)deleteWrite:(ZXBitMatrix *)matrix {
    if(!matrix)
        return nil;
    
    ZXIntArray *rec = [matrix enclosingRectangle];
    int resWidth = rec.array[2] + 1;
    int resHeight = rec.array[3] + 1;
    
    ZXBitMatrix *resMatrix = [[ZXBitMatrix alloc] initWithWidth:resWidth height:resHeight];
    [resMatrix clear];
    for (int i = 0; i < resWidth; i++) {
        for (int j = 0; j < resHeight; j++) {
            if ([matrix getX:i + rec.array[0] y:j + rec.array[1]]) {
                [resMatrix setX:i y:j];
            }
        }
    }
    return resMatrix;
}

@end
