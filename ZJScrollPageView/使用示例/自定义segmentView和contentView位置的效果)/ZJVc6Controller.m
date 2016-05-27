//
//  ZJVc6Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc6Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
@interface ZJVc6Controller ()
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;
@end

@implementation ZJVc6Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegmentView];
    [self setupContentView];
    
}

- (void)setupSegmentView {
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showCover = YES;
    // 不要滚动标题, 每个标题将平分宽度
    style.scrollTitle = NO;
    // 渐变
    style.gradualChangeTitleColor = YES;
    // 遮盖背景颜色
    style.coverBackgroundColor = [UIColor whiteColor];
    //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.normalTitleColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = [UIColor colorWithRed:235.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    NSArray *titles = @[@"国内新闻", @"新闻头条"];
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 64.0, 160.0, 28.0) segmentStyle:style titles:titles titleDidClick:^(UILabel *label, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    // 自定义标题的样式
    segment.layer.cornerRadius = 14.0;
    segment.backgroundColor = [UIColor redColor];
    // 当然推荐直接设置背景图片的方式
//    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    self.navigationItem.titleView = self.segmentView;
    
}

- (void)setupContentView {
    
    NSArray *childVcs = [self setupChildVcAndTitle];
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) childVcs:childVcs segmentView:self.segmentView parentViewController:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
    
}

- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
    vc1.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc2, vc1, nil];
    return childVcs;
}

@end
