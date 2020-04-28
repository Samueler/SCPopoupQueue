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

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (UIView *)popupContentView {
    
    UIView *white = [[UIView alloc] init];
    white.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor redColor];
    [white addSubview:label];
    self.label = label;
    
    return white;
}

- (CGSize)popupContentSize {
    return CGSizeMake(300, 100);
}

@end
