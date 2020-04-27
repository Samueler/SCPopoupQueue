//
//  SCPopupScrollView.h
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/27.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCPopupTouchOnContent)(BOOL touchOnContent);

@interface SCPopupScrollView : UIScrollView

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithPopupContentView:(UIView *)popupContentView;

@property (nonatomic, copy) SCPopupTouchOnContent touchOnContent;

@end
