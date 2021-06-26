//
//  MXCompressVC.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/10.
//  Copyright © 2021 Star. All rights reserved.
//

#import "MXCompressVC.h"
#import "CompressionTest.h"
#import "NSFileManager+Path.h"

#include <zlib.h>

#define CHUNK 16384
@interface MXCompressVC ()

@end

@implementation MXCompressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *originPath = [[NSBundle mainBundle] pathForResource:@"Deflate_origin.debug" ofType:nil];
    NSData *originData = [NSData dataWithContentsOfFile:originPath];
    
    NSLog(@"%zd",originData.length);
    
    NSData *originCompressionData;
    
    if (@available(iOS 13.0, *)) {
        originCompressionData = [originData compressedDataUsingAlgorithm:NSDataCompressionAlgorithmZlib error:nil];
    } else {
        originCompressionData = [CompressionTest compress:originData];
    }
    
    NSLog(@"%zd",originCompressionData.length);
    NSLog(@"---%@",originCompressionData);
    for (NSInteger i = 0; i < originCompressionData.length; i++) {
        NSData *data = [originCompressionData subdataWithRange:NSMakeRange(i, 1)];
        NSLog(@"%zd+++%@",i,data);
    }
    
//    NSString *nameStr = [NSString stringWithFormat:@"/%ld.dsc",[NSDate getNowTimestamp]];
//
//    [originCompressionData writeToFile:@"" atomically:YES];
    
}

+(NSData*) gzipData: (NSData*)pUncompressedData {
    if (!pUncompressedData || [pUncompressedData length] == 0)
    {
        NSLog(@"%s: Error: Can't compress an empty or null NSData object.", __func__);
        return nil;
    }
    int deflateStatus;
    float buffer = 1.1;
    do {
        z_stream zlibStreamStruct;
        zlibStreamStruct.zalloc = Z_NULL; // Set zalloc, zfree, and opaque to Z_NULL so
        zlibStreamStruct.zfree = Z_NULL; // that when we call deflateInit2 they will be
        zlibStreamStruct.opaque = Z_NULL; // updated to use default allocation functions.
        zlibStreamStruct.total_out = 0; // Total number of output bytes produced so far
        zlibStreamStruct.next_in = (Bytef*)[pUncompressedData bytes]; // Pointer to input bytes
        zlibStreamStruct.avail_in = (uInt)[pUncompressedData length]; // Number of input bytes left to process
        int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
        if (initError != Z_OK)
        {
            NSString *errorMsg = nil;
            switch (initError)
            {
                case Z_STREAM_ERROR:
                    errorMsg = @"Invalid parameter passed in to function.";
                    break;
                case Z_MEM_ERROR:
                    errorMsg = @"Insufficient memory.";
                    break;
                case Z_VERSION_ERROR:
                    errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                    break;
                default:
                    errorMsg = @"Unknown error code.";
                    break;
            }
            NSLog(@"%s: deflateInit2() Error: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
            return nil;
        }
        // Create output memory buffer for compressed data. The zlib documentation states that
        // destination buffer size must be at least 0.1% larger than avail_in plus 12 bytes.
        NSMutableData *compressedData = [NSMutableData dataWithLength:[pUncompressedData length] * buffer + 12];
        do {
            // Store location where next byte should be put in next_out
            zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
            // Calculate the amount of remaining free space in the output buffer
            // by subtracting the number of bytes that have been written so far
            // from the buffer's total capacity
            zlibStreamStruct.avail_out = (uInt)([compressedData length] - zlibStreamStruct.total_out);
            deflateStatus = deflate(&zlibStreamStruct, Z_FINISH);
        } while ( deflateStatus == Z_OK );
        if (deflateStatus == Z_BUF_ERROR && buffer < 32) {
            continue;
        }
        // Check for zlib error and convert code to usable error message if appropriate
        if (deflateStatus != Z_STREAM_END) {
            NSString *errorMsg = nil;
            switch (deflateStatus)
            {
                case Z_ERRNO:
                    errorMsg = @"Error occured while reading file.";
                    break;
                case Z_STREAM_ERROR:
                    errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
                    break;
                case Z_DATA_ERROR:
                    errorMsg = @"The deflate data was invalid or incomplete.";
                    break;
                case Z_MEM_ERROR:
                    errorMsg = @"Memory could not be allocated for processing.";
                    break;
                case Z_BUF_ERROR:
                    errorMsg = @"Ran out of output buffer for writing compressed bytes.";
                    break;
                case Z_VERSION_ERROR:
                    errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                    break;
                default:
                    errorMsg = @"Unknown error code.";
                    break;
            }
            NSLog(@"%s: zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
            // Free data structures that were dynamically created for the stream.
            deflateEnd(&zlibStreamStruct);
            return nil;
        }
        // Free data structures that were dynamically created for the stream.
        deflateEnd(&zlibStreamStruct);
        [compressedData setLength: zlibStreamStruct.total_out];
        return compressedData;
    } while ( false );
    return nil;
}

//- (void)testLZMA {
//    // Data source file path.
//    NSString *sourceFilePath = [NSString stringWithFormat:@"%@/source_data.txt", @""]; // Compressed file path.
//    NSString *zipFilePath = [NSString stringWithFormat:@"%@/compressed_data.7z", @""];
//    NSData *fileData = [NSData dataWithContentsOfFile:sourceFilePath];
//    NSLog(@"Before compress: %ld bytes", fileData.length);
//    uint8_t dstBuffer[fileData.length];
//    memset(dstBuffer, 0, fileData.length);
//    size_t compressResultLength = compression_encode_buffer(dstBuffer, fileData.length, [fileData bytes], fileData.length, NULL, COMPRESSION_LZMA);
//    if(compressResultLength > 0) {
//        NSData *dataAfterCompress = [NSData dataWithBytes:dstBuffer length:compressResultLength];
//        NSLog(@"Compress successfully. After compress：%ld bytes", dataAfterCompress.length;
//              // Write compressed data into file.
//              [dataAfterCompress writeToFile:zipFilePath atomically:YES];
//        
//        
//    } else {
//        DDLogError(@"Compress FAILED!!!");
//        
//    }
//    
//}
@end
