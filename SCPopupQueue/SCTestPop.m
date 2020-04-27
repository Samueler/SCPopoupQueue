//
//  SCTestPop.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCTestPop.h"

@interface SCTestPop ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SCTestPop

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (void)showPopup {
    [super showPopup];
    NSLog(@"showPopup");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissPopup];
    });
}

@end
