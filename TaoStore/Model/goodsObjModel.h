//
//  goodsObjModel.h
//  TaoStore
//
//  Created by tianan-apple on 16/4/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsObjModel : NSObject
//名称
@property (copy,nonatomic)NSString * name;
//详细
@property (copy,nonatomic)NSString * title;
//子数据数组
@property (strong,nonatomic)NSMutableArray * subcategories;
@end
