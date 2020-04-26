//
//  SCPopupUnit.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupUnit.h"

@interface SCPopupUnit ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SCPopupUnit

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup popupPriority:(NSUInteger)popupPriority showOnClass:(Class)showOnClass {
    if (self = [super init]) {
        self->_popup = popup;
        self->_popupPriority = popupPriority;
        self->_showOnClass = showOnClass;
        self->_popupUnitItem = [[SCPopupUnitItem alloc] initWithPopup:popup];
        
        if (self.request) {
            self.request();
        }
    }
    return self;
}

- (void)setRequest:(dispatch_block_t)request {
    _request = request;
    
    if (request) {
        self.request();
    }
}

- (void)setFinish:(BOOL)finish {
    if (finish) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(popupUnitNetFinish:)]) {
            [self.delegate popupUnitNetFinish:self];
        }
    }
}

@end
