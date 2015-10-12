//
//  YWPageControl.h
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWAddDevicePageView.h"
#import "YWDeviceStatePageView.h"

/**
 *  添加设备是否成功的回调Block
 *
 *  @param isSuccess        是否成功。成功：YES 失败：NO
 *  @param deviceInfomation 如果isSuccess=YES，该参数返回设备的信息字典，否则返回nil
 *  @param errorMessage      如果isSuccess=NO，该参数返回失败的信息，否则返回nil
 */
typedef void (^addDeviceBlock)(BOOL isSuccess, NSDictionary *deviceInfomation, NSString *errorMessage);

@interface YWPageControl : UIView<UIScrollViewDelegate, UIAlertViewDelegate, YWAddDevicePageViewDelegate, YWDeviceStatePageViewDelegate>

/**
 *  删除当前PageView
 */
- (void)deleteCurrentPageView;

/**
 *  重命名当前PageView的标题
 *
 *  @param title
 */
- (void)renameCurrentPageViewTitle:(NSString *)title;

/**
 *  更新当前PageView的状态
 *
 *  @param state 
 */
- (void)refreshCurrentPageViewState:(NSString *)state;

/**
 *  添加设备成功后调用
 *
 *  @param info 设备的信息
 */
- (void)addDeviceSuccessWithDeviceInfomation:(NSDictionary *)info;

/**
 *  添加设备失败后调用
 *
 *  @param msg 失败的信息
 */
- (void)addDeviceFailureWithErrorMessage:(NSString *)msg;

// 添加设备成功或者失败的回调
@property (nonatomic, copy)addDeviceBlock addDeviceBlock;

@end
