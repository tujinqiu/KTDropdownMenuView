# KTDropdownMenuView
类似新浪微博的下拉菜单

![](https://github.com/tujinqiu/KTDropdownMenuView/raw/master/Untitled.gif)
![](https://github.com/tujinqiu/KTDropdownMenuView/raw/master/Untitled1.gif)

仿照 BTNavigationDropdownMenu 的Objective-C版本
---
https://github.com/PhamBaTho/BTNavigationDropdownMenu

用法：
---
导入文件夹KTDropdownMenuView到工程中
```c
    NSArray *titles = @[@"首页", @"朋友圈", @"我的关注", @"明星", @"家人朋友"];
    KTDropdownMenuView *menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    menuView.width = 300;
    self.navigationItem.titleView = menuView;
```
block进行回调
```c
    menuView.selectedAtIndex = ^(int index)
    {
        NSLog(@"selected title:%@", titles[index]);
    };
```

properties：
---
```c
// width the table width, default 0.0, which indicates that the table width is equal to
// the window width, width less than 80 is two small and will be set to window width as
// well
@property (nonatomic, assign) CGFloat width;

// cell color default [UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000]
@property (nonatomic, strong) UIColor *cellColor;

// cell seprator color default whiteColor
@property (nonatomic, strong) UIColor *cellSeparatorColor;

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
```

