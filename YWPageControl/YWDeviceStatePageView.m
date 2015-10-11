//
//  YWDeviceStateView.m
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import "YWDeviceStatePageView.h"


#define ywLineWidth 5  
#define ywRadius (MIN(self.bounds.size.width, self.bounds.size.height) / 2 - ywLineWidth)
#define ywNameFontSize 14 // 设备名称字体大小
#define ywStateFontSize 25 // 设备状态字体大小

@implementation YWDeviceStatePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        _name = @"新设备";
        _state = @"0";
    }
    return self;
}

- (void)setState:(NSString *)state
{
    if (_state != state) {
        _state = state;
    }
    [self setNeedsDisplay];
}


- (void)setName:(NSString *)name
{
    if (_name != name) {
        _name = name;
    }
    [self setNeedsDisplay];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(currentStateOfDeviceStatePageView:)]) {
        self.state = [self.delegate currentStateOfDeviceStatePageView:self];
    }
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, ywRadius, 0, M_PI * 2, 1);
    CGContextSetLineWidth(context, ywLineWidth);
    [[UIColor whiteColor] set];
    CGContextDrawPath(context, kCGPathStroke);
    
    CGSize textSize = [_name sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:ywNameFontSize]}];
    CGFloat textY = sqrt((pow(ywRadius, 2) - pow(textSize.width / 2, 2)))  - textSize.height + ywRadius - 10;
    CGRect textRect = CGRectMake((self.bounds.size.width - textSize.width) / 2, textY, textSize.width, textSize.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [_name drawInRect:textRect withAttributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: [UIFont boldSystemFontOfSize:ywNameFontSize], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    CGSize tempSize = [_state sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:ywStateFontSize]}];
    CGRect tempRect = CGRectMake((self.bounds.size.width - tempSize.width) / 2, (self.bounds.size.width - tempSize.height) / 2, tempSize.width, tempSize.height);
    NSMutableParagraphStyle *tempParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    tempParagraphStyle.alignment = NSTextAlignmentCenter;
    [_state drawInRect:tempRect withAttributes:@{NSParagraphStyleAttributeName: tempParagraphStyle, NSFontAttributeName: [UIFont boldSystemFontOfSize:ywStateFontSize], NSForegroundColorAttributeName: [UIColor whiteColor]}];

}


@end
