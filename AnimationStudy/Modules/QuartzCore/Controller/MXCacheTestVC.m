//
//  MXCacheTestVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/8/11.
//  Copyright © 2020 Star. All rights reserved.
//

/*
 参考文档：
 https://www.cnblogs.com/whoislcj/p/6429108.html
 https://www.jianshu.com/p/0e8d123e9126
 https://juejin.im/post/6856665902655078407
 */
#import "MXCacheTestVC.h"
#import <YYKit.h>

#import "MXCacheTestModel.h"
@interface MXCacheTestVC ()

@property(nonatomic, strong) UIImageView *testImageView;

@property(nonatomic, strong) UIImageView *testImageView2;

@end

@implementation MXCacheTestVC


- (void)didInitialize {
    [super didInitialize];
    self.view.backgroundColor = [UIColor whiteColor];
    
    QMUIButton *cacheBuild = [[QMUIButton alloc] initWithFrame:CGRectMake(16, TOP_HEIGHT + 16, 150, 40)];
    cacheBuild.backgroundColor = UIColor.qmui_randomColor;
    [cacheBuild setTitle:@"创建缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheBuild];
    [cacheBuild addTarget:self action:@selector(clickcacheBuild) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *cacheRead = [[QMUIButton alloc] initWithFrame:CGRectMake(cacheBuild.sh_right + 32, TOP_HEIGHT + 16, 150, 40)];
    cacheRead.backgroundColor = UIColor.qmui_randomColor;
    [cacheRead setTitle:@"读取缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheRead];
    [cacheRead addTarget:self action:@selector(clickcacheRead) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *cacheArrayBuild = [[QMUIButton alloc] initWithFrame:CGRectMake(16, cacheBuild.sh_bottom + 16, 150, 40)];
    cacheArrayBuild.backgroundColor = UIColor.qmui_randomColor;
    [cacheArrayBuild setTitle:@"创建数组缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheArrayBuild];
    [cacheArrayBuild addTarget:self action:@selector(clickArraycacheBuild) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *cacheArrayRead = [[QMUIButton alloc] initWithFrame:CGRectMake(cacheArrayBuild.sh_right + 32, cacheRead.sh_bottom + 16, 150, 40)];
    cacheArrayRead.backgroundColor = UIColor.qmui_randomColor;
    [cacheArrayRead setTitle:@"读取数组缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheArrayRead];
    [cacheArrayRead addTarget:self action:@selector(clickArraycacheRead) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *cacheChangeBuild = [[QMUIButton alloc] initWithFrame:CGRectMake(16, cacheArrayBuild.sh_bottom + 16, 150, 40)];
    cacheChangeBuild.backgroundColor = UIColor.qmui_randomColor;
    [cacheChangeBuild setTitle:@"创建修改缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheChangeBuild];
    [cacheChangeBuild addTarget:self action:@selector(clickModelChangeCacheBuild) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *cacheChangeRead = [[QMUIButton alloc] initWithFrame:CGRectMake(cacheBuild.sh_right + 32, cacheArrayRead.sh_bottom + 16, 150, 40)];
    cacheChangeRead.backgroundColor = UIColor.qmui_randomColor;
    [cacheChangeRead setTitle:@"读取修改缓存" forState:UIControlStateNormal];
    [self.view addSubview:cacheChangeRead];
    [cacheChangeRead addTarget:self action:@selector(clickModelChangeCacheRead) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, cacheChangeBuild.sh_bottom + 16, 100, 100)];
    testImageView.backgroundColor = UIColor.qmui_randomColor;
    testImageView.image = [UIImage imageNamed:@"empty_login"];
    [self.view addSubview:testImageView];

    UIImageView *testImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(testImageView.sh_right + 32, cacheChangeBuild.sh_bottom + 16, 100, 100)];
    testImageView2.backgroundColor = UIColor.qmui_randomColor;
    [self.view addSubview:testImageView2];
    
    self.testImageView = testImageView;
    self.testImageView2 = testImageView2;
//    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
//    [yyCache.memoryCache setCountLimit:50];//内存最大缓存数据个数
//    [yyCache.memoryCache setCostLimit:1*1024];//内存最大缓存开销 目前这个毫无用处
//    [yyCache.diskCache setCostLimit:10*1024];//磁盘最大缓存开销
//    [yyCache.diskCache setCountLimit:50];//磁盘最大缓存数据个数
//    [yyCache.diskCache setAutoTrimInterval:60];//设置磁盘lru动态清理频率 默认 60秒
//
//    for(int i=0 ;i<150;i++){
//        //模拟数据
//        NSString *value=@"I want to know who is lcj ?";
//        //模拟一个key
//        NSString *key=[NSString stringWithFormat:@"key%d",i];
//        [yyCache setObject:value forKey:key];
//    }
//
//    NSLog(@"yyCache.memoryCache.totalCost:%lu",(unsigned long)yyCache.memoryCache.totalCost);
//    NSLog(@"yyCache.memoryCache.costLimit:%lu",(unsigned long)yyCache.memoryCache.costLimit);
//
//    NSLog(@"yyCache.memoryCache.totalCount:%lu",(unsigned long)yyCache.memoryCache.totalCount);
//    NSLog(@"yyCache.memoryCache.countLimit:%lu",(unsigned long)yyCache.memoryCache.countLimit);
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        NSLog(@"yyCache.diskCache.totalCost:%lu",(unsigned long)yyCache.diskCache.totalCost);
//        NSLog(@"yyCache.diskCache.costLimit:%lu",(unsigned long)yyCache.diskCache.costLimit);
//
//        NSLog(@"yyCache.diskCache.totalCount:%lu",(unsigned long)yyCache.diskCache.totalCount);
//        NSLog(@"yyCache.diskCache.countLimit:%lu",(unsigned long)yyCache.diskCache.countLimit);
//
//        for(int i=0 ;i<150;i++){
//            //模拟一个key
//            NSString *key=[NSString stringWithFormat:@"whoislcj%d",i];
//            id vuale=[yyCache objectForKey:key];
//            NSLog(@"key ：%@ value : %@",key ,vuale);
//        }
//
//    });

}

#pragma mark - model数据缓存

/// 创建缓存
- (void)clickcacheBuild {
    MXCacheTestModel *model = [[MXCacheTestModel alloc] init];
    model.title = @"测试";
    model.des = @"这就是测试数据";
    model.age = 30;
    model.changeTime = 1597138071;
    model.testImage = [UIImage imageNamed:@"empty_login"];
    YYCache *yyCache=[YYCache cacheWithName:@"MXCache"];

    [yyCache setObject:model forKey:@"cacheTest"];
}

/// 读取缓存
- (void)clickcacheRead {
    YYCache *yyCache=[YYCache cacheWithName:@"MXCache"];

    MXCacheTestModel *model = (MXCacheTestModel *)[yyCache objectForKey:@"cacheTest"];
    self.testImageView2.image = model.testImage;
    NSLog(@"%@",model.title);
}

#pragma mark - 数组数据缓存

/// 创建缓存
- (void)clickArraycacheBuild {
    
    MXCacheTestModel *model = [[MXCacheTestModel alloc] init];
    model.title = @"测试";
    model.des = @"这就是测试数据";
    model.age = 30;
    model.changeTime = 1597138071;
    
    MXCacheTestModel *model2 = [[MXCacheTestModel alloc] init];
    model2.title = @"测试2";
    model2.des = @"这就是测试数据2";
    model2.age = 31;
    model2.changeTime = 1597198071;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:model];
    [array addObject:model2];
    
    YYCache *yyCache=[YYCache cacheWithName:@"MXArraycache"];
    
    [yyCache setObject:array forKey:@"arrayTest"];
}

/// 读取缓存
- (void)clickArraycacheRead {
    
    YYCache *yyCache=[YYCache cacheWithName:@"MXArraycache"];
    
    NSMutableArray *modelArray = (NSMutableArray *)[yyCache objectForKey:@"arrayTest"];
    
    NSLog(@"%zd",modelArray.count);
}

#pragma mark - 多数据缓存

/// 创建缓存
- (void)clickModelChangeCacheBuild {
    
    YYCache *yyCache=[YYCache cacheWithName:@"MXModelChangecache"];
    
    MXCacheTestModel *model = [[MXCacheTestModel alloc] init];
    model.title = @"测试";
    model.des = @"这就是测试数据";
    model.age = 30;
    model.changeTime = 1597138071;
    [yyCache setObject:model forKey:@"测试"];
    
    MXCacheTestModel *model2 = [[MXCacheTestModel alloc] init];
    model2.title = @"测试2";
    model2.des = @"这就是测试数据2";
    model2.age = 31;
    model2.changeTime = 1597198071;
    [yyCache setObject:model2 forKey:@"测试2"];
    
}

/// 读取缓存
- (void)clickModelChangeCacheRead {
    
    YYCache *yyCache=[YYCache cacheWithName:@"MXModelChangecache"];
    
    MXCacheTestModel *model = (MXCacheTestModel *)[yyCache objectForKey:@"测试2"];
    
    NSLog(@"%@",model.title);
}
@end
