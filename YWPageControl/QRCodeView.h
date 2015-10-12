//
//  QRCodeView.h
//  YWPageControl
//
//  Created by 张洋威 on 15/10/13.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加设备是否成功的回调Block
 *
 *  @param isSuccess        是否成功。成功：YES 失败：NO
 *  @param deviceInfomation 如果isSuccess=YES，该参数返回设备的信息字典，否则返回nil
 *  @param errorMessage      如果isSuccess=NO，该参数返回失败的信息，否则返回nil
 */
typedef void (^addDeviceBlock)(BOOL isSuccess, NSDictionary *deviceInfomation, NSString *errorMessage);

@interface QRCodeView : UIView

// 添加设备成功或者失败的结果回调方法
- (void)addDeviceResultBlock:(addDeviceBlock)addDeviceBlock;


@end
