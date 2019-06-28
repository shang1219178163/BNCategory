//
//  NSAttributedString+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Helper)

+ (__kindof NSAttributedString *)attrString:(NSString *)string font:(CGFloat)font alignment:(NSTextAlignment)alignment;

+ (NSAttributedString *)attrString:(NSString *)string;

+(id)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
