//
//  UIView+frame.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/7.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
- (void)setX:(CGFloat )originX
{
    CGRect rect = self.frame;
    
    rect.origin.x = originX;
    
    self.frame = rect;
}
@end
