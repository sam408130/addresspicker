//
//  AddressPickView.m
//  ShangXin
//
//  Created by Sam on 2016/12/29.
//  Copyright © 2016年 Ding Sai. All rights reserved.
//

#import "AddressPickView.h"
#import "AddressPickTableView.h"
#import "AddrObject.h"


@interface AddressPickView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *headScrollView, *contentScrollView;
@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *provinceLabel, *cityLabel, *districtLabel;
@property (nonatomic, strong) AddressPickTableView *proviceTable, *cityTable, *districtTable;


@end

@implementation AddressPickView

- (instancetype)init:(Address *)address {
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 746/2);
        self.backgroundColor = [UIColor whiteColor];
        self.address = address;
        [self initHeadScroll];
        [self initContentScroll];
        [self refresh];
        
    }
    return self;
}

- (void)refreshWithAddress:(Address *)address {
    self.address = address;
    [self updateHead];
    [self refresh];
}


- (void)refresh {
    
    [self.proviceTable refresh:nil currentId:self.address.provinceId type:@"province"];
    [self.cityTable refresh:self.address.provinceId currentId:self.address.cityId type:@"city"];
    [self.districtTable refresh:self.address.cityId currentId:self.address.distId type:@"district"];
    
}




- (void)initHeadScroll{
    
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 0, kScreen_Width - 30,45)];
    self.headScrollView.showsHorizontalScrollIndicator = NO;
    self.headScrollView.showsVerticalScrollIndicator = NO;
    self.headScrollView.pagingEnabled = NO;
    self.headScrollView.scrollsToTop = NO;
    self.headScrollView.bounces = YES;
    self.headScrollView.directionalLockEnabled = YES;
    [self addSubview:self.headScrollView];
    
    self.provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
    self.provinceLabel.textColor = [UIColor blackColor];
    self.provinceLabel.userInteractionEnabled = YES;
    self.provinceLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(proviceTapped)];
    [self.provinceLabel addGestureRecognizer:tap1];
    [self.headScrollView addSubview:self.provinceLabel];
    
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100,45)];
    self.cityLabel.textColor = [UIColor blackColor];
    self.cityLabel.userInteractionEnabled = YES;
    self.cityLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityTapped)];
    [self.cityLabel addGestureRecognizer:tap2];
    [self.headScrollView addSubview:self.cityLabel];
    
    self.districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100,45)];
    self.districtLabel.textColor = [UIColor blackColor];
    self.districtLabel.userInteractionEnabled = YES;
    self.districtLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(districtTapped)];
    [self.districtLabel addGestureRecognizer:tap3];
    [self.headScrollView addSubview:self.districtLabel];
    
    

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45-1, kScreen_Width, 1)];
    line.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [self addSubview:line];
    
    self.underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
    self.underLine.backgroundColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:60/255.0 alpha:1];;
    [line addSubview:self.underLine];
    
    [self updateHead];

}

- (void)updateUnderLine{
    
    switch (self.currentIndex) {
        case 0:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.underLine setX:(self.provinceLabel.x + 30)];
                [self.underLine setWidth:self.provinceLabel.width];
            }];

            break;
        }
        case 1:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.underLine setX:(self.cityLabel.x + 30)];
                [self.underLine setWidth:self.cityLabel.width];
            }];

            break;
        }
        case 2:{
            [UIView animateWithDuration:0.3 animations:^{
                [self.underLine setX:(self.districtLabel.x + 30)];
                [self.underLine setWidth:self.districtLabel.width];
            }];

            break;
        }
    }

}

- (void)proviceTapped {
    
    if(self.currentIndex != 0){
        self.currentIndex = 0;
        [self updateUnderLine];
        [self didSelect:0];
    }
}

- (void)cityTapped{
    if(self.currentIndex != 1){
        self.currentIndex = 1;
        [self updateUnderLine];
        [self didSelect:1];
    }
    
}

- (void)districtTapped {
    if(self.address.districtName){
        if(self.currentIndex != 2){
            self.currentIndex = 2;
            [self updateUnderLine];
            [self didSelect:2];
        }
    }
}

- (void)didSelect:(NSInteger)index{
    
    [self.contentScrollView setContentOffset:CGPointMake(index*kScreen_Width, 0) animated:YES];
    switch (index) {
        case 0:{
            [self.proviceTable scrollToCell];
            break;
        }
        case 1:{
            [self.cityTable scrollToCell];
            break;
        }
        case 2:{
            [self.districtTable scrollToCell];
            break;
        }
    }
}

- (void)updateHead{
    CGFloat x = 0;
    CGFloat width = 0;
    if(self.address.provinceId){
        self.currentIndex = 1;
        self.provinceLabel.text = self.address.provinceName;
        [self.provinceLabel updateWidth];
        width = self.provinceLabel.width;
        x += width + 60;
    
        if(self.address.cityId){
            self.currentIndex = 2;
            self.cityLabel.text = self.address.cityName;
            [self.cityLabel updateWidth];
            [self.cityLabel setX:x];
            width = self.cityLabel.width;
            x += width + 60;
            
            if(self.address.distId){
                self.districtLabel.text = self.address.districtName;
                [self.districtLabel updateWidth];
                [self.districtLabel setX:x];
                width = self.districtLabel.width;
            }else{
                self.districtLabel.text = @"请选择";
                [self.districtLabel updateWidth];
                [self.districtLabel setX:x];
                width = self.districtLabel.width;
            }
            
        }else{
            
            self.cityLabel.text = @"请选择";
            [self.cityLabel updateWidth];
            [self.cityLabel setX:x];
            width = self.cityLabel.width;
            
            [self.districtLabel setX:(CGRectGetMaxX(self.cityLabel.frame) + 60)];
            [self.districtLabel setWidth:0];
            
        }
    
    
    }else{
        self.currentIndex = 0;
        self.provinceLabel.text = @"请选择";
        [self.provinceLabel updateWidth];
        width = self.provinceLabel.width;
        
        [self.cityLabel setX:CGRectGetMaxX(self.provinceLabel.frame) + 60];
        [self.cityLabel setWidth:0];
        
        [self.districtLabel setX:(CGRectGetMaxX(self.cityLabel.frame) + 60)];
        [self.districtLabel setWidth:0];
        
    }
    
    [self.underLine setX:x+30];
    [self.underLine setWidth:width];
    
    self.headScrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.districtLabel.frame), 45);
}

- (void)initContentScroll{
    
    __weak typeof(self) weakSelf = self;
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, 659/2)];
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.scrollsToTop = NO;
    self.contentScrollView.bounces = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.directionalLockEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake(kScreen_Width * 3, 659/2);
    [self addSubview:self.contentScrollView];
    
    self.proviceTable = [[AddressPickTableView alloc] init];
    self.proviceTable.frame = CGRectMake(0, 0, kScreen_Width, 659/2);
    self.proviceTable.type = @"provice";
    [self.contentScrollView addSubview:self.proviceTable];
    self.proviceTable.addressPickBlock = ^(AddrObject *object){
        if(![object.addrId isEqualToString:weakSelf.address.provinceId]){
            weakSelf.address = [[Address alloc] init];
            weakSelf.address.provinceId = object.addrId;
            weakSelf.address.provinceName = object.addrName;
            weakSelf.address.cityId = nil;
            weakSelf.address.cityName = nil;
            weakSelf.address.distId = nil;
            weakSelf.address.districtName =nil;
            [weakSelf updateHead];
            [weakSelf.cityTable refresh:weakSelf.address.provinceId currentId:nil type:@"city"];
            
            [weakSelf didSelect:1];
        }
    };
    
    self.cityTable = [[AddressPickTableView alloc] init];
    self.cityTable.frame = CGRectMake(kScreen_Width, 0, kScreen_Width, 659/2);
    self.cityTable.type = @"city";
    [self.contentScrollView addSubview:self.cityTable];
    self.cityTable.addressPickBlock = ^(AddrObject *object){
        if(![object.addrId isEqualToString:weakSelf.address.cityId]){
            weakSelf.address.cityId = object.addrId;
            weakSelf.address.cityName = object.addrName;
            weakSelf.address.distId = nil;
            weakSelf.address.districtName =nil;
            [weakSelf updateHead];
            [weakSelf.districtTable refresh:weakSelf.address.cityId currentId:nil type:@"district"];
            
            [weakSelf didSelect:2];
        }
    };
    
    self.districtTable = [[AddressPickTableView alloc] init];
    self.districtTable.frame = CGRectMake(kScreen_Width * 2, 0, kScreen_Width, 659/2);
    self.districtTable.type = @"district";
    [self.contentScrollView addSubview:self.districtTable];
    self.districtTable.addressPickBlock = ^(AddrObject *object){
        //确认选择
        weakSelf.address.distId = object.addrId;
        weakSelf.address.districtName = object.addrName;
        [weakSelf updateHead];
        if(weakSelf.confirmBlock){
            weakSelf.confirmBlock(weakSelf.address);
        }
    };
    
    [self.contentScrollView setContentOffset:CGPointMake(self.currentIndex*kScreen_Width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (self.currentIndex != index) {
        self.currentIndex = index;
        [self updateUnderLine];
    }
}




@end
