//
//  adDataModel.m
//  TaoStore
//
//  Created by tianan-apple on 16/4/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "adDataModel.h"

@implementation adDataModel

-(NSMutableArray *)assignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]]){
        for (NSDictionary *dict1 in dictArray) {
            
            NSString * imgurl=[dict1 objectForKey:@"imgurl"];
            
            [arr addObject:imgurl];
        }
        
    }
    return arr;
    
}
-(NSMutableArray *)assignHrefModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]]){
        for (NSDictionary *dict1 in dictArray) {
            
            NSString * hrefurl=[dict1 objectForKey:@"href"];
            
            [arr addObject:hrefurl];
        }
        
    }
    return arr;
    
}

@end
