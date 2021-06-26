//
//  MXCalenderVC.m
//  AnimationStudy
//
//  Created by mingxing on 2020/11/4.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXCalenderVC.h"
#import <FSCalendar.h>
#import "MXCommonUI.h"
@interface MXCalenderVC ()<FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) NSCalendar *gregorian;

@end

@implementation MXCalenderVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar";
        self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 100, view.frame.size.width, height)];
    
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    //标题大小
    calendar.appearance.headerTitleFont = [UIFont systemFontOfSize:14];
    //标题颜色
    calendar.appearance.headerTitleColor = UIColor.redColor;
    //title格式
    calendar.appearance.headerDateFormat = @"YYYY年MM月";
    
    //星期背景色
    calendar.calendarWeekdayView.backgroundColor = [UIColor yellowColor];
    //星期字体颜色
    calendar.appearance.weekdayTextColor = [UIColor greenColor];
    
    //今天的字体颜色
    calendar.appearance.titleTodayColor = [UIColor whiteColor];
    //今天的选中颜色
    calendar.appearance.todayColor = [UIColor blackColor];
    
    //今天的选中颜色
    calendar.appearance.selectionColor = [UIColor redColor];
    
    calendar.appearance.titleDefaultColor = UIColor.qmui_randomColor;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 100+5, 95, 34);
    previousButton.backgroundColor = [UIColor redColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 100+5, 95, 34);
    nextButton.backgroundColor = [UIColor redColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    nextButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [nextButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
    QMUIButton *button = [[QMUIButton alloc] init];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(calendar.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    button.backgroundColor = UIColor.qmui_randomColor;
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton {
    
    CGFloat height = SCREEN_WIDTH * 320 / 375 + SAFE_BOTTOM;
    
    CGFloat clenderHeight = SCREEN_WIDTH * 284 / 375;
    
    CGFloat topHeight = FUNC_W(16);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, height)];
    contentView.backgroundColor = UIColor.whiteColor;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((contentView.qmui_width - 32) / 2, 8, 32, 4)];
    lineView.backgroundColor = UIColor.blackColor;
    lineView.layer.cornerRadius = 2.f;
    [contentView addSubview:lineView];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, topHeight, SCREEN_WIDTH, clenderHeight)];
    
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    [contentView addSubview:calendar];
    self.calendar = calendar;
    
    //标题大小
    calendar.appearance.headerTitleFont = [UIFont systemFontOfSize:14];
    //标题颜色
    calendar.appearance.headerTitleColor = UIColor.redColor;
    //title格式
    calendar.appearance.headerDateFormat = @"YYYY年MM月";
    
    //星期背景色
    calendar.calendarWeekdayView.backgroundColor = [UIColor yellowColor];
    //星期字体颜色
    calendar.appearance.weekdayTextColor = [UIColor greenColor];
    
    //今天的字体颜色
    calendar.appearance.titleTodayColor = [UIColor whiteColor];
    //今天的选中颜色
    calendar.appearance.todayColor = [UIColor blueColor];
    
    //今天的选中颜色
    calendar.appearance.selectionColor = [UIColor redColor];
    
    calendar.appearance.titleDefaultColor = UIColor.qmui_randomColor;
    
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    
    calendar.weekdayHeight = 32.f;
    calendar.headerHeight = 36.f;
    
    contentView.layer.cornerRadius = 16.f;
    contentView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    
    QMUIButton *previousButton = [[QMUIButton alloc] init];
    previousButton.frame = CGRectMake(0, topHeight + 5, 95, 34);
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:previousButton];
    previousButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
    QMUIButton *nextButton = [[QMUIButton alloc] init];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, topHeight + 5, 95, 34);
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextButton];
    nextButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    
//    [self.view addSubview:contentView];
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    modalViewController.contentView = contentView;
    modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        contentView.qmui_frameApplyTransform = CGRectSetXY(CGRectMake(contentView.qmui_left, contentView.qmui_top, SCREEN_WIDTH, height), 0, SCREEN_HEIGHT - height);
    };
    [modalViewController showWithAnimated:YES completion:nil];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSLog(@"-----");
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}


@end
