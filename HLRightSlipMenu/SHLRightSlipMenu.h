//
//  SHLRightSlipMenu.h
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SHLRightSlipMenu : NSObject
+ (instancetype)shareInstance;
- (void)addLeftview:(UIView *)leftview toviewctrl:(UIViewController *)viewctrl;
@end
