//
//  goodsHome.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsHome : NSObject
@property(nonatomic,copy)NSString* goodsId;
@property(nonatomic,copy)NSString* goodsInfoCostPrice;//成本价
@property(nonatomic,copy)NSString* goodsInfoMarketPrice;//市场价
@property(nonatomic,copy)NSString* goodsInfoPreferPrice;//销售价
@property(nonatomic,copy)NSString* productName;
@property(nonatomic,copy)NSString* subtitle;
@property(nonatomic,copy)NSString* thirdName;
@property(nonatomic,copy)NSString* goodsInfoImgId;
@property(nonatomic,copy)NSString* goodsInfoId;
@property(nonatomic,copy)NSString* goodsDealUrl;//商品详情链接
@end
