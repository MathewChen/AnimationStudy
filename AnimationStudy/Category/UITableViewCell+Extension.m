//
//  UITableViewCell+Extension.m
//  ZYOperation
//
//  Created by 唐伟明 on 2018/11/21.
//  Copyright © 2018年 唐伟明. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)


+(void)registerInTableView:(UITableView *)tableView{
    if ([self haveNib]) {
        UINib *nib = [UINib nibWithNibName:self.reID bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:self.reID];
    }else{
        [tableView registerClass:self.class forCellReuseIdentifier:self.reID];
    }
}


+(NSString *)reID{
    return NSStringFromClass(self.class);
}

+(BOOL)haveNib{
    NSString *path =   [[NSBundle mainBundle] pathForResource:self.reID ofType:@"nib"];
    return path&&path.length > 0;
}
@end
