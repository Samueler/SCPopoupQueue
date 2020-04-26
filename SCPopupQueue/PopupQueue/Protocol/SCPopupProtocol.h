//
//  SCPopupProtocol.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SCPopupState) {
    SCPopupStateIdle,
    SCPopupStateShowing,
    SCPopupStateDismiss,
    SCPopupStateDestoryed
};

@protocol SCPopupProtocol <NSObject>

@property (nonatomic, assign, readonly) SCPopupState currentState;

@optional

- (void)showPopup;

- (void)dismissPopup;

- (void)destoryPopup;

@end
