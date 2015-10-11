//
//  YWDeviceStateView.h
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YWDeviceStatePageView;

@protocol YWDeviceStatePageViewDelegate <NSObject>

@optional

/**
 *  设置当前deviceStatePageView的状态值
 *
 *  @param deviceStatePageView
 *
 *  @return 状态值
 */
- (NSString *)currentStateOfDeviceStatePageView:(YWDeviceStatePageView *)deviceStatePageView;

@end

@interface YWDeviceStatePageView : UIView

@property (nonatomic, copy) NSString *state; // 状态值

@property (nonatomic, copy) NSString *name; // 设备名称

@property (nonatomic, assign) id<YWDeviceStatePageViewDelegate>delegate;
@end
