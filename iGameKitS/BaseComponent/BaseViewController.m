//
//  BaseViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeNavigationController.h"
#import "UINavigationBar+ApplyTheme.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    self.navigationSetup = ^(NavigationTheme *theme) {
        if ([weakSelf.navigationController isKindOfClass:[ThemeNavigationController class]]) {
            ThemeNavigationController *themeNavigationController = weakSelf.navigationController;
            themeNavigationController.statusBarStyle = theme.statusBarStyle;
            [themeNavigationController.navigationBar applyTheme:theme];
        }
    };
    self.navigationSetup([[NavigationTheme alloc]
                          initWithTintColor:[UIColor blackColor]
                          barColor:[UIColor colorWithRed:239.0f/255.0f
                                                   green:158.0f/255.0f
                                                    blue:0.0f/255.0f
                                                   alpha:1.0f]
                          titleAttributes:@{
                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                            NSForegroundColorAttributeName:[UIColor blackColor]
                                            }]);
}

@end
