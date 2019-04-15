//
//  NSObject+Helper.h
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"

/// 关联对象的唯一无符号常量值
FOUNDATION_EXPORT NSString * RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount);
// 系统版本判断
FOUNDATION_EXPORT BOOL iOSVer(CGFloat version);
/// 由角度转换弧度
FOUNDATION_EXPORT CGFloat CGRadianFromDegrees(CGFloat x);
/// 弧度转换角度
FOUNDATION_EXPORT CGFloat CGDegreesFromRadian(CGFloat x);
/// 四舍五入
FOUNDATION_EXPORT CGFloat roundFloat(CGFloat value,NSInteger num);
/// swift类需要加命名空间
FOUNDATION_EXPORT NSString * SwiftClassName(NSString *className);

@interface NSObject (Helper)<NSCoding>

void dispatchAsyncMain(void(^block)(void));
void dispatchAsyncGlobal(void(^block)(void));
void dispatchAfterMain(double delay ,void(^block)(void));
void dispatchApplyGlobal(id obj ,void(^block)(size_t index));

/**
 代码块返回单个参数的时候,不适用于id不能代表的类型()
*/
//@property (nonatomic, copy) BlockObject blockObject;//其他类使用该属性注意性能
@property (nonatomic, copy) void(^blockObject)(id obj, id item, NSInteger idx);//其他类使用该属性注意性能
@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, copy, nonnull) NSString *runtimeKey;

- (NSArray *)allPropertyNames:(NSString *)clsName;

/**
 模型转字典
 
 */
- (NSDictionary *)modelToDictionary;

/**
 模型转JSON
 
 */
- (NSString *)modelToJSONWithError:(NSError **)error;

-(BOOL)validObject;

-(NSString *)showNilText;

- (NSString *)JSONValue;

/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor;

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 (通用)富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;


/**
 (通用)密集view父视图尺寸
 */
- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding;

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(UIColor *)color tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(UIColor *)tapColor;

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps;


- (NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must;

- (NSString *)stringFromBool:(NSNumber *)boolNum;

- (BOOL)stringToBool:(NSString *)string;

- (BOOL)isKindOfClassList:(NSArray *)clzList;


+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr;

//获取随机数
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to;

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber;

@end
