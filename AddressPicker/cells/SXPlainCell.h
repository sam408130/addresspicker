//
//  SXPlainCell.h
//  ShangXin
//
//  Created by Sam on 1/6/16.
//  Copyright © 2016 Ding Sai. All rights reserved.
//


#define kCellIdentifier_PlanCell @"PlanCell"

@interface SXPlainCell : UITableViewCell
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) UILabel *infoLabel;
@end
