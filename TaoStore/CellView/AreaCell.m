//
//  AreaCell.m
//  TaoStore
//
//  Created by tianan-apple on 16/4/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AreaCell.h"
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"

@implementation AreaCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame imgArr:(NSArray*)imgArr{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat X=frame.size.width/2;
        CGFloat Y=frame.size.height/2;
        
        _img1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, X, Y)];
        _img2=[[UIImageView alloc]initWithFrame:CGRectMake(X, 0, X, Y)];
        _img3=[[UIImageView alloc]initWithFrame:CGRectMake(0, Y, X/2, Y)];
        _img4=[[UIImageView alloc]initWithFrame:CGRectMake(X/2, Y, X/2, Y)];
        _img5=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, X/2, Y)];
        _img6=[[UIImageView alloc]initWithFrame:CGRectMake((X/2)*3, Y, X/2, Y)];
        
        
        [_img1 sd_setImageWithURL:[NSURL URLWithString:imgArr[0]]];
        [_img2 sd_setImageWithURL:[NSURL URLWithString:imgArr[1]]];
        [_img3 sd_setImageWithURL:[NSURL URLWithString:imgArr[2]]];
        [_img4 sd_setImageWithURL:[NSURL URLWithString:imgArr[3]]];
        [_img5 sd_setImageWithURL:[NSURL URLWithString:imgArr[4]]];
        [_img6 sd_setImageWithURL:[NSURL URLWithString:imgArr[5]]];
        
        [self addSubview:_img1];
        [self addSubview:_img2];
        [self addSubview:_img3];
        [self addSubview:_img4];
        [self addSubview:_img5];
        [self addSubview:_img6];
        
        _btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, X, Y)];
        _btn2=[[UIButton alloc]initWithFrame:CGRectMake(X, 0, X, Y)];
        _btn3=[[UIButton alloc]initWithFrame:CGRectMake(0, Y, X/2, Y)];
        _btn4=[[UIButton alloc]initWithFrame:CGRectMake(X/2, Y, X/2, Y)];
        _btn5=[[UIButton alloc]initWithFrame:CGRectMake(X, Y, X/2, Y)];
        _btn6=[[UIButton alloc]initWithFrame:CGRectMake((X/2)*3, Y, X/2, Y)];
        _btn1.tag=1;
        _btn2.tag=2;
        _btn3.tag=3;
        _btn4.tag=4;
        _btn5.tag=5;
        _btn6.tag=6;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        
        [_btn1 addGestureRecognizer:tap1];
        [_btn2 addGestureRecognizer:tap2];
        [_btn3 addGestureRecognizer:tap3];
        [_btn4 addGestureRecognizer:tap4];
        [_btn5 addGestureRecognizer:tap5];
        [_btn6 addGestureRecognizer:tap6];
        
        
        [self addSubview:_btn1];
        [self addSubview:_btn2];
        [self addSubview:_btn3];
        [self addSubview:_btn4];
        [self addSubview:_btn5];
        [self addSubview:_btn6];
    }
    
    return self;
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    [_delegate AreaBtnClick:sender.view.tag];
}
@end
