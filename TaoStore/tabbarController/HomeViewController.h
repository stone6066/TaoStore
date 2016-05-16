//
//  HomeViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/23.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AdvertisingColumn.h"//头部滚动的，不需要可以去掉
#import "AOScrollerView.h"
#import "ADCollectionViewCell.h"
#import "AreaCell.h"

@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,ValueClickDelegate,ShortCutdelegate,Areadelegate>
{
    AOScrollerView *_myheaderView;
    UIView *_mySeparateView;
    NSMutableArray * _SeachMutArr;
    NSMutableArray * _ResultMutArr;
   
}
@property (strong,nonatomic)NSMutableArray *dataSource;
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,copy)UITextField *seachTextF;
@property (strong,nonatomic)NSMutableArray *ADUrlArr;
@property (strong,nonatomic)NSMutableArray *ADHrefUrlArr;
@property (nonatomic,assign)NSInteger HomeSeachType;
//@property (nonatomic,strong)UICollectionView *btncollectionView;
@end
