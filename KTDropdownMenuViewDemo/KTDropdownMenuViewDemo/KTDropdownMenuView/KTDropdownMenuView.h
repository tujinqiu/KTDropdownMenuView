//
//  KTDropdownMenuView.h
//  KTDropdownMenuViewDemo
//
//  Created by tujinqiu on 15/10/12.
//  Copyright © 2015年 tujinqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTDropdownMenuView : UIView

// width the table width, default 0.0, which indicates that the table width is equal to
// the window width, width less than 80 is two small and will be set to window width as
// well
@property (nonatomic, assign) CGFloat width;

// cell color default [UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000]
@property (nonatomic, strong) UIColor *cellColor;

// cell seprator color default whiteColor
@property (nonatomic, strong) UIColor *cellSeparatorColor;

// CellAccessoryCheckmark color default whiteColor
@property (nonatomic, strong) UIColor *cellAccessoryCheckmarkColor;

// cell height default 44
@property (nonatomic, assign) CGFloat cellHeight;

// animation duration default 0.4
@property (nonatomic, assign) CGFloat animationDuration;


// text color default whiteColor
@property (nonatomic, strong) UIColor *textColor;

// text font default system 17
@property (nonatomic, strong) UIFont *textFont;

// background opacity default 0.3
@property (nonatomic, assign) CGFloat backgroundAlpha;

// callback block
@property (nonatomic, copy) void (^selectedAtIndex)(int index);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles;

@end
