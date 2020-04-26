//
//  SCPopupUnitItem.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupUnitItem.h"

@implementation SCPopupUnitItem

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup {
    if (self = [super init]) {
        self->_popup = popup;
    }
    return self;
}

@end
