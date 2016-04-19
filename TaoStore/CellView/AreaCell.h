//
//  AreaCell.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Areadelegate <NSObject>
@optional
- (void)AreaBtnClick:(NSInteger)sendTag;
@end

@interface AreaCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIImageView *img3;
@property(nonatomic,strong)UIImageView *img4;
@property(nonatomic,strong)UIImageView *img5;
@property(nonatomic,strong)UIImageView *img6;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;
@property (nonatomic, unsafe_unretained) id<Areadelegate> delegate;
-(id)initWithFrame:(CGRect)frame imgArr:(NSArray*)imgArr;
@end
