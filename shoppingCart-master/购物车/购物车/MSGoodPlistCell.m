//
//  MSGoodPlistCell.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSGoodPlistCell.h"

@interface MSGoodPlistCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *buyButyton;

@end

@implementation MSGoodPlistCell

+ (instancetype) cellWithTableView:(UITableView *)tableView {
    
    return   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    self.iconView.layer.cornerRadius = 40;
    self.iconView.layer.masksToBounds = YES;
    
    self.buyButyton.layer.cornerRadius = 5;
    self.buyButyton.layer.masksToBounds = YES;
    [self.buyButyton addTarget:self action:@selector(ClickBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ClickBuyBtn:(UIButton *)btn{
    self.goodplist.isAddShoppingCar = YES;
    
    self.completeBlock(self,self.iconView);
}

- (void)setGoodplist:(MSGoodPlist *)goodplist {
    
    _goodplist = goodplist;
    
    self.nameLabel.text = goodplist.title;
    self.descLabel.text = goodplist.oldprice;
    self.iconView.image = [UIImage imageNamed:goodplist.icon];
    self.buyButyton.enabled = !goodplist.isAddShoppingCar;
    [self layoutIfNeeded];
}


@end
