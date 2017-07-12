//
//  SXEditAddressCell.m
//  ShangXin
//
//  Created by Sam on 1/6/16.
//  Copyright © 2016 Ding Sai. All rights reserved.
//


#import "SXEditAddressCell.h"

@interface SXEditAddressCell()

@property (nonatomic, strong) UIView *backView;

@end

@implementation SXEditAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if(!_backView){
            _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
            _backView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:_backView];
            
            self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width - 20, 45)];
            self.textField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
            self.textField.textColor = [UIColor blackColor];
            [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [_backView addSubview:self.textField];
            
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreen_Width, 1)];
            line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
            [self.contentView addSubview:line];
            
        }
        
        
    }
    
    return self;
}




-(void)textFieldDidChange:(UITextField *)textField {
    
    if(_messageBlock){
        _messageBlock(textField.text);
    }
}

-(void)layoutSubviews {
    
    self.textField.text = self.info;
    
    
}


@end
