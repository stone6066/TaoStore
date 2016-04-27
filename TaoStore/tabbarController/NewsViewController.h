//
//  NewsViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,strong)NSURLRequest *request;
@end
