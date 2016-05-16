//
//  SerachShopViewController.h
//  TaoStore
//
//  Created by tianan-apple on 16/5/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerachShopViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,copy)NSString *searchToken;//查询关键字
@property(nonatomic,copy)UITextField *seachTextF;
@end
