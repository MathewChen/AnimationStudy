//
//  UILabel+factory.h
//  DLabel
//
//  Created by 唐伟明 on 2019/6/14.
//  Copyright © 2019 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (factory)
+(instancetype)labelWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
