//
//  CompressionTest.m
//  AnimationStudy
//
//  Created by mingxing on 2021/6/10.
//  Copyright © 2021 Star. All rights reserved.
//

#import "CompressionTest.h"
#include <zlib.h>

#define CHUNK 16384

@implementation CompressionTest

/**
 Deflate 压缩
 @param data 需要压缩的数据
 @return 返回压缩数据
 */
+ (NSData *)compress:(NSData *)data {
    
    if ([data length] == 0) return data;
    // 初始化 z_stream
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.total_out = 0;
    stream.next_in = (Bytef *)[data bytes];
    stream.avail_in = (int)[data length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&stream,
                     Z_DEFAULT_COMPRESSION,
                     Z_DEFLATED,
                     -15,
                     MAX_MEM_LEVEL,
                     Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    NSMutableData * compressed = [NSMutableData dataWithLength: CHUNK];
    do {
        if (stream.total_out >= [compressed length])
            // 追加长度
            [compressed increaseLengthBy:CHUNK];
        stream.next_out = [compressed mutableBytes] + stream.total_out;
        stream.avail_out = (uint)[compressed length] - (uint)stream.total_out;
        deflate(&stream, Z_FINISH);
        
    } while (stream.avail_out == 0);
    deflateEnd(&stream);
    [compressed setLength: stream.total_out];
    return [NSData dataWithData:compressed];
}


/**
 Deflate 解压缩

 @param data 需要解压数据
 @return 已经解压的数据
 */
+ (NSData *)decompress:(NSData *)data {
    
    if ([data length] == 0) return data;
    // 初始化 z_stream
    z_stream strm;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (int)[data length];

    unsigned full_length = (int)[data length];
    unsigned half_length = (int)[data length] / 2;
    NSMutableData * decompressed = [[NSMutableData alloc]
                                    initWithLength: full_length + half_length];
    BOOL done = false;
    int status;
    
    if (inflateInit2(&strm, -15) != Z_OK) return nil;
    while (!done) {
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uint)[decompressed length] - (uint)strm.total_out;
        
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END)
            done = YES;
        else if (status != Z_OK)
            break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData:decompressed];
    }
    return nil;
}

@end
