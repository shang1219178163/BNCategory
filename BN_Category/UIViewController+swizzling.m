//
//  UIViewController+swizzling.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+swizzling.h"

#import "NSObject+swizzling.h"

#define isOpen 1

@implementation UIViewController (swizzling)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (isOpen) {
//            [self swizzleMethodClass:self.class origSel:@selector(viewDidLoad) newSel:@selector(swz_viewDidLoad)];
//
//        }
//    });
//}

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (isOpen) {
                [self swizzleMethodClass:self.class origSel:@selector(viewDidLoad) newSel:@selector(swz_viewDidLoad)];
                [self swizzleMethodClass:self.class origSel:@selector(viewWillAppear:) newSel:@selector(swz_viewWillAppear:)];
                [self swizzleMethodClass:self.class origSel:@selector(viewDidDisappear:) newSel:@selector(swz_viewDidDisappear:)];

            }
        });
    }
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swz_viewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = UIColor.whiteColor;//警告:此行代码可能会有问题
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];

    [self swz_viewDidLoad];

}

- (void)swz_viewWillAppear:(BOOL)animated{
    [self swz_viewWillAppear:animated];
    
    [self eventGather:YES];

}

- (void)swz_viewDidDisappear:(BOOL)animated{
    [self swz_viewDidDisappear:animated];
    
    [self eventGather:NO];
    
}

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


@end
