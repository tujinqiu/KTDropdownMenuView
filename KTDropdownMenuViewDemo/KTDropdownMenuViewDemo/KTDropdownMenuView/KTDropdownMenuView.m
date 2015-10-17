//
//  KTDropdownMenuView.m
//  KTDropdownMenuViewDemo
//
//  Created by tujinqiu on 15/10/12.
//  Copyright © 2015年 tujinqiu. All rights reserved.
//

#import "KTDropdownMenuView.h"
#import <Masonry.h>

static const CGFloat kKTDropdownMenuViewHeaderHeight = 300;

@interface UIViewController (topestViewController)

- (UIViewController *)topestViewController;

@end

@implementation UIViewController (topestViewController)

- (UIViewController *)topestViewController
{
    if (self.presentedViewController)
    {
        return [self.presentedViewController topestViewController];
    }
    if ([self isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)self;
        return [[tab selectedViewController] topestViewController];
    }
    if ([self isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)self;
        return [[nav visibleViewController] topestViewController];
    }
    
    return self;
}

@end

@interface KTDropdownMenuView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) BOOL isMenuShow;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *wrapperView;

@end

@implementation KTDropdownMenuView

#pragma mark -- life cycle --

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame])
    {
        _animationDuration = 0.4;
        _backgroundAlpha = 0.3;
        _cellHeight = 44;
        _isMenuShow = NO;
        _selectedIndex = 0;
        _titles = titles;
        
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleButton.mas_right).offset(5);
            make.centerY.equalTo(self.titleButton.mas_centerY);
        }];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UINavigationBar *navBar = [keyWindow.rootViewController topestViewController].navigationController.navigationBar;
        [keyWindow addSubview:self.wrapperView];
        [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(keyWindow);
            make.top.equalTo(navBar.mas_bottom);
        }];
        [self.wrapperView addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.wrapperView);
        }];
        [self.wrapperView addSubview:self.tableView];
        CGFloat tableCellsHeight = _cellHeight * _titles.count;
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.wrapperView);
            make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - kKTDropdownMenuViewHeaderHeight);
            make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
        }];
        self.wrapperView.hidden = YES;
    }
    
    return self;
}

#pragma mark -- UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    if (self.selectedIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = self.cellColor;
    cell.textLabel.font = self.textFont;
    cell.textLabel.textColor = self.textColor;
    
    return cell;
}

#pragma mark -- UITableViewDataDelegate --

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- handle actions --

- (void)handleTapOnTitleButton:(UIButton *)button
{
    self.isMenuShow = !self.isMenuShow;
}

#pragma mark -- helper methods --

- (void)showMenu
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kKTDropdownMenuViewHeaderHeight)];
    headerView.backgroundColor = self.cellColor;
    self.tableView.tableHeaderView = headerView;
    [self.tableView layoutIfNeeded];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_top).offset(- kKTDropdownMenuViewHeaderHeight);
        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(kKTDropdownMenuViewHeaderHeight);
    }];
    self.wrapperView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = self.backgroundAlpha;
                     } completion:nil];
}

- (void)hideMenu
{
    CGFloat tableCellsHeight = _cellHeight * _titles.count;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.wrapperView);
        make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - kKTDropdownMenuViewHeaderHeight);
        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
    }];
    
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         self.wrapperView.hidden = YES;
                     }];
}

#pragma mark -- getter and setter --

- (UIColor *)cellColor
{
    if (!_cellColor)
    {
        _cellColor = [UIColor greenColor];
    }
    
    return _cellColor;
}

- (UIColor *)cellSeparatorColor
{
    if (!_cellSeparatorColor)
    {
        _cellSeparatorColor = [UIColor whiteColor];
    }
    
    return _cellSeparatorColor;
}

- (UIColor *)textColor
{
    if (!_textColor)
    {
        _textColor = [UIColor whiteColor];
    }
    
    return _textColor;
}

- (UIFont *)textFont
{
    if(!_textFont)
    {
        _textFont = [UIFont systemFontOfSize:17];
    }
    
    return _textFont;
}

- (UIButton *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitle:[self.titles objectAtIndex:0] forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(handleTapOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton.titleLabel setFont:self.textFont];
        [_titleButton setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    
    return _titleButton;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        NSString * bundlePath = [[ NSBundle mainBundle] pathForResource:@"KTDropdownMenuView" ofType:@ "bundle"];
        NSString *imgPath= [bundlePath stringByAppendingPathComponent:@"arrow_down_icon.png"];
        UIImage *image=[UIImage imageWithContentsOfFile:imgPath];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
    }
    
    return _arrowImageView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = self.cellSeparatorColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    }
    
    return _tableView;
}

- (UIView *)wrapperView
{
    if (!_wrapperView)
    {
        _wrapperView = [[UIView alloc] init];
        _wrapperView.clipsToBounds = YES;
    }
    
    return _wrapperView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = self.backgroundAlpha;
    }
    
    return _backgroundView;
}

- (void)setIsMenuShow:(BOOL)isMenuShow
{
    if (_isMenuShow != isMenuShow)
    {
        _isMenuShow = isMenuShow;
        
        if (isMenuShow)
        {
            [self showMenu];
        }
        else
        {
            [self hideMenu];
        }
            
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        [self.tableView reloadData];
    }
    
    self.isMenuShow = NO;
}

@end
