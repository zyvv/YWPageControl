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
@interface YWPageControl : UIView<UIScrollViewDelegate, YWAddDevicePageViewDelegate, YWDeviceStatePageViewDelegate>

/**
 *  删除当前PageView
 */
- (void)deleteCurrentPageView;

/**
 *  重命名当前PageView的标题
 *
 *  @param title
 */
- (void)renameCurrentPageViewTitleWithTitle:(NSString *)title;

@end
