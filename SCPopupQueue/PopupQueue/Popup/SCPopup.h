//
//  SCPopup.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopupProtocol.h"

typedef void (^SCPopupAnimationComplete) (BOOL finished);

@interface SCPopup : UIView <SCPopupProtocol>

@property (nonatomic, assign, readonly) BOOL bounces;

@property (nonatomic, assign, readonly) BOOL touchDismiss;

@property (nonatomic, strong, readonly) UIColor *maskColor;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)popup;

+ (instancetype)popupWithTargetView:(UIView *)targetView;

+ (instancetype)popupWithMaskColor:(UIColor *)maskColor;

+ (instancetype)popupWithBounces:(BOOL)bounces;

+ (instancetype)popupWithTouchDismiss:(BOOL)touchDismiss;

+ (instancetype)popupWithShowComplete:(SCPopupAnimationComplete)showComplete
                      dismissComplete:(SCPopupAnimationComplete)dismissComplete;

+ (instancetype)popupWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor;

+ (instancetype)popupWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces;

+ (instancetype)popupWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss;

+ (instancetype)popupWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss
                      showComplete:(SCPopupAnimationComplete)showComplete
                   dismissComplete:(SCPopupAnimationComplete)dismissComplete;

@end
