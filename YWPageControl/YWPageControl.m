//
//  YWPageControl.m
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import "YWPageControl.h"

@implementation YWPageControl
{
    UIPageControl *pageControl;
    UIScrollView *devicesScrollView;
    NSMutableArray *pageViewsArray; // 设备界面数组（包括添加设备界面）
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pageViewsArray = [NSMutableArray array];
        [self loadDevicesScrollView];
        [self loadPageControl];
    }
    return self;
}

#pragma mark - 视图加载
- (void)loadPageControl
{
    if (!pageControl) {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
        pageControl.numberOfPages = 1;
        [self addSubview:pageControl];
    }
}

- (void)loadDevicesScrollView
{
    if (!devicesScrollView) {
        devicesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width)];
        devicesScrollView.pagingEnabled = YES;
        devicesScrollView.showsHorizontalScrollIndicator = NO;
        devicesScrollView.showsVerticalScrollIndicator = NO;
        devicesScrollView.delegate = self;
        [self addSubview:devicesScrollView];
        
        YWAddDevicePageView *addDevicePageView = [[YWAddDevicePageView alloc] initWithFrame:devicesScrollView.bounds];
        addDevicePageView.delegate = self;
        [devicesScrollView addSubview:addDevicePageView];
        [pageViewsArray addObject:addDevicePageView];
    }
}

#pragma mark - YWAddDevicePageViewDelegate 方法
- (void)beginAddDevice
{
    // =======跳转到扫描二维码页面=======
    // ===============================
#warning 添加设备测试
    // 添加设备
    YWDeviceStatePageView *deviceStatePageView = [[YWDeviceStatePageView alloc] initWithFrame:CGRectMake(pageViewsArray.count * devicesScrollView.bounds.size.width, 0, devicesScrollView.bounds.size.width, devicesScrollView.bounds.size.width)];
    deviceStatePageView.delegate = self;
//    deviceStatePageView.backgroundColor = [UIColor clearColor];
    [devicesScrollView addSubview:deviceStatePageView];
    [pageViewsArray addObject:deviceStatePageView];
    [self reloadDevicesScrollView];
}


#pragma mark - YWDeviceStatePageViewDelegate 方法
- (NSString *)currentStateOfDeviceStatePageView:(YWDeviceStatePageView *)deviceStatePageView
{
    // =======更新当前设备的状态值=======
    // ===============================
#warning 当前设备状态值测试
    return @"33"; // 返回当前状态值
}

#pragma mark - UIScrollViewDelegate 方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == devicesScrollView) {
        pageControl.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    }
}

#pragma mark - 私有方法
- (void)reloadDevicesScrollView
{
    devicesScrollView.contentSize = CGSizeMake(devicesScrollView.bounds.size.width * pageViewsArray.count, devicesScrollView.bounds.size.width);
    pageControl.numberOfPages = pageViewsArray.count;
    pageControl.currentPage = pageViewsArray.count;
    [devicesScrollView setContentOffset:CGPointMake(devicesScrollView.bounds.size.width * (pageViewsArray.count - 1), 0) animated:YES];
}

- (void)reloadDevicesScrollViewAtPage:(NSInteger)page
{
    devicesScrollView.contentSize = CGSizeMake(devicesScrollView.bounds.size.width * pageViewsArray.count, devicesScrollView.bounds.size.width);
    pageControl.numberOfPages = pageViewsArray.count;
    pageControl.currentPage = page;
    [devicesScrollView setContentOffset:CGPointMake(devicesScrollView.bounds.size.width * page, 0) animated:YES];
    for (int i=1; i<pageViewsArray.count; i++) {
        YWDeviceStatePageView *tempView = [pageViewsArray objectAtIndex:i];
        tempView.frame = CGRectMake(i*devicesScrollView.bounds.size.width, tempView.frame.origin.y, tempView.frame.size.width, tempView.frame.size.height);
    }
}

#pragma mark - 公开方法
- (void)deleteCurrentPageView
{
    // 删除当前设备
    if (pageViewsArray.count > 1 && pageControl.currentPage != 0) {
        YWDeviceStatePageView *removedView = [pageViewsArray objectAtIndex:pageControl.currentPage];
        if (removedView) {
            [removedView removeFromSuperview];
        }
        [pageViewsArray removeObjectAtIndex:pageControl.currentPage];
        [self reloadDevicesScrollViewAtPage:pageControl.currentPage - 1];
    } else {
        // 当前没有连接设备或者当前界面是添加新设备界面
    }
    
}

- (void)renameCurrentPageViewTitleWithTitle:(NSString *)title
{
    // 重命名当前设备
    if (pageViewsArray.count > 1 && pageControl.currentPage != 0) {
        YWDeviceStatePageView *currentView = [pageViewsArray objectAtIndex:pageControl.currentPage];
        if (currentView) {
           currentView.name = title;
        }
    } else {
        // 当前没有连接设备或者当前界面是添加新设备界面
    }

}

@end
