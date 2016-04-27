//
//  sortModel.m
//  caidao
//
//  Created by tianan-apple on 16/3/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "sortModel.h"
#import "MultilevelMenu.h"
#import "PublicDefine.h"

@implementation sortModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
   // NSDictionary *datadict = [dict objectForKey:@"data"];
    NSDictionary *typedict = [dict objectForKey:@"data"];
    

    
    for (NSDictionary *dict1 in typedict) {
       
        rightMeun * meun=[[rightMeun alloc] init];
        
        
        meun.meunName=[dict1 objectForKey:@"name"];//左侧列表
        meun.ID=[[dict1 objectForKey:@"cateId"]stringValue];
        meun.urlName=[dict objectForKey:@"imgSrc"];
        
        rightMeun * meun1=[[rightMeun alloc] init];
        meun1.meunName=[dict1 objectForKey:@"name"];//右侧标题
        meun1.urlName=[dict1 objectForKey:@"imgSrc"];
        
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        [sub addObject:meun1];
        meun.nextArray=sub;
        
        NSDictionary *subdict = [dict1 objectForKey:@"subMob"];
       
        NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *mydict in subdict)
        {
            rightMeun * subMeun=[[rightMeun alloc] init];
            subMeun.meunName=[mydict objectForKey:@"name"];//右侧详细
            subMeun.ID=[[mydict objectForKey:@"cateId"]stringValue];
            
            //if(![[dict objectForKey:@"imgSrc"] isEqual:[NSNull null]])
            subMeun.urlName=[dict objectForKey:@"imgSrc"];
//            subMeun.menuDealUrl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"paistore_m_site/list/",subMeun.ID];
            [zList addObject:subMeun];
        }
         meun1.nextArray=zList;
       
        meun.nextArray=sub;
        [arr addObject:meun];
    }
    return arr;
}

@end
