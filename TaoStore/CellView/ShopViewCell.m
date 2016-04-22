//
//  ShopViewCell.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/15.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "ShopViewCell.h"
#import "goodsHome.h"
#import "UIImageView+WebCache.h"


@interface ShopViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *currPrice;

@property (weak, nonatomic) IBOutlet UILabel *biaojia;



@property (weak, nonatomic) IBOutlet UILabel *salesNumLabel;

@property (nonatomic,copy)NSString *deal_id;

@end

@implementation ShopViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)showUIWithModel:(goodsHome *)model{
    self.titleLabel.text = model.productName;
    self.currPrice.text = model.goodsInfoPreferPrice;
    self.biaojia.text= @"¥: ";
    self.deal_id=model.goodsDealUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goodsInfoImgId]];
    
}

-(goodsHome*)praseModelWithCell:(ShopViewCell *)cell{
    goodsHome *dm = [[goodsHome alloc]init];
    dm.productName=cell.titleLabel.text;
    
    dm.goodsDealUrl=cell.deal_id;
    return dm;
}

@end
