//
//  SCPopupUnit.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCPopupProtocol.h"
#import "SCPopupRequest.h"

@interface SCPopupUnit : NSObject

@property (nonatomic, strong, readonly) UIView<SCPopupProtocol> *popup;

@property (nonatomic, assign, readonly) NSUInteger popupPriority;

@property (nonatomic, strong, readonly) id showOnInstance;

@property (nonatomic, strong, readonly) SCPopupRequest *request;

@property (nonatomic, assign, readonly, getter=isAsync) BOOL async;

@property (nonatomic, strong, readonly) SCPopupUnit *relyedOnUnit;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPopup:(UIView<SCPopupProtocol> *)popup
                popupPriority:(NSUInteger)popupPriority
                  showOnInstance:(id)showOnInstance;

- (instancetype)initWithPopup:(UIView<SCPopupProtocol> *)popup
                popupPriority:(NSUInteger)popupPriority
                  showOnInstance:(Class)showOnClass
                        async:(BOOL)async;

- (instancetype)initWithRequest:(SCPopupRequest *)request
                          popup:(UIView<SCPopupProtocol> *)popup
                  popupPriority:(NSUInteger)popupPriority
                    showOnInstance:(id)showOnInstance;

- (instancetype)initWithRequest:(SCPopupRequest *)request
                          popup:(UIView<SCPopupProtocol> *)popup
                  popupPriority:(NSUInteger)popupPriority
                    showOnInstance:(id)showOnInstance
                          async:(BOOL)async;

- (void)relyOn:(SCPopupUnit *)unit;

- (void)deleteRelyOn:(SCPopupUnit *)unit;

@end
