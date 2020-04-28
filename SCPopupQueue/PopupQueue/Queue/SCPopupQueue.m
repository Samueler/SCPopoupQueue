//
//  SCPopupQueue.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupQueue.h"
#import "SCPopupQueueTool.h"

static SCPopupQueue *instance = nil;

@interface SCPopupQueue () <
NSCopying,
NSMutableCopying,
SCPopupRequestDelegate
>

@property (nonatomic, strong) NSMutableArray<SCPopupUnit *> *internalUnits;

@property (nonatomic, strong) NSMutableArray *relyedOnUnits;

@end

@implementation SCPopupQueue

#pragma mark - Public Functions
- (void)addPopupUnit:(SCPopupUnit *)unit {
    [self.internalUnits addObject:unit];
    [self sortUnits];
}

- (void)showPopupUnits {
    SCPopupUnit *currentUnit = self.internalUnits.firstObject;
    if (!currentUnit) {
        return;
    }
    
    if (currentUnit.relyedOnUnit && !currentUnit.relyedOnUnit.request.popupRequestFinish) {
        return;
    }
    
    if (currentUnit.request) {
        currentUnit.request.delegate = self;
        if (!currentUnit.async) {
            currentUnit.request.prepare = YES;
        }
        
        if (!currentUnit.request.popupRequestFinish) {
            return;
        }
        
        if (currentUnit.request.requestTimeout) {
            [self deletePopUnit:currentUnit];
            
            [self showPopupUnits];
            return;
        }
        
        if (currentUnit.request.popupShowCondition) {
            BOOL conditionCorrect = currentUnit.request.popupShowCondition(currentUnit.request.popupData);
            if (!conditionCorrect) {
                [self deletePopUnit:currentUnit];
                [self showPopupUnits];
                return;
            }
        }
    }
    
    __weak typeof(currentUnit) weakCurrentUnit = currentUnit;
    currentUnit.popup.popupStateChanged = ^(SCPopupState state) {
        if (state == SCPopupStateDismiss) {
            [self deletePopUnit:weakCurrentUnit];
            [self showPopupUnits];
        }
    };
    
    SCPopupState popupCurrentState = currentUnit.popup.currentState;
    
    BOOL stateCorrect = (popupCurrentState == SCPopupStateIdle) || (popupCurrentState == SCPopupStateDismiss);
    if (!stateCorrect) {
        return;
    }
    
    BOOL onTargetClass = [SCPopupQueueTool.rootNavigationController.topViewController isEqual:currentUnit.showOnInstance];
    if (!onTargetClass) {
        return;
    }
    
    [currentUnit.popup.targetView addSubview:currentUnit.popup];
    currentUnit.popup.frame = currentUnit.popup.targetView.bounds;
    [currentUnit.popup showPopup];
}

- (void)deleteAllPopupUnits {
    [self.internalUnits enumerateObjectsUsingBlock:^(SCPopupUnit *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.request.delegate = nil;
    }];
    
    [self.internalUnits removeAllObjects];
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

- (void)deletePopUnit:(SCPopupUnit *)unit {
    if (![self.internalUnits containsObject:unit]) {
        return;
    }
    
    unit.request.delegate = nil;
    [self.internalUnits removeObject:unit];
}

#pragma mark - SCPopupRequestDelegate

- (void)popupRequest:(SCPopupRequest *)request finished:(BOOL)finished {
    if ([self.internalUnits.firstObject.request isEqual:request] && finished) {
        [self showPopupUnits];
    }
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
