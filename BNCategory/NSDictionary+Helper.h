//
//  NSDictionary+Helper.h
//  
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Helper)

- (NSDictionary *)invert;

/// id类型转字典
FOUNDATION_EXPORT NSDictionary *NSDictionaryFromObj(id obj);
/// 富文本配置字典
FOUNDATION_EXPORT NSDictionary<NSAttributedStringKey, id> * AttributeDict(NSNumber * type);
/// 读取项目Plist文件(在TARGETS里的CopyBundleResources中必须存在)
FOUNDATION_EXPORT NSMutableDictionary *DicFromPlist(NSString *plistName);

/**
 根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey;

- (NSMutableDictionary *)filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue;

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *  @return url 参数字符串
 */
- (NSString *)toURLQueryString;

/**
 *  @brief  将NSDictionary转换成XML字符串 不带XML声明 不带根节点
 *  @return XML 字符串
 */
- (NSString *)XMLString;
/**
 *  @brief  将NSDictionary转换成XML字符串, 默认 <?xml version=\"1.0\" encoding=\"utf-8\"?> 声明   自定义根节点
 *  @param rootElement 根节点
 *  @return XML 字符串
 */
- (NSString *)XMLStringDefaultDeclarationWithRootElement:(NSString *)rootElement;
/**
 *  @brief  将NSDictionary转换成XML字符串, 自定义根节点  自定义xml声明
 *  @param rootElement 根节点
 *  @param declaration xml声明
 *  @return 标准合法 XML 字符串
 */
- (NSString *)XMLStringWithRootElement:(nullable NSString *)rootElement declaration:(nullable NSString *)declaration;
/**
 *  @brief  将NSDictionary转换成Plist字符串
 *  @return Plist 字符串
 */
- (NSString *)plistString;
/**
 *  @brief  将NSDictionary转换成Plist data
 *  @return Plist data
 */
- (NSData *)plistData;


@end

NS_ASSUME_NONNULL_END
