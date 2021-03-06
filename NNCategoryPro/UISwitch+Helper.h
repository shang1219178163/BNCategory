//
//  UISwitch+Helper.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISwitch (Helper)

- (void)addActionHandler:(void(^)(UISwitch *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 [源]UISwitch创建方法
 */
+ (instancetype)createRect:(CGRect)rect;

//
@end

NS_ASSUME_NONNULL_END
