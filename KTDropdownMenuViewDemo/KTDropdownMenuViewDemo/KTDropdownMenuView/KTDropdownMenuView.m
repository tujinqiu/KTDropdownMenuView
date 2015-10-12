//
//  KTDropdownMenuView.m
//  KTDropdownMenuViewDemo
//
//  Created by tujinqiu on 15/10/12.
//  Copyright © 2015年 tujinqiu. All rights reserved.
//

#import "KTDropdownMenuView.h"
#import <Masonry.h>

@interface KTDropdownMenuView()

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation KTDropdownMenuView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame])
    {
        _animationDuration=0.4;
        _backgroundAlpha=0.3;
        _cellHeight=44;
        _titles= titles;
        
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleButton.mas_right).offset(5);
            make.centerY.equalTo(self.titleButton.mas_centerY);
        }];
    }
    
    return self;
}

#pragma -- getter and setter --

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

@end
