//
//  orderListModel.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderListModel : NSObject
@property (copy,nonatomic)NSString * listId;


-(NSMutableArray *)assignModelWithDict:(NSDictionary *)dict;

@end
