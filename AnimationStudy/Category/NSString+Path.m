//
//  NSString+Path.m
//  APPDEMO
//
//  Created by WindyCheng on 2017/6/20.
//  Copyright © 2017年 suhang. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
//沙盒路径
+(NSString*)homePath{
    return NSHomeDirectory();
}

//文档路径
+(NSString*)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

//文档路径扩展
+(NSString*)documentPathAppendingPathComponent:(NSString *)subPath{
    NSString *path = [[self documentPath] stringByAppendingPathComponent:subPath];
    return path;
}

//资源库路径
+(NSString*)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

//缓存路径
+(NSString*)cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}
@end
