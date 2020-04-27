//
//  SCPopupQueue.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCPopupUnit.h"

@interface SCPopupQueue : NSObject

@property (nonatomic, strong, readonly) NSArray<SCPopupUnit *> *allUnits;

+ (instancetype)shareInstance;

- (void)addPopupUnit:(SCPopupUnit *)unit;

- (void)showPopupUnits;

- (void)deleteAllPopupUnits;

@end
