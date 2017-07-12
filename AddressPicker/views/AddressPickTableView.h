//
//  AddressPickTableView.h
//  ShangXin
//
//  Created by Sam on 2016/12/29.
//  Copyright © 2016年 Ding Sai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AddrObject.h"

@interface AddressPickTableView : UIView

@property (nonatomic, copy) void (^addressPickBlock)(AddrObject *object);
@property (nonatomic, strong) AddrObject *picked;
@property (nonatomic, strong) NSString *type;
- (void)refresh:(NSString *)addressId currentId:(NSString *)currentId type:(NSString *)type;
- (void)scrollToCell;

@end
