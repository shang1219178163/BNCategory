//
//  UINavigationController+swizzing.m
//  NNCategory
//
//  Created by BIN on 2018/11/16.
//

#import "UINavigationController+swizzing.h"

#import "NSObject+swizzling.h"
#import "UIViewController+Helper.h"

@implementation UINavigationController (swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(@"UINavigationController", @selector(pushViewController:animated:), @selector(swz_PushViewController:animated:));
            
        });
    }
}

- (void)swz_PushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers containsObject:viewController]) return;
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    viewController.view.backgroundColor = UIColor.whiteColor;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:viewController.backBtn];;
   
    }
    self.navigationController.delegate = nil;
    [self swz_PushViewController:viewController animated:animated];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
//        return  self.navigationController.viewControllers.count > 1;
//    }
//    return YES;
//}

@end
