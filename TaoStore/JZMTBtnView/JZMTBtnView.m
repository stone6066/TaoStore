//
//  JZMTBtnView.m
//  meituan
//  自定义美团菜单view
//  Created by jinzelu on 15/6/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMTBtnView.h"
#import "UIImageView+WebCache.h"
@implementation JZMTBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-3, frame.size.width-4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        //imageView.image = [UIImage imageNamed:imageStr];
        [self addSubview:imageView];
        
        //
//        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+44, frame.size.width, 20)];
//        titleLable.text = title;
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        titleLable.font = [UIFont systemFontOfSize:13];
//        [self addSubview:titleLable];
    }
    return self;
}

@end
