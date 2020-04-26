//
//  ViewController.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "ViewController.h"
#import "SCPopupQueue.h"
#import "SCTestPop.h"
#import "SCPopupUnitRequest.h"

@interface ViewController ()

@property (nonatomic, strong) NSObject *pop1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCTestPop *pop =nil;

    
    SCPopupUnit *unit = [[SCPopupUnit alloc] initWithPopup:pop popupPriority:3 showOnClass:self.class];
    __weak typeof(unit) weakUnit = unit;
    unit.request = ^{
        __strong typeof(weakUnit) strongSelf = weakUnit;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.netData = @"xxx";
                    strongSelf.finish = YES;
                });
            });
    };
    
    unit.showConditionRelyOnNet = ^BOOL(NSString *data) {
        return data.length;
    };
    
    [SCPopupQueue.shareInstance addPopupUnit:unit];
    
    [SCPopupQueue.shareInstance showPopupUnits];
    
}


@end
