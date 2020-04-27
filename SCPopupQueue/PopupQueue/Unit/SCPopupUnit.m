//
//  SCPopupUnit.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupUnit.h"

@interface SCPopupUnit ()

@end

@implementation SCPopupUnit

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup
                popupPriority:(NSUInteger)popupPriority
                  showOnInstance:(id)showOnInstance {
    return [self initWithPopup:popup popupPriority:popupPriority showOnInstance:showOnInstance async:NO];
}

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup
                popupPriority:(NSUInteger)popupPriority
                  showOnInstance:(id)showOnInstance
                        async:(BOOL)async {
    return [self initWithRequest:nil popup:popup popupPriority:popupPriority showOnInstance:showOnInstance async:async];
}

- (instancetype)initWithRequest:(SCPopupRequest *)request
                          popup:(id<SCPopupProtocol>)popup
                  popupPriority:(NSUInteger)popupPriority
                    showOnInstance:(id)showOnInstance {
    return [self initWithRequest:request popup:popup popupPriority:popupPriority showOnInstance:showOnInstance async:NO];
}

- (instancetype)initWithRequest:(SCPopupRequest *)request
                          popup:(id<SCPopupProtocol>)popup
                  popupPriority:(NSUInteger)popupPriority
                    showOnInstance:(id)showOnInstance
                          async:(BOOL)async {
    if (self = [super init]) {
        self->_popup = popup;
        self->_popupPriority = popupPriority;
        self->_showOnInstance = showOnInstance;
        self->_request = request;
        self->_request.prepare = async;
        self->_async = async;
    }
    return self;
}

- (void)relyOn:(SCPopupUnit *)unit {
    self->_relyedOnUnit = unit;
}

- (void)deleteRelyOn:(SCPopupUnit *)unit {
    [self relyOn:nil];
}

@end
