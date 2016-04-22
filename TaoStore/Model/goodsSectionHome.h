//
//  goodsSectionHome.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsSectionHome : NSObject
@property(nonatomic,copy)NSString* name;
@property (strong,nonatomic)NSArray * subcategories;

-(NSMutableArray *)assignGoodsWithDict:(NSDictionary *)dict;
-(NSMutableArray *)assignWithDict:(NSDictionary *)dict;
@end
