//
//  SHLRightSlipMenu.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "SHLRightSlipMenu.h"
#import "SHLLeftView.h"
static SHLRightSlipMenu *rightSlip;
@implementation UIView (Frame)

- (void)setX:(CGFloat )originX
{
    CGRect rect = self.frame;
    
    rect.origin.x = originX;
    
    self.frame = rect;
}
@end
@interface SHLRightSlipMenu ()
{
    BOOL _bMove;
    CGPoint _startPoint;
    CGPoint _startOrigin;
}
@property (nonatomic, strong) UIView *leftsildview;
@property (nonatomic, strong) UIViewController *mainviewctrl;
@property (strong, nonatomic)UIPanGestureRecognizer *panGestureRecognizer;
/**
 *  是否可以侧滑,默认为NO。
 */
@property (assign, nonatomic) BOOL sideslipEnable;

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
        self.sideslipEnable = YES;
        [self.mainviewctrl.view addGestureRecognizer:self.panGestureRecognizer];
    }
}
- (void)setLeftsildview:(UIView *)leftsildview
{
    CGRect frame = leftsildview.frame;
    _leftsildview = leftsildview;
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    
    if (frame.size.width >= (screenFrame.size.width * 0.8))  frame.size.width = screenFrame.size.width * 0.8;
    if (frame.size.height > screenFrame.size.height)  frame.size.height = screenFrame.size.height;
    
    _leftsildview.frame = CGRectMake(-frame.size.width / 2, (screenFrame.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
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
        self.sideslipEnable = NO;
    }
}
#pragma mark ----------手势处理响应---------
- (void)handleOfPanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    //拿到手势进行判断
    if (!self.sideslipEnable) return;
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
        else if ((_startOrigin.x + pointWindow.x - _startPoint.x) > self.sideView.frame.size.width)
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
        
        if (verPoint.x > self.sideView.frame.size.width || (self.mainviewctrl.view.frame.origin.x > self.sideView.frame.size.width / 2 && verPoint.x > -self.sideView.frame.size.width))
        {
            [self moveToMaxWithAnimation:YES];
        }
        else
        {
            [self moveToMinWithAnimation:YES];
        }
    }
}

#pragma mark ---------视图位移处理--------------
- (void)moveToMinWithAnimation:(BOOL)animation
{
    if (self.mainviewctrl.view.frame.origin.x == 0) return;
    
    if ([self.mainviewctrl.view viewWithTag:205])
    {
        [[self.mainviewctrl.view viewWithTag:205] removeFromSuperview];
    }
    
    [UIView animateWithDuration:animation?0.25:0.0 animations:^{
        [self.mainviewctrl.view setX:0];
        [self.sideView setX:-self.sideView.frame.size.width / 2];
    } completion:^(BOOL finished) {
    }];
}

- (void)moveToPointX:(CGFloat)pointX
{
    [self.mainviewctrl.view setX:pointX];
    [self.sideView setX:pointX / 2 - self.sideView.frame.size.width / 2];
}

- (void)moveToMaxWithAnimation:(BOOL)animation
{
    if (self.sideView.frame.origin.x == 0) return;
    if (![self.mainviewctrl.view viewWithTag:205])
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:self.mainviewctrl.view.bounds];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(onBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 205;
        [self.mainviewctrl.view addSubview:backButton];
    }
    
    
    [UIView animateWithDuration:animation?0.25:0.0 animations:^{
        [self.mainviewctrl.view setX:self.sideView.frame.size.width];
        [self.sideView setX:0];
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
- (void)onBackButton:(id)sender
{
    UIButton *backButton = (UIButton *)sender;
    [backButton removeFromSuperview];
    [self moveToMinWithAnimation:YES];
}

@end
