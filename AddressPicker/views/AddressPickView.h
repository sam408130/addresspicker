//
//  AddressPickView.h
//  ShangXin
//
//  Created by Sam on 2016/12/29.
//  Copyright © 2016年 Ding Sai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Address.h"

@interface AddressPickView : UIView

@property (nonatomic, copy) void (^confirmBlock)(Address *address);
@property (nonatomic, strong) Address *address;
- (instancetype)init:(Address *)address;
- (void)refreshWithAddress:(Address *)address;
@end
