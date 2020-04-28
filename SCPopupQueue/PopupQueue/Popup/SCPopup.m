//
//  SCPopup.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopup.h"
#import "SCPopupScrollView.h"

static NSString *const KSCPopupShowAniationKey = @"KSCPopupShowAniationKey";
static NSString *const KSCPopupDismissAniationKey = @"KSCPopupDismissAniationKey";

@interface SCPopup () <CAAnimationDelegate>

@property (nonatomic, copy) SCPopupAnimationComplete _showComplete;
@property (nonatomic, copy) SCPopupAnimationComplete _dismissComplete;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) SCPopupScrollView *scrollView;
@property (nonatomic, strong) CAAnimation *internalShowAnimation;
@property (nonatomic, strong) CAAnimation *internalDismissAnimation;

@end

@implementation SCPopup

@synthesize targetView = _targetView;
@synthesize currentState = _currentState;
@synthesize popupStateChanged = _popupStateChanged;

#pragma mark - Public Functions

+ (instancetype)popup {
    return [self popupWithTargetView:nil];
}

+ (instancetype)popupWithTargetView:(UIView *)targetView {
    return [self popupWithTargetView:targetView maskColor:nil];
}

+ (instancetype)popupWithMaskColor:(UIColor *)maskColor {
    return [self popupWithTargetView:nil maskColor:maskColor];
}

+ (instancetype)popupWithBounces:(BOOL)bounces {
    return [self popupWithTargetView:nil maskColor:nil bounces:bounces];
}

+ (instancetype)popupWithTouchDismiss:(BOOL)touchDismiss {
    return [self popupWithTargetView:nil maskColor:nil bounces:NO touchDismiss:touchDismiss];
}

+ (instancetype)popupWithShowComplete:(SCPopupAnimationComplete)showComplete
                      dismissComplete:(SCPopupAnimationComplete)dismissComplete {
    return [self popupWithTargetView:nil maskColor:nil bounces:NO touchDismiss:NO showComplete:showComplete dismissComplete:dismissComplete];
}

+ (instancetype)popupWithTargetView:(UIView *)targetView maskColor:(UIColor *)maskColor {
    return [self popupWithTargetView:targetView maskColor:maskColor bounces:NO];
}

+ (instancetype)popupWithTargetView:(UIView *)targetView maskColor:(UIColor *)maskColor bounces:(BOOL)bounces {
    return [self popupWithTargetView:targetView maskColor:maskColor bounces:bounces touchDismiss:NO];
}

+ (instancetype)popupWithTargetView:(UIView *)targetView
                          maskColor:(UIColor *)maskColor
                            bounces:(BOOL)bounces
                       touchDismiss:(BOOL)touchDismiss {
    return [self popupWithTargetView:targetView maskColor:maskColor bounces:bounces touchDismiss:touchDismiss showComplete:nil dismissComplete:nil];
}

+ (instancetype)popupWithTargetView:(UIView *)targetView
                          maskColor:(UIColor *)maskColor
                            bounces:(BOOL)bounces
                       touchDismiss:(BOOL)touchDismiss
                       showComplete:(SCPopupAnimationComplete)showComplete
                    dismissComplete:(SCPopupAnimationComplete)dismissComplete {
    if (!targetView) {
        targetView = UIApplication.sharedApplication.delegate.window;
    }
    
    if (!maskColor) {
        maskColor = [self popupMaskColor];
    }
    
    SCPopup *popup = [[self alloc] initWithFrame:targetView.frame];
    popup->_targetView = targetView;
    popup->_maskColor = maskColor;
    popup->_bounces = bounces;
    popup->_touchDismiss = touchDismiss;
    popup->__showComplete = [showComplete copy];
    popup->__dismissComplete = [dismissComplete copy];
    
    [popup commonInit];
    return popup;
}

- (void)showPopup {
    if (_currentState == SCPopupStateShowing) {
        return;
    }
    
    [self.contentView.layer removeAllAnimations];
    self.internalShowAnimation = [self popupShowAnimation];
    
    if (self.internalShowAnimation) {
        [self.contentView.layer addAnimation:self.internalShowAnimation forKey:KSCPopupShowAniationKey];
        self.internalShowAnimation.delegate = self;
        return;
    }
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -(self.frame.size.height + self.contentSize.height) * 0.5);
    } completion:^(BOOL finished) {
        if (self._showComplete) {
            self._showComplete(finished);
        }
        
        if (finished) {
            self->_currentState = SCPopupStateShowing;
            
            if (self.popupStateChanged) {
                self.popupStateChanged(self->_currentState);
            }
        }
    }];
}

- (void)dismissPopup {
    if (_currentState == SCPopupStateDismiss) {
        return;
    }
    
    [self.contentView.layer removeAllAnimations];
    self.internalDismissAnimation = [self popupDismissAnimation];
    if (self.internalDismissAnimation) {
        self.internalDismissAnimation.delegate = self;
        [self.contentView.layer addAnimation:self.internalDismissAnimation forKey:KSCPopupDismissAniationKey];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (self._dismissComplete) {
            self._dismissComplete(finished);
        }
        
        if (finished) {
            
            self->_currentState = SCPopupStateDismiss;
            
            if (self.popupStateChanged) {
                self.popupStateChanged(self->_currentState);
            }
            
            [self removePopupInstance];
        }
    }];

}

- (void)removePopupInstance {
    [self.targetView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqual:self]) {
            [obj removeFromSuperview];
            obj = nil;
        }
    }];
}

- (UIView *)popupContentView {
    return nil;
}

- (CGSize)popupContentSize {
    return CGSizeZero;
}

- (CAAnimation *)popupShowAnimation {
    return nil;
}

- (CAAnimation *)popupDismissAnimation {
    return nil;
}

#pragma mark - Private Functions

- (void)commonInit {
    [self checkPopupContentViewValid];
    
    self.backgroundColor = self.maskColor;
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    self.scrollView.frame = self.targetView.bounds;
    self.contentView.frame = (CGRect) {CGPointMake((self.bounds.size.width - self.contentSize.width) * 0.5, self.bounds.size.height), self.contentSize};
}

- (void)checkPopupContentViewValid {
    self.contentView = [self popupContentView];
    NSAssert(self.contentView, @"Please setup popup's content view, it must not be nil!");
    
    self.contentSize = [self popupContentSize];
    NSAssert(!CGSizeEqualToSize(self.contentSize, CGSizeZero), @"Please setup popup's contentSize correctly!");
}

+ (UIColor *)popupMaskColor {
    return [UIColor colorWithWhite:0 alpha:0.5];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSArray<NSString *> *animationKeys = self.contentView.layer.animationKeys;
    if ([animationKeys.firstObject isEqualToString:KSCPopupShowAniationKey]) {
        if (self._showComplete) {
            // avoid objc doesn't release.
            self.internalShowAnimation.delegate =  nil;
            self._showComplete(flag);
        }
        
        if (flag) {
            _currentState = SCPopupStateShowing;
            
            if (self.popupStateChanged) {
                self.popupStateChanged(_currentState);
            }
        }
    }
    
    if ([animationKeys.firstObject isEqualToString:KSCPopupDismissAniationKey]) {
        if (self._dismissComplete) {
            
            // avoid objc doesn't release.
            self.internalDismissAnimation.delegate = nil;
            [self.contentView.layer removeAllAnimations];
            
            self._dismissComplete(flag);
        }
        
        if (flag) {
            
            _currentState = SCPopupStateDismiss;
            
            if (self.popupStateChanged) {
                self.popupStateChanged(_currentState);
            }
            
            [self removePopupInstance];
        }
    }
}

#pragma mark - Lazy Load

- (SCPopupScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[SCPopupScrollView alloc] initWithPopupContentView:self.contentView];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = _bounces;
        
        CGFloat contentHeight = self.contentSize.height;
        if (self.contentSize.height <= self.frame.size.height && _bounces) {
            contentHeight = 1.f + self.frame.size.height;
        }
            
        self.scrollView.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
        
        __weak typeof(self) weakSelf = self;
        _scrollView.touchOnContent = ^(BOOL touchOnContent) {
            if (weakSelf.touchDismiss && !touchOnContent) {
                [weakSelf dismissPopup];
            }
        };
    }
    return _scrollView;
}

#pragma mark - Dealloc

- (void)dealloc {
    self.internalShowAnimation.delegate = nil;
    self.internalDismissAnimation.delegate = nil;
    [self.contentView.layer removeAllAnimations];
    self.internalShowAnimation = nil;
    self.internalDismissAnimation = nil;
}

@end
