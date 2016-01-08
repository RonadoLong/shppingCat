//
//  MSShppingCell.h
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSGoodPlist.h"

@interface MSShppingCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic) MSGoodPlist *goodPlist;///<<#name#>

@property (copy , nonatomic ) void(^progressBlock)(MSShppingCell *cell , UIButton *btn ,UILabel *label);///<<#name#>

@property (copy , nonatomic ) void(^completeBlock)();///<<#name#>
@end
