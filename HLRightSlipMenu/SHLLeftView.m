//
//  SHLLeftView.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "SHLLeftView.h"
@interface SHLLeftView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *lefttableview;
@end
@implementation SHLLeftView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setUpview];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)setUpview
{
    _lefttableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _lefttableview.bounces = YES;
    _lefttableview.delegate = self;
    _lefttableview.dataSource = self;
    _lefttableview.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin  |
    UIViewAutoresizingFlexibleWidth       |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin   |
    UIViewAutoresizingFlexibleHeight      |
    UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_lefttableview];
}
- (void)btntappedle
{
    NSLog(@"dianjilebtn");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"leftcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"left-%ld",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"选中了:%ld",indexPath.row);
}
@end
