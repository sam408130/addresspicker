//
//  AddressPickTableView.m
//  ShangXin
//
//  Created by Sam on 2016/12/29.
//  Copyright © 2016年 Ding Sai. All rights reserved.
//

#import "AddressPickTableView.h"
#import "AddressPickCell.h"

@interface AddressPickTableView()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@end

@implementation AddressPickTableView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, 0, kScreen_Width, 659/2)];
    if(self){
        if(!self.tableView){
            [self initTab];
            [self initActivityView];
        }
    }
    return self;
}


- (void)initActivityView{
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activity setSize:CGSizeMake(50, 50)];
    [self addSubview:self.activity];
    [self.activity setCenterX:self.centerX];
    [self.activity setCenterY:self.centerY - 45];
}

- (void)initTab{
    self.tableView = ({
        UITableView *tableview = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableview];
        [tableview registerClass:[AddressPickCell class] forCellReuseIdentifier:kCellIdentifier_AddressPickCell];
        {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 100, 0);
            tableview.contentInset = insets;
        }
        tableview;
        
    });
}

- (void)scrollToCell {

    if(self.data.count > 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

}


- (void)refresh:(NSString *)addressId currentId:(NSString *)currentId type:(NSString *)type{
    self.currentIndex = 0;
    self.type = type;
    [self.activity startAnimating];
    __weak typeof(self) weakSelf = self;
    
    if(!addressId){
        addressId = @"-1";
    }
    
    if([addressId isEqualToString:@"-1"] && ![self.type isEqualToString:@"province"]){
        return;
    }
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"https://api.leancloud.cn/1.1/functions/getAddress"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"cJ6LOFWTS5ckkPyePNKvdec7-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request addValue:@"GFgzu02CVVnJARFyyNRvygMV" forHTTPHeaderField:@"X-LC-Key"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys:addressId,@"parentId",
                             nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activity stopAnimating];
            NSLog(@"parentId:%@",addressId);
            if(data){
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                weakSelf.data = [NSObject arrayFromJSON:[json objectForKey:@"result"] ofObjects:@"AddrObject"];
                [weakSelf.tableView reloadData];
                [weakSelf scrollToCell];
            }
        });

    }];
    
    [postDataTask resume];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressPickCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_AddressPickCell forIndexPath:indexPath];
    AddrObject *object = [self.data objectAtIndex:indexPath.row];
    cell.object = object;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.picked){
        if([object.addrId isEqualToString:self.picked.addrId]){
            cell.isSelected = YES;
            self.currentIndex = indexPath.row;
        }else{
            cell.isSelected = NO;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.picked = [self.data objectAtIndex:indexPath.row];
    [self.tableView reloadData];
    if(self.addressPickBlock){
        self.addressPickBlock(self.picked);
    }
}

@end
