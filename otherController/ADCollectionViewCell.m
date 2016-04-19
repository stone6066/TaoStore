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
        if (typeInt==1) {//城市版
            
            arr=[[NSMutableArray alloc]initWithObjects:@"农副产品",@"农产品价格",@"社区商超",@"社区信息",@"便民缴费",@"便民政务",@"发布信息",@"优惠活动",nil];
            imgarr=[[NSMutableArray alloc]initWithObjects:@"farmProduce",@"price",@"shop",@"shequ",@"jiaofei",@"bianmin",@"pubMsg",@"youhui",nil];
        }
        else
        {
            arr=[[NSMutableArray alloc]initWithObjects:@"农资用品",@"生活用品",@"农副用品", @"餐企供求",@"价格信息",@"物流信息",@"消息中心",@"发布信息",nil];
            imgarr=[[NSMutableArray alloc]initWithObjects:@"farmTrace",@"livepro",@"farmProduce", @"shop",@"price",@"express",@"message",@"pubMsg",nil];
        }
        
        for (int i = 0; i < 8; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*fDeviceWidth/4-3, -5, fDeviceWidth/4, 80);
                NSString *title =arr[i];//@"测试";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else {
                CGRect frame = CGRectMake((i-4)*fDeviceWidth/4-3, 75, fDeviceWidth/4, 80);
                NSString *title =arr[i];//@"测试1";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }
        }
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
