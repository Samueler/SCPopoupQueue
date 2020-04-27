//
//  SCPopupRequest.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/27.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupRequest.h"

@implementation SCPopupRequest

- (instancetype)init {
    if (self = [super init]) {
        _timeoutInterval = 5;
    }
    return self;
}

#pragma mark - Private Functions

- (void)prepareRequest {
    if (self.popupRequest && self.prepare && !self.popupRequestFinish) {
        
        self.popupRequest();
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeoutInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.popupRequestFinish) {
                self->_requestTimeout = YES;
                self.popupRequestFinish = YES;
            }
        });
    }
}

#pragma mark - Setter

- (void)setPopupRequest:(void (^)(void))popupRequest {
    _popupRequest = popupRequest;
    [self prepareRequest];
}

- (void)setPrepare:(BOOL)prepare {
    _prepare = prepare;
    
    [self prepareRequest];
}

- (void)setPopupData:(id)popupData {
    _popupData = popupData;
}

- (void)setPopupRequestFinish:(BOOL)popupRequestFinish {
    _popupRequestFinish = popupRequestFinish;
    
    if (popupRequestFinish) {
        if (self.popupShowCondition) {
            self.popupShowCondition(self.popupData);
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupRequest:finished:)]) {
        [self.delegate popupRequest:self finished:popupRequestFinish];
    }
}

@end
