//
//  SCPopupProtocol.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SCPopupState) {
    SCPopupStateIdle,
    SCPopupStateShowing,
    SCPopupStateDismiss
};

@protocol SCPopupProtocol <NSObject>

@property (nonatomic, assign, readonly) SCPopupState currentState;

@property (nonatomic, copy) void(^popupStateChanged) (SCPopupState state);

- (void)showPopup;

- (void)dismissPopup;

- (UIView *)popupContentView;

- (CGSize)popupContentSize;

@end
