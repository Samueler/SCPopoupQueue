//
//  SCPopupRequest.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/27.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCPopupRequest;

@protocol SCPopupRequestDelegate <NSObject>

- (void)popupRequest:(SCPopupRequest *)request finished:(BOOL)finished;

@end

@interface SCPopupRequest : NSObject

@property (nonatomic, assign) BOOL prepare;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, assign, readonly) BOOL requestTimeout;

@property (nonatomic, strong) id popupData;

@property (nonatomic, assign) BOOL popupRequestFinish;

@property (nonatomic, copy) void(^popupRequest) (void);

@property (nonatomic, copy) BOOL(^popupShowCondition) (id popupData);

@property (nonatomic, weak) id<SCPopupRequestDelegate> delegate;

@end
