//
//  LoginViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface LoginViewController : UIViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
}


@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,assign)NSInteger scanFlag;//扫二维码按钮是否可用
@property(nonatomic,strong)UIButton *scanBtn;
@property (nonatomic, copy) void (^LoginFlagBlock) (LoginViewController *,NSInteger);
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
-(void)setWeburl:(NSString *)weburl;
-(NSString*)readSession;
@end
