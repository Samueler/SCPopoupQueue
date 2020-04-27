//
//  SCPopup.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopup.h"
#import "SCPopupScrollView.h"

@interface SCPopup ()

@property (nonatomic, copy) SCPopupAnimationComplete _showComplete;
@property (nonatomic, copy) SCPopupAnimationComplete _dismissComplete;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) SCPopupScrollView *scrollView;

@end

@implementation SCPopup

@synthesize currentState = _currentState;
@synthesize popupStateChanged = _popupStateChanged;

#pragma mark - Public Functions

- (instancetype)init {
    if (self = [super init]) {
        self->_targetView = UIApplication.sharedApplication.delegate.window;
        self->_maskColor = [SCPopup popupMaskColor];
        self->_bounces = NO;
        self->_touchDismiss = NO;
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithTargetView:(UIView *)targetView {
    return [self initWithTargetView:targetView maskColor:nil];
}

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor {
    return [self initWithTargetView:targetView maskColor:maskColor bounces:NO];
}

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces {
    return [self initWithTargetView:targetView maskColor:maskColor bounces:bounces touchDismiss:NO];
}

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss {
    return [self initWithTargetView:targetView maskColor:maskColor bounces:bounces touchDismiss:touchDismiss showComplete:nil dismissComplete:nil];
}

- (instancetype)initWithTargetView:(UIView *)targetView
                         maskColor:(UIColor *)maskColor
                           bounces:(BOOL)bounces
                      touchDismiss:(BOOL)touchDismiss
                      showComplete:(SCPopupAnimationComplete)showComplete
                   dismissComplete:(SCPopupAnimationComplete)dismissComplete {
    if (self = [super init]) {
        self->_targetView = targetView;
        if (!maskColor) {
            maskColor = [SCPopup popupMaskColor];
        }
        
        self->_maskColor = maskColor;
        self->_bounces = bounces;
        self->_touchDismiss = touchDismiss;
        self._showComplete = [showComplete copy];
        self._dismissComplete = [dismissComplete copy];
        
        [self commonInit];
    }
    return self;
}

- (void)showPopup {
    _currentState = SCPopupStateShowing;
    if (self.popupStateChanged) {
        self.popupStateChanged(_currentState);
    }
}

- (void)dismissPopup {
    _currentState = SCPopupStateDismiss;
    
    if (self.popupStateChanged) {
        self.popupStateChanged(_currentState);
    }
    
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

#pragma mark - Private Functions

- (void)commonInit {
    [self checkPopupContentViewValid];
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    self.scrollView.frame = self.bounds;
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

#pragma mark - Lazy Load

- (SCPopupScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[SCPopupScrollView alloc] initWithPopupContentView:self.contentView];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = NO;
        _scrollView.contentSize = self.contentSize;
        
        __weak typeof(self) weakSelf = self;
        _scrollView.touchOnContent = ^(BOOL touchOnContent) {
            if (weakSelf.touchDismiss && !touchOnContent) {
                [weakSelf dismissPopup];
            }
        };
    }
    return _scrollView;
}

@end
