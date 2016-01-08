//
//  MSGoodPlistCell.h
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSGoodPlist.h"

@interface MSGoodPlistCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic) MSGoodPlist *goodplist;///<<#name#>

@property (copy , nonatomic ) void(^completeBlock)(MSGoodPlistCell *cell , UIImageView *imageview);///<<#name#>

@end
