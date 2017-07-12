//
//  SXPlainCell.m
//  ShangXin
//
//  Created by Sam on 1/6/16.
//  Copyright © 2016 Ding Sai. All rights reserved.
//


#import "SXPlainCell.h"


@interface SXPlainCell()

@property (nonatomic, strong) UIView *backView;

@end


@implementation SXPlainCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if(!_backView){
            _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
            _backView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:_backView];
            
            
            self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width - 20, 45)];
            self.infoLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
            self.infoLabel.textColor = [UIColor blackColor];
            
            [_backView addSubview:self.infoLabel];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreen_Width, 1)];
            line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
            [self.contentView addSubview:line];
            
        }
        
        
    }
    
    return self;
}


-(void)setInfo:(NSString *)info{
    _info = info;
    self.infoLabel.text = _info;
}

@end
