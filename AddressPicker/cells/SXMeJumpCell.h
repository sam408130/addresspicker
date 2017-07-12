//
//  SXMeJumpCell.h
//  ShangXin
//
//  Created by Sam on 2017/1/6.
//  Copyright © 2017年 Ding Sai. All rights reserved.
//
#import <UIKit/UIKit.h>
#define kCellIdentifier_MeJumpCell @"MeJumpCell"

@interface SXMeJumpCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) BOOL needStatus;

@end
