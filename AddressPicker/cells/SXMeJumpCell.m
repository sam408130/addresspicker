//
//  SXMeJumpCell.m
//  ShangXin
//
//  Created by Sam on 2017/1/6.
//  Copyright © 2017年 Ding Sai. All rights reserved.
//
//
//  SXMeJumpCell.m
//  ShangXin
//
//  Created by Sam on 1/8/16.
//  Copyright © 2016 Ding Sai. All rights reserved.
//


#import "SXMeJumpCell.h"


@interface SXMeJumpCell()

@property (nonatomic, strong) UILabel *titleLable,*statusLabel;

@end

@implementation SXMeJumpCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if(!_titleLable){
            self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 45)];
            self.titleLable.font = [UIFont systemFontOfSize:14];
            self.titleLable.textAlignment = NSTextAlignmentLeft;
            [self.titleLable setCenterY:45/2];
            self.titleLable.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1];
            [self.contentView addSubview:self.titleLable];
            
            
            self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLable.frame) + 10, 13, 250, 15)];
            self.statusLabel.font = [UIFont systemFontOfSize:14];
            self.statusLabel.textAlignment = NSTextAlignmentLeft;
            self.statusLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:self.statusLabel];
            
            UIImageView *rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width - 19.8 - 8.2, 0, 8.2, 15)];
            rightIcon.image = [UIImage imageNamed:@"icon_right_arrow_gray"];
            [rightIcon setCenterY:45/2];
            [self.contentView addSubview:rightIcon];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreen_Width, 1)];
            line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
            [self.contentView addSubview:line];
        }
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = _title;
    [self.statusLabel setX:CGRectGetMaxX(self.titleLable.frame) + 10];
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
    self.statusLabel.text = subtitle;
    
}

@end
