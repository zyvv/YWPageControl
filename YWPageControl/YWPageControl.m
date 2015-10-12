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
        
        [self addDeviceResultBlock];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加设备" message:@"选择成功或者失败" delegate:self cancelButtonTitle:@"成功" otherButtonTitles:@"失败", nil];
    [alertView show];
}


#pragma mark - YWDeviceStatePageViewDelegate 方法
- (NSString *)currentStateOfDeviceStatePageView:(YWDeviceStatePageView *)deviceStatePageView
{
    // =======点击当前设备的PageView的时候，更新当前设备的状态值=======
    // ===============================
#warning 当前设备状态值测试
    return [NSString stringWithFormat:@"%.0u", arc4random() % 100]; // 返回当前状态值
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

/**
 *  添加设备成功或者失败的回调
 */
- (void)addDeviceResultBlock
{
    __weak YWPageControl *weakSelf = self;
    self.addDeviceBlock = ^(BOOL isSuccess, NSDictionary *deviceInfomation, NSString *errorMessage) {
        
        __strong YWPageControl *strongSelf = weakSelf;
        if (isSuccess) {
            // 添加设备成功
            YWDeviceStatePageView *deviceStatePageView = [[YWDeviceStatePageView alloc] initWithFrame:CGRectMake(strongSelf -> pageViewsArray.count * strongSelf -> devicesScrollView.bounds.size.width, 0, strongSelf -> devicesScrollView.bounds.size.width, strongSelf -> devicesScrollView.bounds.size.width)];
            deviceStatePageView.delegate = strongSelf;
            // 设备的详细信息
            deviceStatePageView.name = [deviceInfomation objectForKey:@"name"];
            deviceStatePageView.macAddress = [deviceInfomation objectForKey:@"macAddress"];
            deviceStatePageView.ipAddress = [deviceInfomation objectForKey:@"ipAddress"];
            deviceStatePageView.deviceModel = [deviceInfomation objectForKey:@"deviceModel"];
            deviceStatePageView.state = [deviceInfomation objectForKey:@"state"];
            
            [strongSelf -> devicesScrollView addSubview:deviceStatePageView];
            [strongSelf -> pageViewsArray addObject:deviceStatePageView];
            [strongSelf reloadDevicesScrollView];
        } else {
            // 添加设备失败
            NSLog(@"addDeviceFailure, errorMessage: %@", errorMessage);
        }
    };
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

- (void)renameCurrentPageViewTitle:(NSString *)title
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

- (void)refreshCurrentPageViewState:(NSString *)state
{
    // 更新当前设备的状态
    if (pageViewsArray.count > 1 && pageControl.currentPage != 0) {
        YWDeviceStatePageView *currentView = [pageViewsArray objectAtIndex:pageControl.currentPage];
        if (currentView) {
            currentView.state = state;
        }
    } else {
        // 当前没有连接设备或者当前界面是添加新设备界面
    }
}

- (void)addDeviceSuccessWithDeviceInfomation:(NSDictionary *)info
{
    self.addDeviceBlock(YES, info, nil);
}

- (void)addDeviceFailureWithErrorMessage:(NSString *)msg
{
    self.addDeviceBlock(NO, nil, msg);
}


#warning 添加设备测试
#pragma mark - UIAlertViewDelegate 方法
// ======此处为假设成功或者失败
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 假设添加设备成功
        NSString *tempName = [NSString stringWithFormat:@"新设备%.0u", arc4random() % 100];
        NSString *tempState = [NSString stringWithFormat:@"%.0u", arc4random() % 100];
        NSDictionary *deviceInfomation = @{@"name": tempName,
                                           @"state": tempState,
                                           @"macAddress": [NSNumber numberWithLongLong:43423423432],
                                           @"ipAddress": @"10.10.1",
                                           @"deviceModel": [NSNumber numberWithInt:10]};
//        self.addDeviceBlock(YES, deviceInfomation, nil);
        [self addDeviceSuccessWithDeviceInfomation:deviceInfomation];
        
    } else {
        // 假设添加设备失败
        NSString *errorMessage = @"连接出错";
//        self.addDeviceBlock(NO, nil, errorMessage);
        [self addDeviceFailureWithErrorMessage:errorMessage];
    }
}

@end
