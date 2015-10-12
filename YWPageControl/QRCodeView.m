//
//  QRCodeView.m
//  YWPageControl
//
//  Created by 张洋威 on 15/10/13.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import "QRCodeView.h"

@interface QRCodeView()

// 添加设备成功或者失败的回调
@property (nonatomic, copy)addDeviceBlock addDeviceBlock;

@end

@implementation QRCodeView
{
    __weak IBOutlet UILabel *errorMessageLabel;
    
}

#warning 假设扫描二维码按钮动作
/**
 *  假设成功按钮动作
 *
 *  @param sender
 */
- (IBAction)successButtonAction:(UIButton *)sender {
    // 假设添加设备成功
    NSString *tempName = [NSString stringWithFormat:@"新设备%.0u", arc4random() % 100];
    NSString *tempState = [NSString stringWithFormat:@"%.0u", arc4random() % 100];
    NSDictionary *deviceInfomation = @{@"name": tempName,
                                       @"state": tempState,
                                       @"macAddress": [NSNumber numberWithLongLong:43423423432],
                                       @"ipAddress": @"10.10.1",
                                       @"deviceModel": [NSNumber numberWithInt:10]};
    if (_addDeviceBlock) {
        _addDeviceBlock(YES, deviceInfomation, nil);
        [self removeFromSuperview];
    }
   
}

/**
 *  假设失败按钮动作
 *
 *  @param sender
 */
- (IBAction)failureButtonAction:(UIButton *)sender {
    // 假设添加设备失败
    NSString *errorMessage = @"连接出错";
    if (_addDeviceBlock) {
        _addDeviceBlock(NO, nil, errorMessage);
        errorMessageLabel.text = errorMessage;
    }
}


#pragma mark - 公开方法
- (void)addDeviceResultBlock:(addDeviceBlock)addDeviceBlock
{
    if (addDeviceBlock) {
        _addDeviceBlock = addDeviceBlock;
    }
}


@end
