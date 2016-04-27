//
//  sortDealViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sortDealViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *sortTopBtn;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,copy)NSString *sortType;

@property(nonatomic,copy)UILabel *priceTitle;//1D
@property(nonatomic,copy)UILabel *defaultTitle;//3D
@property(nonatomic,copy)UILabel *saleNumsTitle;//2D
@property(nonatomic,copy)UILabel *populTitle;//4D

@property(nonatomic,strong)NSMutableArray *upImgArr;
@property(nonatomic,strong)NSMutableArray *downImgArr;

-(void)setSortListId:(NSString *)sortListId;
-(void)setTopTitle:(NSString *)topTitle;
@end
