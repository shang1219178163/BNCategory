//
//  UILabel+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/3.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Helper)

@property(nonatomic, strong, readonly) NSMutableAttributedString *matt;

/**
 [源]UILabel创建
 */
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type;

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (instancetype)createTipWithSize:(CGSize)size
                        tipCenter:(CGPoint)tipCenter
                             text:(NSString *)text
                        textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
