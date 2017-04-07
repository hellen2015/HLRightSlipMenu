//
//  SHLLeftView.m
//  HLRightSlipMenu
//
//  Created by hellen on 2017/4/6.
//  Copyright © 2017年 SKYWORTH. All rights reserved.
//

#import "SHLLeftView.h"
#define KHEIGHT 152
@interface SHLLeftView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *lefttableview;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headerImageView;
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
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, KHEIGHT)];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:self.headerView.bounds];
    headerImageView.image = [UIImage imageNamed:@"bg_user"];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    [self.headerView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    self.lefttableview.tableHeaderView = self.headerView;

}
- (void)btntappedle
{
    NSLog(@"dianjilebtn");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"leftcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"left-%ld",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"选中了左边:%ld",indexPath.row);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = KHEIGHT - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / KHEIGHT;
        CGFloat width = self.frame.size.width;
        // 拉伸后图片位置
        self.headerImageView.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
    }
}
@end
