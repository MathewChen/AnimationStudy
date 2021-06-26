//
//  MXBarcodeDemoVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/12/21.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXBarcodeDemoVC.h"
#import <ZXingObjC/ZXingObjC.h>

@interface MXBarcodeDemoVC ()

@property(nonatomic, strong) UIImageView *barcodeImageView;

@property(nonatomic, strong) QMUIButton *barcodeButton;

@property(nonatomic, strong) QMUIButton *extentionButton;

@property(nonatomic, strong) UIImageView *extentionImageView;

@property(nonatomic, strong) UIImage *testImage;
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
        make.size.mas_equalTo(CGSizeMake(300, 100));
    }];
    self.barcodeImageView = barcodeImageView;
    
    self.extentionButton = [[QMUIButton alloc] init];
    [self.view addSubview:self.extentionButton];
    self.extentionButton.backgroundColor = UIColor.qmui_randomColor;
    [self.extentionButton setTitle:@"生成附加码" forState:UIControlStateNormal];
    [self.extentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.barcodeImageView.mas_bottom).offset(32);
        make.left.mas_equalTo(barcodeButton.mas_right).offset(32);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    [self.extentionButton addTarget:self action:@selector(clickUPCEANExtensionBarcode) forControlEvents:UIControlEventTouchUpInside];
    
    self.extentionImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.extentionImageView];
    [self.extentionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.extentionButton.mas_bottom).offset(32);
        make.left.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(80, 200));
    }];
    
    self.testImage = [UIImage imageNamed:@"标准箭头测试图片"];
    NSData *data = UIImagePNGRepresentation(self.testImage);
    NSData *dataTsc = [self covertBitMapImageToGrayScale:self.testImage];
    NSLog(@"----");
}

- (void)clickBarcodeButton {
    
    //kBarcodeFormatCodabar --> 0123456789-:/.+abcd
    
    NSString *codaStr = @"12345678";
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
                                       width:600
                                      height:200
                                       error:&error];
        
        ZXBitMatrix *noWhite = [self deleteWrite:result];
        if (result) {
            ZXImage *image = [ZXImage imageWithMatrix:noWhite];
            return image;
        } else {
            [error localizedDescription];
            return nil;
        }
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

- (void)clickUPCEANExtensionBarcode {
    NSString *codaStr = @"6901234100";
    [self.extentionButton setTitle:codaStr forState:UIControlStateNormal];
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:codaStr
                                  format:kBarcodeFormatUPCEANExtension
                                   width:80
                                  height:200
                                   error:&error];
    if (result) {
      CGImageRef imageRef = CGImageRetain([[ZXImage imageWithMatrix:result] cgimage]);

      // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
        UIImage *image =  [[UIImage alloc]init];
        image = [UIImage imageWithCGImage:imageRef];
        self.extentionImageView.image = image;
      CGImageRelease(imageRef);
    } else {
      NSString *errorMessage = [error localizedDescription];
        NSLog(@"%@",errorMessage);
    }
    
    
    
    
}


#pragma mark - 解析条码

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
        
        NSLog(@"contents = %@ | format = %d",contents,format);
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }
}

/// 图像二值化处理
/// @param image 要处理的图像
- (NSData *)covertBitMapImageToGrayScale:(UIImage *)image{
      NSUInteger width = image.size.width;
      NSUInteger height = image.size.height;
    //像素将画在这个数组
    uint32_t *pixels = (uint32_t *)malloc(width * height *sizeof(uint32_t));
    //清空像素数组
    memset(pixels, 0, width * height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用 pixels 创建一个 context
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width*sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    NSUInteger tt =1;
    NSUInteger bw = 0;
    Byte bytes[width / 8 * height];
    NSUInteger p[8]={0,0,0,0,0,0,0,0};
    for (NSUInteger y = 0; y <height; y++) {
        for (NSUInteger x =0; x <width/8; x ++) {
            for(NSUInteger z = 0; z < 8; z++){
                uint8_t *rgbaPixel = (uint8_t *)&pixels[(y * width) + (x * 8 + z)];
                NSUInteger red = rgbaPixel[tt];
                NSUInteger green = rgbaPixel[tt + 1];
                NSUInteger blue = rgbaPixel[tt + 2];
//                NSUInteger gray = 0.3 * red + 0.59 * green + 0.11 * blue; // 灰度转化公式
                NSUInteger gray = 0.29900 * red + 0.58700 * green + 0.11400 * blue; // 灰度转化公式
                gray = gray >= 90 ? 0 : 1;
                p[z] = gray;
            }
            NSUInteger value = (p[0] * 128 + p[1] * 64 + p[2] * 32 + p[3] * 16 + p[4] * 8 + p[5] * 4 + p[6] * 2 + p[7]);
            bytes[bw] = value;
            bw++;
        }
    }
    free(pixels);
    NSData * data = [NSData dataWithBytes: bytes length: sizeof(bytes)];
    return data;
}
@end
