//
//  UICollectionViewCell+Extension.m
//  ZYOperation
//
//  Created by 唐伟明 on 2018/11/21.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "UICollectionViewCell+Extension.h"

@implementation UICollectionViewCell (Extension)

+(void)registerInCollectionView:(UICollectionView *)collectionView{
    
    NSString *path =   [[NSBundle mainBundle] pathForResource:self.reID ofType:@"nib"];
    if (path&&path.length > 0) {
        UINib *nib = [UINib nibWithNibName:self.reID bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:self.reID];
        
    }else{
        [collectionView registerClass:[self class] forCellWithReuseIdentifier:self.reID];
    }
}
+(NSString *)reID{
    return NSStringFromClass(self.class);
}
@end
