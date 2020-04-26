//
//  SCPopup.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopup.h"

@implementation SCPopup

@synthesize currentState = _currentState; 

#pragma mark - SCPopupProtocol

- (void)showPopup {
    _currentState = SCPopupStateShowing;
}

- (void)dismissPopup {
    _currentState = SCPopupStateDismiss;
}

- (void)destoryPopup {
    [self.superview.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqual:self]) {
            obj = nil;
            [obj removeFromSuperview];
            _currentState = SCPopupStateDestoryed;
        }
    }];
}

@end
