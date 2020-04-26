//
//  SCPopupUnit.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCPopupUnitItem.h"
#import "SCPopupProtocol.h"
#import "SCPopupUnitRequest.h"

@class SCPopupUnit;

@protocol SCPopupUnitDelegate <NSObject>

@optional

- (void)popupUnitNetFinish:(SCPopupUnit *)unit;

@end

@interface SCPopupUnit : NSObject

@property (nonatomic, strong, readonly) id<SCPopupProtocol> popup;

/// 显示的优先级
@property (nonatomic, assign, readonly) NSUInteger popupPriority;

/// 在哪个界面显示
@property (nonatomic, strong, readonly) Class showOnClass;

@property (nonatomic, strong, readonly) SCPopupUnitItem *popupUnitItem;

@property (nonatomic, copy) dispatch_block_t request;

@property (nonatomic, strong) id netData;

@property (nonatomic, copy) BOOL(^showCondition) (void);

@property (nonatomic, copy) BOOL(^showConditionRelyOnNet) (id data);

@property (nonatomic, assign) BOOL finish;

@property (nonatomic, weak) id<SCPopupUnitDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPopup:(id<SCPopupProtocol>)popup
popupPriority:(NSUInteger)popupPriority
                  showOnClass:(Class)showOnClass;

@end
