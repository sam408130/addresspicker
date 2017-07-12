//
//  SXEditAddressCell.h
//  ShangXin
//
//  Created by Sam on 1/6/16.
//  Copyright © 2016 Ding Sai. All rights reserved.
//
#import <UIKit/UIKit.h>
#define kCellIdentifier_EditAddressCell @"EditAddressCell"

typedef void (^MessageBlock) (NSString *content);

@interface SXEditAddressCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, copy) MessageBlock messageBlock;

@end
