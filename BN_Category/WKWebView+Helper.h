//
//  WKWebView+Helper.h
//  BN_Category
//
//  Created by hsf on 2018/11/1.
//

#import <WebKit/WebKit.h>

@interface WKWebView (Helper)

@property (class, nonatomic, nonnull) WKWebViewConfiguration *confiDefault;

+ (NSString *)changTextFontRatio:(CGFloat)fontRatio;

@end


