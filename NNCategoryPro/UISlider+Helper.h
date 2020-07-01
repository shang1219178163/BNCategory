//
//  UISlider+Helper.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (Helper)

+ (instancetype)createRect:(CGRect)rect
                     value:(CGFloat)value
                  minValue:(CGFloat)minValue
                  maxValue:(CGFloat)maxValue;

@end

NS_ASSUME_NONNULL_END
