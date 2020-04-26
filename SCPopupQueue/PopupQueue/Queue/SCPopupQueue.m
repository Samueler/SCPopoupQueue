//
//  SCPopupQueue.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupQueue.h"
#import "SCPopupQueueTool.h"

static SCPopupQueue *instance =  nil;

@interface SCPopupQueue () <
NSCopying,
NSMutableCopying,
SCPopupUnitDelegate
>

@property (nonatomic, strong) NSMutableArray<SCPopupUnit *> *internalUnits;

@end

@implementation SCPopupQueue

#pragma mark - Public Functions
- (void)addPopupUnit:(SCPopupUnit *)unit {
    [self.internalUnits addObject:unit];
    [self sortUnits];
}

- (void)showPopupUnits {
    SCPopupUnit *currentUnit = self.internalUnits.firstObject;
    currentUnit.delegate = self;
    if (!currentUnit) {
        return;
    }
    
    BOOL canShow = currentUnit.popupUnitItem.popup.currentState == SCPopupStateIdle;
    BOOL onTargetClass = [SCPopupQueueTool.topViewController isKindOfClass:currentUnit.showOnClass];
    canShow = canShow && onTargetClass;
    
    if (currentUnit.showCondition) {
        canShow = canShow && currentUnit.showCondition();
    }
    
    BOOL result = currentUnit.showConditionRelyOnNet(currentUnit.netData);
    if (!result) {
        return;
    }
    canShow = canShow && result;
    
    if (canShow) {
        [currentUnit.popupUnitItem.popup showPopup];
    } else {
        [self.internalUnits removeObject:currentUnit];
        
        [self showPopupUnits];
    }
}

- (void)popupUnitNetFinish:(SCPopupUnit *)unit {
    if ([self.internalUnits.firstObject isEqual:unit]) {
        [self showPopupUnits];
    }
}

#pragma mark - Private Functions

- (void)sortUnits {
    [self.internalUnits sortUsingComparator:^NSComparisonResult(SCPopupUnit *obj1, SCPopupUnit *obj2) {
        if (obj1.popupPriority > obj2.popupPriority) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

#pragma mark - Singleton

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return instance;
}

#pragma mark - Getter

- (NSArray<SCPopupUnit *> *)allUnits {
    return self.internalUnits.copy;
}

#pragma mark - Lazy Load

- (NSMutableArray<SCPopupUnit *> *)internalUnits {
    if (!_internalUnits) {
        _internalUnits = [NSMutableArray array];
    }
    return _internalUnits;
}

@end
