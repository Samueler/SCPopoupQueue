//
//  SCPopupScrollView.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/27.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupScrollView.h"

@interface SCPopupScrollView ()

@property (nonatomic, strong) UIView *popupContentView;

@end

@implementation SCPopupScrollView

- (instancetype)initWithPopupContentView:(UIView *)popupContentView {
    if (self = [super init]) {
        self.popupContentView = popupContentView;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    BOOL touchOnContent = CGRectContainsPoint(self.popupContentView.frame, [touch locationInView:self]);
    if (self.touchOnContent) {
        self.touchOnContent(touchOnContent);
    }
}

@end
