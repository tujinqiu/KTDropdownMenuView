# KTDropdownMenuView
类似新浪微博的下拉菜单

![](https://github.com/tujinqiu/KTDropdownMenuView/raw/master/Untitled.gif)

仿照 BTNavigationDropdownMenu 的Objective-C版本
---
https://github.com/PhamBaTho/BTNavigationDropdownMenu

用法：
---
```c
    NSArray *titles = @[@"首页", @"朋友圈", @"我的关注", @"明星", @"家人朋友"];
    KTDropdownMenuView *menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    self.navigationItem.titleView = menuView;
```
block进行回调
```c
    menuView.selectedAtIndex = ^(int index)
    {
        NSLog(@"selected title:%@", titles[index]);
    };
```
