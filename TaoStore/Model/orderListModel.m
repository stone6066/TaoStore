//
//  orderListModel.m
//  TaoStore
//
//  Created by tianan-apple on 16/4/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "orderListModel.h"

@implementation orderListModel

-(NSMutableArray *)assignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]]){
        for (NSDictionary *dict1 in dictArray) {
            orderListModel *GH=[[orderListModel alloc]init];
            GH.listId=[[dict1 objectForKey:@"orderCode"]stringValue];
            
            [arr addObject:GH];
        }
        
    }
    
    return arr;
    
}
@end
