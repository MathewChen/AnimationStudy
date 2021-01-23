//
//  MXTableViewTest.m
//  AnimationStudy
//
//  Created by mingxing on 2021/1/22.
//  Copyright © 2021 dudian. All rights reserved.
//

#import "MXTableViewTestVC.h"

@interface MXTableViewTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@end

@implementation MXTableViewTestVC

- (void)didInitialize {
    [super didInitialize];
    
}

- (void)initSubviews {
    [super initSubviews];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView sizeToFit];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"-----");
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view.qmui_safeAreaInsets);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"我就试试-----%ld",indexPath.row];
    cell.textLabel.font = FUNC_FONT(16.f);
    
    cell.textLabel.textColor = UIColor.qmui_randomColor;
    cell.backgroundColor = [UIColor qmui_randomColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.f;
}
@end
