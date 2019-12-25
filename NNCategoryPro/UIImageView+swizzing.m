//
//  UIImageView+swizzing.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/28.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UIImageView+swizzing.h"

#import "NSObject+swizzling.h"

@implementation UIImageView (swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            SwizzleMethodInstance(@"UIImageView", @selector(setTintColor:), @selector(hook_setTintColor:));
            SwizzleMethodInstance(@"UIImageView", NSSelectorFromString(@"setTintColor:"), NSSelectorFromString(@"hook_setTintColor:"));

        });
    }
}

- (void)hook_setTintColor:(UIColor *)color {
    [self hook_setTintColor:color];
    
    if ([self isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
        return;
    }
    
    if (self.image.renderingMode != UIImageRenderingModeAlwaysTemplate) {
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}



@end
