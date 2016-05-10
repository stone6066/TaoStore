//
//  SearchViewController.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/25.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *searchTopBtn;
@property(nonatomic,copy)NSString *searchToken;//查询关键字
@property(nonatomic,copy)UITextField *seachTextF;
@property(nonatomic,copy)NSString *sortType;

@property(nonatomic,copy)UILabel *priceTitle;//1D
@property(nonatomic,copy)UILabel *defaultTitle;//3D
@property(nonatomic,copy)UILabel *saleNumsTitle;//2D
@property(nonatomic,copy)UILabel *populTitle;//4D


@property(nonatomic,assign)NSInteger pageindex;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSMutableArray *upImgArr;
@property(nonatomic,strong)NSMutableArray *downImgArr;

@property(nonatomic,strong)UIButton *topBtn;
@end
