//
//  SCPopupUnitItem.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCPopupProtocol.h"

@interface SCPopupUnitItem : NSObject

@property (nonatomic, strong, readonly) id<SCPopupProtocol> popup;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup;

@end
