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

@property (nonatomic, strong, readonly) UIView *targetView;

- (instancetype)initWithTargetView:(UIView *)targetView;

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor;

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces;

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss;

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss
                      showComplete:(SCPopupAnimationComplete)showComplete
                   dismissComplete:(SCPopupAnimationComplete)dismissComplete;

@end
