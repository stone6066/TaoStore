//
//  ShopViewCell.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/15.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goodsHome;

@interface ShopViewCell : UICollectionViewCell

- (void)showUIWithModel:(goodsHome *)model;
-(goodsHome*)praseModelWithCell:(ShopViewCell *)cell;
@end
