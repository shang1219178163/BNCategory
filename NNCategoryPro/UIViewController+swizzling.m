//
//  UIViewController+swizzling.m
//  
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIViewController+swizzling.h"

#import "NSObject+swizzling.h"

@implementation UIViewController (swizzling)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(@"UIViewController", @selector(viewDidLoad), @selector(swz_viewDidLoad));
            SwizzleMethodInstance(@"UIViewController", @selector(viewWillAppear:), @selector(swz_viewWillAppear:));
            SwizzleMethodInstance(@"UIViewController", @selector(viewDidDisappear:), @selector(swz_viewDidDisappear:));
            
            SwizzleMethodInstance(@"UIViewController", @selector(presentViewController:animated:completion:), @selector(swz_presentViewController:animated:completion:));

        });
    }
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swz_viewDidLoad {
    if ([self isKindOfClass:UINavigationController.class]) {
        UINavigationController * navController = (UINavigationController *)self;
        navController.interactivePopGestureRecognizer.enabled  = true;
        navController.interactivePopGestureRecognizer.delegate = self;
        
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        //    self.view.backgroundColor = UIColor.whiteColor;//警告:此行代码可能会有问题
        //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    }
    [self swz_viewDidLoad];

}

- (void)swz_viewWillAppear:(BOOL)animated{
    [self swz_viewWillAppear:animated];
    
//    [self eventGather:YES];
}

- (void)swz_viewDidDisappear:(BOOL)animated{
    [self swz_viewDidDisappear:animated];
    
//    [self eventGather:NO];
}

- (void)swz_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:UIAlertController.class]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            [self changeAppIconAction];
            return;
        } else {
            [self swz_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self swz_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark -funtions

- (void)eventGather:(BOOL)isBegin{
    NSString *className = NSStringFromClass(self.class);
    //设置不允许发送数据的Controller
    NSArray *filters = @[@"UINavigationController",@"UITabBarController"];
    if ([filters containsObject:className]) return ;

    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0){ //有标题的才符合我的要求
        // 这里发送log
        NSLog(@"统计打点 : %@   开始打点:%@", self.class,@(isBegin));

    }
}

- (void)changeAppIconAction {
    NSLog(@"替换图标成功");
}

#pragma mark - 滑动开始会触发

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 手势
    if(gestureRecognizer == ((UINavigationController *)self).interactivePopGestureRecognizer){
        if(((UINavigationController *)self).viewControllers.count < 2){
            return false;
        }
    }
    return true;
}


@end
