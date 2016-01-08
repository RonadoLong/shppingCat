//
//  MSShppingCell.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSShppingCell.h"
#import  "Masonry.h"

typedef NS_ENUM(NSInteger , MSSelectedType) {
    
     MSSelectedTypeAdd,
     MSSelectedTypeDelected
};

@interface  MSShppingCell()

@property(weak,nonatomic) IBOutlet UIButton *selectedBtn;///<<#name#>

@property(weak,nonatomic) IBOutlet UIImageView  *iconView;///<<#name#>

@property(weak,nonatomic) IBOutlet UILabel *titleLabel;///<<#name#>

@property(weak,nonatomic) IBOutlet UILabel *newpriceLabel;///<<#name#>

@property(weak,nonatomic) IBOutlet UILabel *oldpriceLabel;///<<#name#>

@property (weak , nonatomic )  IBOutlet UIButton  *addBtn;///<<#name#>

@property (weak , nonatomic )  IBOutlet  UIButton *subtractionBtn;///<<#name#>

@property (weak , nonatomic ) IBOutlet UILabel  *buyCountLabel;///<<#name#>

- (IBAction)didCacularBtn:(UIButton *)sender;

@end

@implementation MSShppingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    self.buyCountLabel.frame = CGRectMake(0, 0, 20, 20);
    self.iconView.layer.cornerRadius = 40;
    self.iconView.layer.masksToBounds = YES;
    self.addBtn.tag = MSSelectedTypeAdd;
    self.subtractionBtn.tag = MSSelectedTypeDelected;
}

- (void)setGoodPlist:(MSGoodPlist *)goodPlist {
    
    _goodPlist = goodPlist;
    
    self.iconView.image = [UIImage imageNamed:goodPlist.icon];
    self.titleLabel.text = goodPlist.title;
    self.newpriceLabel.text = goodPlist.newprice;
    self.oldpriceLabel.text = goodPlist.oldprice;
    self.buyCountLabel.text = goodPlist.buyCount;
    self.selectedBtn.selected = goodPlist.isSelected;
}

- (IBAction)didCacularBtn:(UIButton *)sender {
    
    if ( MSSelectedTypeAdd == self.addBtn.tag) {
        if (self.progressBlock) {
            self.progressBlock (self , self.addBtn , self.buyCountLabel);
        }
        
    } else{
        
        if (self.progressBlock) {
           self.progressBlock (self , self.subtractionBtn , self.buyCountLabel);
        }
    }
}

- (IBAction)didClickSelectedBtn:(UIButton *)sender {
    
    self.selectedBtn.selected = !self.selectedBtn.selected;
    self.goodPlist.isSelected = self.selectedBtn.isSelected;
    
    if (self.completeBlock) {
        
        self.completeBlock();
    }
}
@end
