//
//  goodsSectionHome.m
//  TaoStore
//
//  Created by tianan-apple on 16/4/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "goodsSectionHome.h"
#import "goodsHome.h"
#import "PublicDefine.h"
#import "goodsObjModel.h"
#import "dealModel.h"

@implementation goodsSectionHome

-(NSMutableArray *)assignGoodsWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]]){
    for (NSDictionary *dict1 in dictArray) {
        goodsHome *GH=[[goodsHome alloc]init];
        GH.goodsId=[[dict1 objectForKey:@"goodsId"]stringValue];
        GH.goodsInfoCostPrice=[[dict1 objectForKey:@"goodsInfoCostPrice"]stringValue];
        GH.goodsInfoMarketPrice=[[dict1 objectForKey:@"goodsInfoMarketPrice"]stringValue];
        GH.goodsInfoPreferPrice=[[dict1 objectForKey:@"goodsInfoPreferPrice"]stringValue];
        GH.productName=[dict1 objectForKey:@"productName"];
        GH.subtitle=[dict1 objectForKey:@"subtitle"];
        GH.thirdName=[dict1 objectForKey:@"thirdName"];
        GH.goodsInfoImgId=[dict1 objectForKey:@"goodsInfoImgId"];
        GH.goodsInfoId=[dict1 objectForKey:@"goodsInfoId"];
        
        GH.goodsDealUrl=[NSString stringWithFormat:@"%@%@%@%@%@",BaseUrl,BasePath,@"item/",GH.goodsInfoId,@".html"];
        [arr addObject:GH];
    }
    
    }
    
    return arr;

}
-(NSMutableArray *)assignWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        
        for (NSDictionary *dict1 in dictArray) {
            goodsObjModel *GAH=[[goodsObjModel alloc]init];
            GAH.name=[dict1 objectForKey:@"name"];
            GAH.title=[dict1 objectForKey:@"title"];
            //[arr addObject:GAH];
            NSArray *arrtmp=[dict1 objectForKey:@"data"];
            NSMutableArray *subarr = [[NSMutableArray alloc]init];
            for (NSDictionary *mydict in arrtmp) {
                goodsHome *GH=[[goodsHome alloc]init];
                GH.goodsId=[[mydict objectForKey:@"goodsId"]stringValue];
                GH.goodsInfoCostPrice=[[mydict objectForKey:@"goodsInfoCostPrice"]stringValue];
                GH.goodsInfoMarketPrice=[[mydict objectForKey:@"goodsInfoMarketPrice"]stringValue];
                GH.goodsInfoPreferPrice=[[mydict objectForKey:@"goodsInfoPreferPrice"]stringValue];
                GH.productName=[mydict objectForKey:@"productName"];
                GH.subtitle=[mydict objectForKey:@"subtitle"];
                GH.thirdName=[mydict objectForKey:@"thirdName"];
                GH.goodsInfoImgId=[mydict objectForKey:@"goodsInfoImgId"];
                GH.goodsInfoId=[mydict objectForKey:@"goodsInfoId"];
                
                GH.goodsDealUrl=[NSString stringWithFormat:@"%@%@%@%@%@",BaseUrl,BasePath,@"item/",GH.goodsInfoId,@".html"];
                
                
                [subarr addObject:GH];
                
            }
            
            if (arrtmp.count>0) {
                GAH.subcategories=subarr;
                [arr addObject:GAH];
            }
          //[arr addObject:NM];
        }
        
    }
    return arr;


}
@end
