//
//  NSString+Extension.m
//  DongLaiShun
//
//  Created by 唐伟明 on 2017/11/20.
//  Copyright © 2017年 唐伟明. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
-(NSString *)decimalStyle{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    CGFloat dnum = [self doubleValue];
    if (fabs(dnum) > 1) {
        nf.maximumFractionDigits = 2;
    }else if(dnum > 0) {
        for (int i = 1; i < 100; i++) {
            CGFloat temp = dnum * (int)pow(10,i);
            if (temp > 1) {
                nf.maximumFractionDigits = i+1;
                break;
            }
        }
    }
    NSNumber *num = @(dnum);
    NSString *str = [nf stringFromNumber:num];
    
  
//    for (int i = 3; i<6; i++) {
//        if (![str doubleValue]) {
//            nf.maximumFractionDigits = i;
//            dnum = [str doubleValue];
//            num = @(dnum);
//            str = [nf stringFromNumber:num];
//        }else{
//            break;
//        }
//    }
    
    return str;
}
-(NSString *)noStyle{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = kCFNumberFormatterNoStyle;
    nf.minimumFractionDigits = 0;
    nf.minimumIntegerDigits =  1;
    nf.maximumFractionDigits = 6;
    NSNumber *num = @([self doubleValue]);
    return [nf stringFromNumber:num];
}


- (CGFloat)calculateRowHeightFontSize:(NSInteger)fontSize width:(CGFloat)width{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}


-(CGFloat)calculateRowWidthFontSize:(NSUInteger)fontSize height:(CGFloat)height{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    /*计算宽度要先指定高度*/
      CGRect rect = [self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
      return rect.size.width;
}

/**
 *转换成拼音
 */
- (NSString *)transformToPinyin
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",self];
    return allString;
}


/**
 *全拼音
 */
- (NSString *)pinYin
{
    
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return pinYin;
}

/**
 *首字母
 */
- (NSString *)initial
{
    
    NSString *pinYin = [self pinYin];
    return [pinYin substringToIndex:1];
}


/**
 *转表情
 */
- (NSString *)transformToEmoji{
    NSString *uniStr = [NSString stringWithUTF8String:[self UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    return goodStr;
}
/**
 *表情转字符串
 */
- (NSString *)emojiTransformToString{
    const char *jsonString = [self UTF8String];   // goodStr 服务器返回的 json
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *goodMsg = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    if (!goodMsg) {
        goodMsg = self;
    }
    return goodMsg;
}

/**
 *设置行间距
 */
-(NSAttributedString *)setLineSpacing:(CGFloat)spacing{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    NSAttributedString *astr = [[NSAttributedString alloc] initWithString:self attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    return astr;
}


/**
 *前面添加¥
 */
-(NSString *)addPrefixRMB{
    NSString *str = self.length>0?self:@"0";
    return [NSString stringWithFormat:@"¥%@",str];
}

/**
 *后面添加元
 */
-(NSString *)addsuffixRMB{
    NSString *str = self.length>0?self:@"0";
    return [NSString stringWithFormat:@"%@元",str];
}

/**
 *MD5加密
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


//转换格式化金额
- (NSString *)moneyStr{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    
    return money;
}

//去掉左右空格
-(NSString *)ltrimAndRtrim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


//取第一节字符串
-(NSString *)firstString{
    if ([self containsString:@","]) {
        return [self componentsSeparatedByString:@","].firstObject;
    }else{
        return self;
    }
    
}

@end
