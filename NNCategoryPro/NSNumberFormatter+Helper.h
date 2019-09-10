//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 四舍五入
FOUNDATION_EXPORT NSString * const kNumIdentify ;// 默认(四舍五入)
/// 分隔符,
FOUNDATION_EXPORT NSString * const kNumIdentify_decimal ;
/// 百分比
FOUNDATION_EXPORT NSString * const kNumIdentify_percent ;
/// 货币$
FOUNDATION_EXPORT NSString * const kNumIdentify_currency ;
/// 科学计数法 1.234E8
FOUNDATION_EXPORT NSString * const kNumIdentify_scientific ;
/// 加号符号
FOUNDATION_EXPORT NSString * const kNumIdentify_plusSign ;
/// 减号符号
FOUNDATION_EXPORT NSString * const kNumIdentify_minusSign ;
/// 指数符号
FOUNDATION_EXPORT NSString * const kNumIdentify_exponentSymbol ;
/// #,##0.00
FOUNDATION_EXPORT NSString * const kNumFormat;

@interface NSNumberFormatter (Helper)

@property (class, nonatomic, strong, readonly) NSDictionary *styleDic;

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify;

/// [源]小数位数及四射五入处理
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode;
/// [简]2位小数四射五入处理
+ (NSString *)fractionDigits:(NSNumber *)obj;

+ (NSNumberFormatter *)positiveFormat:(NSString *)formatStr;

+ (NSString *)numberStyle:(NSNumberFormatterStyle)nstyle number:(id)number;

@end

NS_ASSUME_NONNULL_END