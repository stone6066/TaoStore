//
//  ADCollectionViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ADCollectionViewCell.h"
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"
#import "JZMTBtnView.h"

@implementation ADCollectionViewCell
- (id)initWithFrame:(CGRect)frame AdShowType:(NSInteger)typeInt
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 160)];
        _backView1.backgroundColor=[UIColor whiteColor];
        _AdShowType=typeInt;
        //创建8个
        NSMutableArray *arr;
        NSMutableArray *imgarr;
        arr=[[NSMutableArray alloc]initWithObjects:@"查号",@"查快递",@"寄快递",@"景点门票",@"酒店",@"开锁",@"股票",@"飞机票",nil];
        imgarr=[[NSMutableArray alloc]initWithObjects:@"http://img-ta-01.b0.upaiyun.com/14464471950240426.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472019698473.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472108537905.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472184921945.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472253428296.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472325082647.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472421891485.jpg",@"http://img-ta-01.b0.upaiyun.com/14464472494226594.jpg",nil];
        for (int i = 0; i < 8; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*fDeviceWidth/4-3, -5, 80, 80);
                NSString *title =arr[i];//@"测试";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else {
                CGRect frame = CGRectMake((i-4)*fDeviceWidth/4-3, 75, 80, 80);
                NSString *title =arr[i];//@"测试1";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }
        }

//        for (int i = 0; i < 8; i++) {
//            if (i < 4) {
//                CGRect frame = CGRectMake(i*fDeviceWidth/4-3, -10, fDeviceWidth/4, 80);
//                NSString *title =arr[i];//@"测试";
//                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
//                btnView.tag = 10+i;
//                [_backView1 addSubview:btnView];
//                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
//                [btnView addGestureRecognizer:tap];
//                
//            }else {
//                CGRect frame = CGRectMake((i-4)*fDeviceWidth/4-3, 75, fDeviceWidth/4, 80);
//                NSString *title =arr[i];//@"测试1";
//                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
//                btnView.tag = 10+i;
//                [_backView1 addSubview:btnView];
//                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
//                [btnView addGestureRecognizer:tap];
//                
//            }
//        }
        [self addSubview:_backView1];
    }
    return self;
}
//#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat scrollViewW = scrollView.frame.size.width;
//    CGFloat x = scrollView.contentOffset.x;
//    int page = (x + scrollViewW/2)/scrollViewW;
//    _pageControl.currentPage = page;
//}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    [_delegate shortCutClick:sender.view.tag];
}


@end
