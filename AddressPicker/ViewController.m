//
//  ViewController.m
//  AddressPicker
//
//  Created by Sam on 2017/7/12.
//  Copyright © 2017年 http://www.jianshu.com/u/a6249cca0aaf. All rights reserved.
//


#import "ViewController.h"
#import "SXEditAddressCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "Address.h"
#import "SXPlainCell.h"
#import "SXMeJumpCell.h"
#import "AddressPickView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property(nonatomic, strong) TPKeyboardAvoidingTableView *mytableView;
@property(nonatomic, strong) Address *address;
@property(nonatomic, assign) BOOL isEditing;
@property(nonatomic, strong) AddressPickView *addressPickView;
@property(nonatomic, strong) UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建收货地址";
    self.address = [[Address alloc] init];
    [self initTable];
    //底部确定按钮
    [self setBottomView];
    //初始化地址选择模块
    [self handlebackView];
}

- (void)initTable{
    _mytableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[SXEditAddressCell class] forCellReuseIdentifier:kCellIdentifier_EditAddressCell];
        [tableView registerClass:[SXPlainCell class] forCellReuseIdentifier:kCellIdentifier_PlanCell];
        [tableView registerClass:[SXMeJumpCell class] forCellReuseIdentifier:kCellIdentifier_MeJumpCell];
        [self.view addSubview:tableView];
        tableView;
    });
}

- (void)handlebackView {
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.39;
    self.backView.hidden = YES;
    [self.view addSubview:self.backView];
    UITapGestureRecognizer *blurviewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurViewTaped:)];
    [self.backView addGestureRecognizer:blurviewTap];
    __weak typeof(self) weakSelf = self;
    self.addressPickView = [[AddressPickView alloc] init:self.address];
    self.addressPickView.confirmBlock = ^(Address *address){
        address.userName = weakSelf.address.userName;
        address.phone = weakSelf.address.phone;
        address.address = weakSelf.address.address;
        weakSelf.address = address;
        [weakSelf hideSelectView];
        [weakSelf.mytableView reloadData];
    };
    [self.view addSubview:self.addressPickView];
}

- (void)jumpToSelectView{
    [UIView animateWithDuration:0.6 animations:^{
        self.backView.hidden = NO;
        [self.addressPickView setY:(kScreen_Height - 746/2)];
    }completion:^(BOOL finish){
        
    }];
}

- (void)hideSelectView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.hidden = YES;
        [self.addressPickView setY:kScreen_Height];
    }completion:^(BOOL finish){
        
    }];
}

- (void)blurViewTaped:(id)sender{
    [self hideSelectView];
}

- (void)setBottomView{
    UIButton *bottom  = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreen_Height - 50, kScreen_Width -20, 40)];
    bottom.backgroundColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:60/255.0 alpha:1];
    bottom.layer.masksToBounds =YES;
    bottom.layer.cornerRadius = 4;
    [bottom setTitle:@"保存" forState:UIControlStateNormal];
    bottom.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottom addTarget:self action:@selector(bottomViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottom];
}

- (void)bottomViewClicked{
    if(self.address.userName.length == 0){
        [self.view showError:@"请填写收货人姓名"];
    }else if(self.address.phone.length == 0){
        [self.view showError:@"请填写手机号"];
    }else if(!self.address.provinceId){
        [self.view showError:@"请选择省份城市"];
    }else if(self.address.address.length == 0){
        [self.view showError:@"请填写详细收获地址"];
    }else{
        [self.view showSuccess:@"地址创建成功"];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 2){
        SXMeJumpCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MeJumpCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.address.provinceId){
            cell.title = [NSString stringWithFormat:@"%@%@%@",self.address.provinceName,self.address.cityName,self.address.districtName];
        }else{
            cell.title =  self.address.cityStr.length > 0 ? self.address.cityStr : @"省份城市";
        }
        return cell;
    }else{
        SXEditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_EditAddressCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        __weak typeof(self) weakSelf = self;
        switch (indexPath.row) {
            case 0:{
                if(self.address.userName.length > 0){
                    cell.info = self.address.userName;
                }else{
                    cell.textField.placeholder = @"收货人姓名";
                }
                cell.messageBlock = ^(NSString *info){
                    weakSelf.address.userName = info;
                };
                break;
            }
            case 1:{
                if(self.address.phone.length > 0){
                    cell.info= self.address.phone;
                }else{
                    cell.textField.placeholder = @"手机号码";
                }
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                cell.messageBlock = ^(NSString *info){
                    weakSelf.address.phone = info;
                };
                break;
            }
            case 3:{
                if(self.address.address.length > 0){
                    cell.info = self.address.address;
                }else{
                    cell.textField.placeholder = @"详细地址";
                }
                cell.messageBlock = ^(NSString *info){
                    weakSelf.address.address = info;
                };
                break;
            }
            default:
                break;
                
        }
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2 ){
        [self jumpToSelectView];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
