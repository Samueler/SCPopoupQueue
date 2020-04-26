//
//  SCPopupUnitRequest.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct SCPopupUnitRequestResult {
    BOOL finished;
    id data;
} SCPopupUnitRequestResult;

@interface SCPopupUnitRequest : NSObject

@property (nonatomic, assign) SCPopupUnitRequestResult result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithRequest:(void(^)(void))request;

@property (nonatomic, copy) void(^requestFinished) (SCPopupUnitRequestResult result);

@end
