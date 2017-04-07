//
//  SHLRightSlipMenu.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "SHLRightSlipMenu.h"
#import "SHLLeftView.h"
#import "UIView+frame.h"
static SHLRightSlipMenu *rightSlip;
#define SCREENBOUNSWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENBOUNSHEIGHT [UIScreen mainScreen].bounds.size.height
@interface SHLRightSlipMenu ()
{
    BOOL _bMove;
    CGPoint _startPoint;
    CGPoint _startOrigin;
}
@property (nonatomic, strong) UIView *leftsildview;
@property (nonatomic, strong) UIViewController *mainviewctrl;
@property (strong, nonatomic)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIButton *clickBackButton;
@property (assign, nonatomic) BOOL slipEnable;
@end
@implementation SHLRightSlipMenu
/**
 设置单例
 */
+ (instancetype)shareInstance
{
   return [[self alloc] init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rightSlip = [super allocWithZone: zone];
    });
    return rightSlip;
}
- (id)copyWithZone:(struct _NSZone *)zone
{
    return rightSlip;
}
- (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return rightSlip;
}
/**
    把左边view添加进来
 */
- (void)addLeftview:(UIView *)leftview toviewctrl:(UIViewController *)viewctrl
{
    if(leftview && viewctrl)
    {
        [self initSet];
        self.leftsildview = leftview;
        self.mainviewctrl = viewctrl;
        self.slipEnable = YES;
        [self.mainviewctrl.view addGestureRecognizer:self.panGestureRecognizer];
    }
}
- (void)setLeftsildview:(UIView *)leftsildview
{
    _leftsildview = leftsildview;
    if (leftsildview.shl_width >= (SCREENBOUNSWIDTH * 0.8))  leftsildview.shl_width = SCREENBOUNSWIDTH * 0.8;
    if (leftsildview.shl_height > SCREENBOUNSHEIGHT)  leftsildview.shl_height = SCREENBOUNSHEIGHT;
    
    _leftsildview.frame = CGRectMake(-leftsildview.shl_width / 2, (SCREENBOUNSHEIGHT - leftsildview.shl_height) / 2, leftsildview.shl_width, leftsildview.shl_height);
}
- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer)
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfPanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}
- (void)removeSideView
{
    [self initSet];
}
- (void)initSet
{
    if (self.sideView)
    {
        if([self.leftsildview isKindOfClass:[SHLLeftView class]])
            [self.sideView removeFromSuperview];
        self.leftsildview = nil;
        [self.mainviewctrl.view removeGestureRecognizer:self.panGestureRecognizer];
        self.mainviewctrl = nil;
        self.slipEnable = NO;
    }
}
#pragma mark --------手势处理响应-------
- (void)handleOfPanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    //拿到手势进行判断
    if (!self.slipEnable) return;
    CGPoint pointView = [gestureRecognizer locationInView:self.mainviewctrl.view];
    CGPoint pointWindow = [gestureRecognizer locationInView:self.mainviewctrl.view.window];
    
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    if (state == UIGestureRecognizerStateBegan)
    {
        if (pointView.x > 50) _bMove = NO;
        else _bMove = YES;
        _startPoint = pointWindow;
        _startOrigin = self.mainviewctrl.view.frame.origin;
    }
    else if (state == UIGestureRecognizerStateChanged)
    {
        if ( !_bMove) return;
        
        if ((_startOrigin.x + pointWindow.x - _startPoint.x) < 0 )
        {
            [self moveToMinWithAnimation:NO];
        }
        else if ((_startOrigin.x + pointWindow.x - _startPoint.x) > self.sideView.shl_width)
        {
            [self moveToMaxWithAnimation:NO];
        }
        else
        {
            [self moveToPointX:_startOrigin.x + pointWindow.x - _startPoint.x ];
        }
    }
    else
    {
        if ( !_bMove) return;
        
        CGPoint verPoint = [gestureRecognizer velocityInView:self.mainviewctrl.view];
        
        if (verPoint.x > self.sideView.frame.size.width || (self.mainviewctrl.view.shl_x > self.sideView.shl_width / 2 && verPoint.x > -self.sideView.shl_width))
        {
            [self moveToMaxWithAnimation:YES];
        }
        else
        {
            [self moveToMinWithAnimation:YES];
        }
    }
}
#pragma mark ------移动------
- (void)moveToMinWithAnimation:(BOOL)animation
{
    if (self.mainviewctrl.view.frame.origin.x == 0) return;
    
    if (self.clickBackButton.superview)
    {
        [self.clickBackButton removeFromSuperview];
    }
    
    [UIView animateWithDuration:animation?0.25:0.0 animations:^{
        self.mainviewctrl.view.shl_x = 0;
        self.sideView.shl_x = -self.sideView.shl_width/2;
    } completion:^(BOOL finished) {
    }];
}

- (void)moveToPointX:(CGFloat)pointX
{
    self.mainviewctrl.view.shl_x = pointX;
    self.sideView.shl_x = pointX/2 - self.sideView.shl_width/2;
}

- (void)moveToMaxWithAnimation:(BOOL)animation
{
    if (self.sideView.frame.origin.x == 0) return;
    if (!self.clickBackButton.superview)
    {
        UIButton *clickBackButton = [[UIButton alloc] initWithFrame:self.mainviewctrl.view.bounds];
        clickBackButton.backgroundColor = [UIColor clearColor];
        [clickBackButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
        self.clickBackButton = clickBackButton;
        [self.mainviewctrl.view addSubview:clickBackButton];
    }
    [UIView animateWithDuration:animation?0.25:0.0 animations:^{
        self.mainviewctrl.view.shl_x = self.sideView.shl_width;
        self.sideView.shl_x = 0;
    }];
}
- (UIView *)sideView
{
    if (_leftsildview && ![_leftsildview.superview isKindOfClass:[UIWindow class]])
    {
        [self.mainviewctrl.view.window insertSubview:_leftsildview atIndex:0];
        self.mainviewctrl.view.window.userInteractionEnabled = YES;
    }
    return _leftsildview;
}
- (void)onBackButton
{
    [self.clickBackButton removeFromSuperview];
    [self moveToMinWithAnimation:YES];
}

@end
