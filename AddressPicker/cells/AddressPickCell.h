//
//  AddressPickCell.h
//  ShangXin
//
//  Created by Sam on 2016/12/29.
//  Copyright © 2016年 Ding Sai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AddrObject.h"
#define kCellIdentifier_AddressPickCell @"AddressPickCell"

@interface AddressPickCell : UITableViewCell

@property (nonatomic, strong) AddrObject *object;
@property (nonatomic, assign) BOOL isSelected;

@end
