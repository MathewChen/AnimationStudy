
#import <Foundation/Foundation.h>

@interface NSString (Path)
//沙盒路径
+(NSString*)homePath;

//文档路径
+(NSString*)documentPath;

//文档路径扩展
+(NSString*)documentPathAppendingPathComponent:(NSString *)subPath;

///资源库路径
+(NSString*)libraryPath;

//缓存路径
+(NSString*)cachePath;

@end
