//
//  CALayer+Helper.h
//  BNAlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Helper)

- (void)getLayer;

- (void)removeAllSubLayers;

+ (CALayer *)createRect:(CGRect)rect image:(id)image;

- (CAShapeLayer *)createCircleLayer;

- (CAShapeLayer *)createAppCircleProgressWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

- (CAShapeLayer *)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key anchorPoint:(CGPoint)anchorPoint;

- (void)addAnimationDefaultWithType:(NSNumber *)type;

- (void)addAnimationFadeDuration:(float)duration functionName:(CAMediaTimingFunctionName)functionName;

- (void)addAnimationFadeDuration:(float)duration;

- (void)addAnimationRotation;

- (CAShapeLayer *)addAnimMask:(NSString *)animKey;
- (CAShapeLayer *)addAnimPackup:(NSString *)animKey;
- (CAShapeLayer *)addAnimLoading:(NSString *)animKey duration:(CFTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
