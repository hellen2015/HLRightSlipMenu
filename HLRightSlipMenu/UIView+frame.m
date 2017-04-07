//
//  UIView+frame.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/7.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
- (void)setShl_x:(CGFloat)shl_x
{
    CGRect frame = self.frame;
    frame.origin.x = shl_x;
    self.frame = frame;
}

- (void)setShl_y:(CGFloat)shl_y
{
    CGRect frame = self.frame;
    frame.origin.y = shl_y;
    self.frame = frame;
}

- (void)setShl_width:(CGFloat)shl_width
{
    CGRect frame = self.frame;
    frame.size.width = shl_width;
    self.frame = frame;
}

- (void)setShl_height:(CGFloat)shl_height
{
    CGRect frame = self.frame;
    frame.size.height = shl_height;
    self.frame = frame;
}

- (CGFloat)shl_x
{
    return self.frame.origin.x;
}

- (CGFloat)shl_y
{
    return self.frame.origin.y;
}
- (CGFloat)shl_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setShl_bottom:(CGFloat)shl_bottom {
    CGRect frame = self.frame;
    frame.origin.y = shl_bottom - frame.size.height;
    self.frame = frame;
}
- (void)setShl_top:(CGFloat)shl_top {
    CGRect frame = self.frame;
    frame.origin.y = shl_top;
    self.frame = frame;
}
- (CGFloat)shl_top {
    return self.frame.origin.y;
}
- (CGFloat)shl_width
{
    return self.frame.size.width;
}

- (CGFloat)shl_height
{
    return self.frame.size.height;
}

- (void)setShl_centerX:(CGFloat)shl_centerX
{
    CGPoint center = self.center;
    center.x = shl_centerX;
    self.center = center;
}

- (void)setShl_centerY:(CGFloat)shl_centerY
{
    CGPoint center = self.center;
    center.y = shl_centerY;
    self.center = center;
}

- (CGFloat)shl_centerX
{
    return self.center.x;
}

- (CGFloat)shl_centerY
{
    return self.center.y;
}
@end
