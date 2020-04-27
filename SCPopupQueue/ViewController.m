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

@interface ViewController ()

@property (nonatomic, strong) NSObject *pop1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCTestPop *pop1 = [[SCTestPop alloc] init];
    pop1.text = @"第一个pop";
    
    SCPopupUnit *unit1 = [[SCPopupUnit alloc] initWithPopup:pop1 popupPriority:4 showOnInstance:self];
    
    [SCPopupQueue.shareInstance addPopupUnit:unit1];
    
    SCTestPop *pop2 = [[SCTestPop alloc] init];
    pop2.text = @"第二个pop";
    
    SCPopupRequest *request = [[SCPopupRequest alloc] init];
    __weak typeof(request) weakRequest = request;
    request.popupRequest = ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakRequest.popupRequestFinish = YES;
                weakRequest.popupData = @"123";
            });
        });
    };
    
    request.popupShowCondition = ^BOOL(id popupData) {
      return YES;
    };
    
    SCPopupUnit *unit2 = [[SCPopupUnit alloc] initWithRequest:request popup:pop2 popupPriority:5 showOnInstance:self];
    
    [SCPopupQueue.shareInstance addPopupUnit:unit2];
    
    [SCPopupQueue.shareInstance showPopupUnits];
    
}


@end
