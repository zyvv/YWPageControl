//
//  YWAddDevicePageView.h
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWAddDevicePageViewDelegate <NSObject>

@optional
/**
 *  开始添加设备
 */
- (void)beginAddDevice;

@end

@interface YWAddDevicePageView : UIView

@property (nonatomic, assign) id<YWAddDevicePageViewDelegate>delegate;

@end
