//
//  NSObject+Helper.m
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

#import "NSString+Helper.h"
#import "NSDate+Helper.h"

#import "UIImage+Helper.h"
#import "NSBundle+Helper.h"
#import "UIColor+Helper.h"
#import "NSArray+Helper.h"

/**
 NSIndexPath->字符串
 */
NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {
  return [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
}
/**
 html->字符串
 */
NSString * NSStringFromHTML(NSString *html) {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while(scanner.isAtEnd == NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    //    NSMutableString *str1 = [NSMutableString stringWithString:html];
    //    for (NSInteger i = 0; i < str1.length; i++) {
    //        unichar c = [str1 characterAtIndex:i];
    //        NSRange range = NSMakeRange(i, 1);
    //
    //        //  在这里添加要过滤的特殊符号
    //        if ( c == '\r' || c == '\n' || c == '\t') {
    //            [str1 deleteCharactersInRange:range];
    //            --i;
    //        }
    //    }
    //    html  = [NSString stringWithString:str1];
    return html;
}
/**
 id类型->字符串
 */
NSString * NSStringFromLet(id obj) {
    return [NSString stringWithFormat:@"%@",obj];
}

/**
 NSInteger->字符串
 */
NSString * NSStringFromInt(NSInteger obj){
    return [@(obj) stringValue];
}

/**
 CGFloat->字符串
 */
NSString * NSStringFromFloat(CGFloat obj){
    return [@(obj) stringValue];
}

/**
 字符串->NSIndexPath(string 两部分数字必须用逗号隔开)
 */
NSIndexPath *NSIndexPathFromString(NSString *string) {
    if ([string containsString:@"{"]) string = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    if ([string containsString:@"}"]) string = [string stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray * list = [string componentsSeparatedByString:@","];
    return [NSIndexPath indexPathForRow:[list.firstObject integerValue] inSection:[list.lastObject integerValue]];
}

/**
 NSIndexPath快速生成
 */
NSIndexPath *NSIndexPathFromIndex(NSInteger section, NSInteger row) {
    return [NSIndexPath indexPathForRow:row inSection:section];
}

/**
 返回索引数组 
 */
NSArray *NSIndexPathsFromIdxInfo(NSInteger section, NSArray *rowList) {
    NSMutableArray *marr = [NSMutableArray array];
    for (NSNumber *row in rowList) {
        [marr addObject:[NSIndexPath indexPathForRow:row.integerValue inSection:section]];
        
    }
    return marr.copy;
}

/**
 字符串->UIViewController
 */
UIViewController * UICtrFromString(NSString *obj){
    return [[NSClassFromString(obj) alloc]init];
}

/**
 字符串->UINavigationController
 */
UINavigationController * UINavCtrFromObj(id obj){
    if ([obj isKindOfClass:[UINavigationController class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSString class]]) {
        return [[UINavigationController alloc]initWithRootViewController:UICtrFromString(obj)];
    }
    else if ([obj isKindOfClass:[UIViewController class]]) {
        return [[UINavigationController alloc]initWithRootViewController:obj];
    }
    return nil;
}

/**
 数组->UINavigationController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
 */
NSArray * UINavListFromList(NSArray *list){
    __block NSMutableArray * marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UINavigationController *navController = UINavCtrFromObj(obj);
            [marr addObject:navController];
            
        }
        else if([obj isKindOfClass:[NSArray class]]) {
            NSArray * itemList = (NSArray *)obj;//类名,title,img_N,img_H,badgeValue
            
            NSString * title = itemList.count > 1 ? itemList[1] :   @"";
            NSString * img_N = itemList.count > 2 ? itemList[2] :   @"";
            NSString * img_H = itemList.count > 3 ? itemList[3] :   @"";
            NSString * badgeValue = itemList.count > 4 ? itemList[4] :   @"";
            
            UIViewController * controller = UICtrFromString(itemList.firstObject);
            controller.title = itemList[1];
            controller.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:img_N] selectedImage:[UIImage imageNamed:img_H]];
            controller.tabBarItem.badgeValue = badgeValue;
            if (@available(iOS 10.0, *)) {
                controller.tabBarItem.badgeColor = badgeValue.integerValue <= 0 ? UIColor.clearColor:UIColor.redColor;
            } else {
                // Fallback on earlier versions
            }

            UINavigationController *navController = UINavCtrFromObj(controller);
            [marr addObject:navController];
        }
        else{
            assert([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSArray class]]);
        }
    }];
    NSArray *viewControllers = marr.copy;
    return viewControllers;
}

/**
 数组->UITabBarController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
 */
UITabBarController * UITarBarCtrFromList(NSArray *list){
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    tabBarVC.viewControllers = UINavListFromList(list);
//    tabBarVC.tabBar.barTintColor = UIColor.themeColor;
//    tabBarVC.tabBar.tintColor = UIColor.themeColor;
    return tabBarVC;
}

#pragma mark- -十六进制颜色
UIColor * UIColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

UIColor * UIColorRGB(CGFloat r,CGFloat g,CGFloat b){
    return UIColorRGBA(r, g, b, 1);
}

UIColor * UIColorDim(CGFloat White,CGFloat a){
    return [UIColor colorWithWhite:White alpha:a];////white 0-1为黑到白,alpha透明度
    //    return [UIColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度
}

UIColor * UIColorRGB_Init(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

UIColor * UIColorHex(NSString *hex){
    return [UIColor colorWithHexString:hex];
}

UIColor * UIColorHexValue(NSInteger hex){
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0 green:((hex & 0xFF00) >> 8)/255.0 blue:(hex & 0xFF)/255.0 alpha:1.0f];
    //    return [UIColor colorWithRed:((hex & 0xff0000) >> 16)/255.0 green:((hex & 0x00ff00) >> 8)/255.0 blue:(hex & 0x0000ff)/255.0 alpha:1.0];
}

NSArray * RGBAFromColor(UIColor *color){
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

/**
 判断颜色是不是亮色
 */
BOOL isLightColor(UIColor *color){
    NSArray *components = RGBAFromColor(color);
//    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    CGFloat sum = [[components valueForKeyPath:kArr_sum_float] floatValue];
    bool isLight = sum < 382 ? false : true;
    return isLight;
}

/**
 UIColor->UIImage
 */
UIImage * UIImageColor(UIColor * color){
    return [UIImage imageWithColor:color];
}

/**
 NSString->UIImage
 */
UIImage * UIImageNamed(NSString * obj){
    return [UIImage imageNamed:obj];
}

UIImage * UIImageFromName(NSString *obj, UIImageRenderingMode renderingMode){
    return [[UIImage imageNamed:obj] imageWithRenderingMode:renderingMode];
}

/**
 id类型->UIImage
 */
UIImage * UIImageObj(id obj){
    if ([obj isKindOfClass:[NSString class]]) {
        return UIImageNamed(obj);
    }
    else if ([obj isKindOfClass:[UIColor class]]) {
        return UIImageColor(obj);
    }
    else if ([obj isKindOfClass:[UIImage class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSData class]]) {
        return [UIImage imageWithData:obj];
    }
    else if ([obj isKindOfClass:[CIImage class]]) {
        return [UIImage imageWithCIImage:obj];
    }
    return nil;
}

bool UIImageEquelToImage(UIImage *image0, UIImage *image1){
    NSData *data0 = UIImagePNGRepresentation(image0);
    NSData *data1 = UIImagePNGRepresentation(image1);
    return  [data0 isEqualToData:data1];
}

BOOL iOSVer(CGFloat version){
    return (UIDevice.currentDevice.systemVersion.floatValue >= version) ? YES : NO;
}

/**
 由角度转换弧度
 */
CGFloat CGRadianFromDegrees(CGFloat x){
    return (M_PI * (x) / 180.0);
}

/**
 由弧度转换角度
 */
CGFloat CGDegreesFromRadian(CGFloat x){
    return (x * 180.0)/(M_PI);
}

CGFloat roundFloat(CGFloat value,NSInteger num){
    NSInteger tem = pow(10, num);
    CGFloat x = value*tem + 0.5;
    CGFloat figure = (floorf(x))/tem;
    return figure;
}

NSDictionary<NSAttributedStringKey, id> * AttributeDict(NSNumber * type){
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName   :   UIColor.blackColor,
                          NSBackgroundColorAttributeName   :   UIColor.whiteColor,
                          };
    
    switch (type.integerValue) {
        case 1://下划线
        {
            dic = @{
                    NSUnderlineStyleAttributeName   :   @(NSUnderlineStyleSingle),
                    NSUnderlineColorAttributeName  :   UIColor.redColor,

                    };
            
        }
            break;
        case 2://贯穿县
        {
            dic = @{
                    NSStrikethroughStyleAttributeName   :   @(NSUnderlineStyleSingle),
                    NSStrikethroughColorAttributeName   :   UIColor.redColor,
                    };
        }
            break;
        case 3://设置字形倾斜度取值为 NSNumber （float）,正值右倾，负值左倾
        {
            dic = @{
                    NSObliquenessAttributeName   :   @(0.8),
                    
                    };
        }
            break;
        case 4://拉伸文本
        {
            //正值横向拉伸文本，负值横向压缩文本
            dic = @{
                    NSExpansionAttributeName   :   @(0.3),
                    
                    };
        }
            break;
        case 5://书写方向(RightToLeft)
        {
            dic = @{
                    NSWritingDirectionAttributeName   :   @[@(3)],
//                    NSWritingDirectionAttributeName    :   @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)],

                    };

//            0 -> LRE -> NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding
//            1 -> RLE -> NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding
//            2 -> LRO -> NSWritingDirectionLeftToRight | NSWritingDirectionOverride
//            3 -> RLO -> NSWritingDirectionRightToLeft | NSWritingDirectionOverride
        }
             break;
        default:
            break;
    }
    return dic;
}

@implementation NSObject (Helper)

//为 NSObject 扩展 NSCoding 协议里的两个方法, 用来便捷实现复杂对象的归档与反归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    // 一个临时数据, 用来记录一个类成员变量的个数
    unsigned int ivarCount = 0;
    // 获取一个类所有的成员变量
    Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
    
    // 变量成员变量列表
    for (int i = 0; i < ivarCount; i ++) {
        // 获取单个成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量的名字并将其转换为 OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取该成员变量对应的值
        id value = [self valueForKey:ivarName];
        // 归档, 就是把对象 key-value 对一对一对的 encode
        [aCoder encodeObject:value forKey:ivarName];
    }
    
    // 释放 ivars
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    // 因为没有 superClass 了
    self = [self init];
    if (self != nil) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
        for (int i = 0; i < ivarCount; i ++) {
            
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 反归档, 就是把 key-value 对一对一对 decode
            id value = [aDecoder decodeObjectForKey:ivarName];
            // 赋值
            [self setValue:value forKey:ivarName];
        }
        free(ivars);
    }
    
    return self;
}

//KVC

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"不存在键_%@:%@",key,value);
//    if (DEBUG) {
//        UIApplication * app = UIApplication.sharedApplication;
//        [app.delegate.window.rootViewController showAlertTitle:@"warnning" msg:[NSString stringWithFormat:@"不存在键__%@:%@",key,value]];
//        
//    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
    
}


#pragma mark - -runtime
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames:(NSString *)clsName{
    ///存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([NSClassFromString(clsName) class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    return allNames;
}

/**
 模型转字典
 
 */
- (NSDictionary *)modelToDictionary{
    id obj = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(NSInteger i = 0;i < propsCount; i++){
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        
        id value = [obj valueForKey:propName];//kvc读值
        
//        value = value == nil ? [NSNull null] : [self handleObj:obj];
        value = !value ? [NSNull null] : [self handleObj:obj];
        [dic setObject:value forKey:propName];
        
    }
    free(props);
    return dic;
}

/**
 模型转JSON
 
 */
- (NSString *)modelToJSONWithError:(NSError **)error{
    id obj = self;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self handleObj:obj] options:NSJSONWritingPrettyPrinted error:error];
    NSString *jsonText = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonText;
}

/**
 自定义处理数组，字典，其他类
 
 */
- (id)handleObj:(id)obj{
    //类型
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]){
        return obj;
        
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objArr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objArr.count];
        for(NSInteger i = 0;i < objArr.count; i++){
            //            [arr setObject:[self handleObj:objArr[i]] atIndexedSubscript:i];
            [arr addObject:[self handleObj:objArr[i]]];
        }
        return arr;
        
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *objDic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objDic count]];
        for(NSString *key in objDic.allKeys){
            [dic setObject:[self handleObj:objDic[key]] forKey:key];
            
        }
        return dic;
        
    }
    return [self modelToDictionary];
}


#pragma mark - -dispatchAsyncMain

void dispatchAsyncMain(void(^block)(void)){
//    dispatch_async(dispatch_get_main_queue(), block);
    if ([NSThread isMainThread]) {
        block();
    }
    else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void dispatchAsyncGlobal(void(^block)(void)){
    //    dispatch_async(dispatch_get_global_queue(0, 0), block);
    if (![NSThread isMainThread]) {
        block();
    }
    else{
        dispatch_async(dispatch_get_global_queue(0, 0), block);
    }
}

void dispatchAfterMain(double delay ,void(^block)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    
}

void dispatchApplyGlobal(id obj ,void(^block)(size_t index)){
    NSCAssert([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSSet class]], @"必须是集合或者NSNumber");
    if ([obj isKindOfClass:[NSNumber class]]) {
        dispatch_apply([obj unsignedIntegerValue], dispatch_get_global_queue(0, 0), block);

    }
    else{
        dispatch_apply([obj count], dispatch_get_global_queue(0, 0), block);

    }
}

#pragma mark - -validObject

-(BOOL)validObject{
//    if (self == nil) return NO;//无法捕捉
    if ([self isEqual:[NSNull null]])  return NO;
    if ([self isKindOfClass:[NSNull class]]) return NO;
    
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSAttributedString class]]){
        NSString *str = @"";
        if ([self isKindOfClass:[NSAttributedString class]]){
            str = [(NSAttributedString *)self string];
            
        } else {
            str = (NSString *)self;
            
        }
        
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:str] || [str containsString:@"null"]) {
//            NSLog(@"无效字符->(%@)",string);
           return NO;
        }
        
    }
    else if ([self isKindOfClass:[NSArray class]]){
        if ([(NSArray *)self count] == 0){
//            NSLog(@"空数组->(%@)",self);
            return NO;
        }
    }
    else if ([self isKindOfClass:[NSDictionary class]]){
        if ([(NSDictionary *)self count] == 0){
//            NSLog(@"空字典->(%@)",self);
           return NO;
        }
    }
    return YES;
}

-(NSString *)showNilText{
    NSParameterAssert([self isKindOfClass:[NSString class]]);
    return [self validObject]  ? (NSString *)self : @"--";
}


//obj转json格式字符串：
- (NSString *)JSONValue{
    NSParameterAssert([NSJSONSerialization isValidJSONObject:self]);
    
    NSString * jsonString = @"";
    if ([NSJSONSerialization isValidJSONObject:self]) {
  
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&parseError];
        if (parseError != nil) {
#ifdef DEBUG
            NSLog(@"fail to get NSData from obj: %@, error: %@", self, parseError);
#endif
        }
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    } else {
        NSLog(@"JSON数据生成失败，请检查数据格式!");
        
    }
    return jsonString;
}

-(void (^)(id, id, NSInteger))blockObject{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockObject:(void (^)(id, id, NSInteger))blockObject{
    objc_setAssociatedObject(self, @selector(blockObject), blockObject, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

#pragma mark- - 富文本
/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    // 创建文字属性
    NSDictionary * dict = @{
                            NSFontAttributeName             :   font,
                            NSForegroundColorAttributeName  :   textColor,
                            NSBackgroundColorAttributeName  :   UIColor.clearColor
                            };
    
    return dict;
    
}

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
//    paraStyle.lineSpacing = 5;//行间距
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:[self attrDictWithFont:font textColor:textColor]];
    [mdict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    return mdict;
    
}

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
    if (![text validObject]) return CGSizeZero;

    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSDictionary *attrDict = [self attrParaDictWithFont:font textColor:UIColor.blackColor alignment:NSTextAlignmentLeft];
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
        
    } else {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        
    }
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}


- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding{

//    CGFloat padding = 10;
//    CGFloat viewHeight = 30;
//    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (width - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    //
    CGSize size = CGSizeMake(width, rowCount * itemHeight + (rowCount - 1) * padding);
    return size;
}

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment{
    return [self getAttString:text textTaps:textTaps font:font tapFont:tapFont color:UIColor.blackColor tapColor:tapColor alignment:alignment];
    
}

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(UIColor *)color tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment{
    
    NSAssert(textTaps.count > 0, @"textTaps不能为空!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    // 设置段落
    NSDictionary *paraDict = [self attrParaDictWithFont:font textColor:color alignment:alignment];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];
    
    for (NSString *textTap in textTaps) {
//        NSAssert([text containsString:textTap],@"textTaps中有不被字符串包含的元素");
        
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        NSDictionary * attrDict = [self attrDictWithFont:tapFont textColor:tapColor];
        [attString addAttributes:attrDict range:range];
        
    }
    return (NSAttributedString *)attString;
}


- (NSAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(UIColor *)tapColor{
    if ([textTaps isKindOfClass:[NSString class]]) textTaps = @[textTaps];
    if (!tapColor) tapColor = UIColor.redColor;
    NSAttributedString *attString = [self getAttString:string textTaps:textTaps font:@16 tapFont:@16 tapColor:tapColor alignment:NSTextAlignmentLeft];
    return attString;
}

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}


/**
 标题前加*
 
 */
-(NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString * item in titleList) {
        NSString * title = item;
        if (![title hasPrefix:prefix]) title = [prefix stringByAppendingString:title];
        if (![marr containsObject:title]) [marr addObject:title];
        
        UIColor * colorMust = [mustList containsObject:title] ? UIColor.redColor : UIColor.clearColor;
        
        NSArray * textTaps = @[prefix];
        NSAttributedString * attString = [self getAttString:title textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
        
        if (![marr containsObject:attString]) {
            NSUInteger index = [marr indexOfObject:title];
            [marr replaceObjectAtIndex:index withObject:attString];
            
        }
    }
    return marr.copy;
    
}
/**
 单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust{
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    UIColor * colorMust = isMust ? UIColor.redColor : UIColor.clearColor;
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 (推荐)单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must{
    
    BOOL isMust = NO;
    if ([must isKindOfClass:[NSString class]]) {
//        isMust = [self stringToBool:must];
        isMust = [must isEqualToString:@"1"] ? YES : NO;

    }
    else if ([must isKindOfClass:[NSNumber class]]){
        isMust = [must boolValue];
        
    }
    else{
        NSAssert([must isKindOfClass:[NSString class]] || [must isKindOfClass:[NSNumber class]], @"请检查数据类型!");
        
    }
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    UIColor * colorMust = isMust ? UIColor.redColor : UIColor.clearColor;
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 布尔值转字符串

 */
- (NSString *)stringFromBool:(NSNumber *)boolNum {
    NSParameterAssert([boolNum boolValue]  || [boolNum boolValue] == NO);
    
    NSString *string = [boolNum boolValue]  ? @"1"  :   @"0";
    return string;

}

/**
 字符串转布尔值

 */
- (BOOL)stringToBool:(NSString *)string{
    NSAssert(([@[@"1",@"0"] containsObject:string] ), @"string值只能为1或者0");

    BOOL boolValue = [string integerValue] == 1 ? YES : NO;
    return boolValue;
}


- (BOOL)isKindOfClassList:(NSArray *)clzList{
    
    __block BOOL result = NO;
    [clzList enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([self isKindOfClass:NSClassFromString(obj)]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr{
    NSString *temp = [arr firstObject];
    for (NSString * obj in arr){
        if (obj.length > temp.length){
            temp = obj;
        }
    }
    return temp;
}


#pragma mark - -获取随机数，范围在[from,to]，包括from，包括to
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to{
    NSInteger random = [self getRandomNum:from to:to];
    return [@(random) stringValue];
}

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber{
    
    NSInteger rowCount = itemList.count % rowOfNumber == 0 ? itemList.count/rowOfNumber : (itemList.count/rowOfNumber + 1);
    return rowCount;
    
}


@end
