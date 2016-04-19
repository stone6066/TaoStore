//
//  ADCollectionViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShortCutdelegate <NSObject>
@optional
- (void)shortCutClick:(NSInteger)sendTag;
@end



@interface ADCollectionViewCell : UICollectionViewCell
{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}
@property (nonatomic,assign)NSInteger AdShowType;//城市版1 农村版0
@property (nonatomic, unsafe_unretained) id<ShortCutdelegate> delegate;
- (id)initWithFrame:(CGRect)frame AdShowType:(NSInteger)typeInt;
@end
