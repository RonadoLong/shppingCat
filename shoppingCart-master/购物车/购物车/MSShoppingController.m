//
//  MSShoppingController.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSShoppingController.h"
#import "MSShppingCell.h"

@interface MSShoppingController ()

@end

@implementation MSShoppingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didiClickBackBtn)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
    self.tableView.rowHeight = 90;
}

#pragma mark - custom methods  自定义方法
- (void)didiClickBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addGoodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSShppingCell *cell = [MSShppingCell cellWithTableView:tableView];
    cell.goodPlist = self.addGoodArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSeaf = self;
    [cell setProgressBlock:^(MSShppingCell *cell, UIButton *btn, UILabel *countlabel) {
        
    }];
    
    //重新计算
    [cell setCompleteBlock:^{
        
    }];
    
    return cell;
}



@end
