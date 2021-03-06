//
//  NSDictionary+Helper.h
//  
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (Helper)

///->NSData
@property (nonatomic, strong, readonly, nullable) NSData *jsonData;
///->NSString
@property (nonatomic, strong, readonly, nullable) NSString *jsonString;
///键值翻转
@property (nonatomic, strong, readonly, nullable) NSDictionary *invert;

/**
 map 高阶函数
 */
- (NSArray *)map:(NSDictionary* (NS_NOESCAPE ^)(KeyType key, ObjectType obj))transform;
/**
filter 高阶函数
*/
- (NSDictionary *)filter:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))transform;
/**
compactMapValues 高阶函数(将 value 为 nil 过滤掉)
*/
- (NSDictionary *)compactMapValues:(id (NS_NOESCAPE ^)(ObjectType obj))transform;

/// 读取项目Plist文件(在TARGETS里的CopyBundleResources中必须存在)
+ (NSDictionary *)dictionaryFromPlist:(NSString *)plistName;

/**
 根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey;

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


@interface NSMutableDictionary<KeyType, ObjectType> (Helper)

@property(nonatomic, copy, readonly) NSMutableDictionary *(^addEntries)(NSDictionary<KeyType, ObjectType> *);
@property(nonatomic, copy, readonly) NSMutableDictionary *(^setObjectForKey)(KeyType, ObjectType);

@property(nonatomic, copy, readonly) NSMutableDictionary *(^removeObjectForKey)(KeyType);
@property(nonatomic, copy, readonly) NSMutableDictionary *(^removeObjectsForKeys)(NSArray<ObjectType> *);
@property(nonatomic, copy, readonly) NSMutableDictionary *(^removeAll)(void);

- (void)setSafeObjct:(id _Nullable)obj forKey:(id<NSCopying>)akey;
- (void)setSafeObject:(nullable id)obj forKeyedSubscript:(id <NSCopying>)key;

@end
NS_ASSUME_NONNULL_END
