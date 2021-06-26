//
//  DLFillPrintListView.m
//  AnimationStudy
//
//  Created by mingxing on 2020/10/9.
//  Copyright © 2020 Star. All rights reserved.
//

#import "DLFillPrintListView.h"

@interface DLFillPrintListView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *fillListTableView;

@end

@implementation DLFillPrintListView

- (void)levelTypeDidChange:(CGFloat)bottomOperateViewHeight {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.fillListTableView.qmui_height = bottomOperateViewHeight;
        
    } completion:^(BOOL finished) {
        NSLog(@"do something");
    }];
    
}

- (void)buildUI {
    [super buildUI];
    
    self.maxY = SCREEN_HEIGHT - 48 - 50;
    
    [self createTableView];
}

- (void)createTableView {
    _fillListTableView = [[UITableView alloc] init];
    _fillListTableView.delegate = self;
    _fillListTableView.dataSource = self;
    _fillListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomOperateView addSubview:_fillListTableView];
    [_fillListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_fillListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"-----%ld",indexPath.row];
    cell.textLabel.font = FUNC_FONT(16.f);
    
    cell.textLabel.textColor = [UIColor colorWithHexString:@"0497FF"];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

@end
