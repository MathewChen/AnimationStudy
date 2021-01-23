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

@property(nonatomic, strong) QMUIButton *barcodeButton;

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
    self.barcodeButton = barcodeButton;
    
    QMUIButton *decodeButton = [[QMUIButton alloc] init];
    [self.view addSubview:decodeButton];
    decodeButton.backgroundColor = UIColor.qmui_randomColor;
    [decodeButton setTitle:@"解析条码" forState:UIControlStateNormal];
    [decodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.mas_equalTo(barcodeButton.mas_right).offset(32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [decodeButton addTarget:self action:@selector(clickDecodeButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *barcodeImageView = [[UIImageView alloc] init];
    [self.view addSubview:barcodeImageView];
    [barcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(barcodeButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
    self.barcodeImageView = barcodeImageView;
}

- (void)clickBarcodeButton {
    
    NSString *codaStr = @"a12347a";
    [self.barcodeButton setTitle:codaStr forState:UIControlStateNormal];
    
    CGImageRef cgimg =  CGImageRetain([[self create:codaStr format:kBarcodeFormatCodabar] cgimage]);
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
                                       width:300
                                      height:200
                                       error:&error];
        
//        ZXBitMatrix *noWhite = [self deleteWrite:result];
//        if (result) {
//            ZXImage *image = [ZXImage imageWithMatrix:noWhite];
//            return image;
//        } else {
//            [error localizedDescription];
//            return nil;
//        }
        ZXImage *image = [ZXImage imageWithMatrix:result];
        return image;
        
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


- (void)clickDecodeButton {
    CGImageRef imageToDecode = self.barcodeImageView.image.CGImage;  // Given a CGImage in which we are looking for barcodes

//    ZXLuminanceSource *source = [[[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode] autorelease];
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];

    NSError *error = nil;

    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    [hints containsFormat:kBarcodeFormatCodabar];
    hints.returnCodaBarStartEnd = YES;
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    
    if (result) {
      // The coded result as a string. The raw data can be accessed with
      // result.rawBytes and result.length.
      NSString *contents = result.text;

      // The barcode format, such as a QR code or UPC-A
      ZXBarcodeFormat format = result.barcodeFormat;
    } else {
      // Use error to determine why we didn't get a result, such as a barcode
      // not being found, an invalid checksum, or a format inconsistency.
    }
}
@end
