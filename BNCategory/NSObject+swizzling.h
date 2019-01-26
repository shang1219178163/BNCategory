//
//  NSObject+swizzling.h
//  
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 SHANG. All rights reserved.
//

/**
 此类为swizzling方法源类,方法在此类实现,别处调用
 
*/

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (swizzling)


FOUNDATION_EXPORT Class NSClassFromObj(id clz);


/**
 (源方法)实例方法交换

 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
FOUNDATION_EXPORT BOOL SwizzleMethodInstance(id clz, SEL origSelector, SEL replSelector);

/**
 (源方法)类方法交换
 
 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
FOUNDATION_EXPORT BOOL SwizzleMethodClass(id clz, SEL origSelector, SEL replSelector);

/**
 实例方法交换-所有类实例方法交换
 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodInstance:(id)clz origSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 实例方法交换
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodInstanceOrigSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 类方法交换
 
 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodClass:(id)clz origSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 类方法交换
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodClassOrigSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 判断方法是否在子类里override了
 
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)isMethodOverride:(id)clz selector:(SEL)sel;


@end
