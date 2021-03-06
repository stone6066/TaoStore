//
//  AccountViewController.h
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,strong)NSURLRequest *request;
@property(nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@end
