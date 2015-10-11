//
//  YWAddDevicePageView.m
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import "YWAddDevicePageView.h"

#define ywLineWidth 5
#define ywRadius (MIN(self.bounds.size.width, self.bounds.size.height) / 2 - ywLineWidth)
#define ywFontSize 14

@implementation YWAddDevicePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(beginAddDevice)]) {
        [self.delegate beginAddDevice];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, ywRadius, 0, M_PI * 2, 1);
    CGContextSetLineWidth(context, ywLineWidth);
    [[UIColor whiteColor] set];
    CGContextDrawPath(context, kCGPathStroke);
    
    NSString *text = @"添加设备";
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:ywFontSize]}];
    CGFloat textY = sqrt((pow(ywRadius, 2) - pow(textSize.width / 2, 2)))  - textSize.height + ywRadius - 10;
    CGRect textRect = CGRectMake((self.bounds.size.width - textSize.width) / 2, textY, textSize.width, textSize.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [text drawInRect:textRect withAttributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: [UIFont boldSystemFontOfSize:ywFontSize], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [[UIColor whiteColor] setStroke];
    CGFloat margin = ywRadius - sqrt((pow(ywRadius, 2) - pow(textSize.width / 2, 2)));
    CGFloat addLength = MAX(10, ywRadius - textSize.height - margin);
    
    UIRectFrame(CGRectMake((self.bounds.size.width - ywLineWidth) / 2, (self.bounds.size.width - addLength) / 2, ywLineWidth, addLength));
    UIRectFrame(CGRectMake((self.bounds.size.width - addLength) / 2, (self.bounds.size.width - ywLineWidth) / 2, addLength, ywLineWidth));
}

@end