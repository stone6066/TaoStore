//
//  ShortCutViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/12/1.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ShortCutViewController.h"
#import "PublicDefine.h"
#import "SYQRCodeViewController.h"
#import "LoginViewController.h"

@interface ShortCutViewController ()
{
    UIButton *back;
    NSInteger backflag;
    NSInteger scanBtnFlag;//1拖动状态 0停止状态
}
@end

@implementation ShortCutViewController

-(void)setWeburl:(NSString *)weburl
{
    _weburl=weburl;
}
-(void)setTopTitle:(NSString *)topTitle
{
    _topTitle=topTitle;
}
-(void)setScanFlag:(NSInteger)scanFlag
{
    _scanFlag=scanFlag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    backflag=1;
    [self loadWebView];
    if (1==_scanFlag) {
        [self loadScanBtn];
    }

    [self stdRightGesture];
}

-(void)stdRightGesture{
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=_topTitle.length*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=_topTitle;
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    [self.view addSubview:TopView];
}
-(void) loadWebView{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [webView setDelegate:self];
    NSLog(@"_weburl:%@",_weburl);
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    [webView loadRequest:request];
    [self.view addSubview: webView];
    
    
}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
   // NSString *location=webView.request.URL.absoluteString;
   // NSLog(@"webViewUrl:%@",location);
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *location=webView.request.URL.absoluteString;
    NSLog(@"webViewDidFinishLoad:%@",location);
    NSString *logUrl= [NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/login.html"];
    if([location rangeOfString:logUrl].location !=NSNotFound)//要从商城登录
    {
        [self loadLoginView];
        
    }
    else{
   
    
        if ([location isEqualToString:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/"]]) {
            backflag=1;
        }
        else
            backflag=0;
    }
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
   
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *location=webView.request.URL.absoluteString;
    //NSLog(@"shouldStartLoadWithRequest:%@",location);
   // NSLog(@"shouldStartLoadWithRequest");
//    NSString *logUrl= [NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/login.html"];
//    if([location rangeOfString:logUrl].location !=NSNotFound)//要从商城登录
//    {
//        [self loadLoginView];
//        
//    }
    
    return YES;//return NO 的时候，webview就不会加载页面了
}
-(void)clickleftbtn
{
    if (1==backflag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([webView canGoBack]) {
            [webView goBack];
            NSLog(@"canGoBack");
        }
        else
        {
        [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];

    NSLog(@"didFailLoadWithError:%@", error);
}


-(void)loadScanBtn1{
    // 添加扫一扫按钮
    UIView *scanView=[[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth-50, 90, 40, 60)];
    
    UIImageView * scanImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    scanImg.image=[UIImage imageNamed:@"myscan"];
    [scanView addSubview:scanImg];
    
    UILabel *scanLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 35, 40, 20)];
    [scanLbl setText:@"扫一扫"];
    [scanLbl setFont:[UIFont systemFontOfSize:10]];
    scanLbl.textColor=[UIColor blackColor];
    [scanView addSubview:scanLbl];
    
    _scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
    [_scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    [scanView addSubview:_scanBtn];
    [self.view addSubview:scanView];
}

-(void)loadScanBtn{
    // 添加扫一扫按钮
    _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanBtn.frame = CGRectMake(fDeviceWidth-90, 90, 50, 50);
    scanBtnFlag=0;
    
    
    _scanBtn.backgroundColor = [UIColor whiteColor];//tton的背景颜色
    
    
    //    在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [_scanBtn setImage:[UIImage imageNamed:@"myscan"] forState:UIControlStateNormal];
    //给button添加image
   //设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    _scanBtn.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];//设置button的title
    _scanBtn.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
    _scanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [_scanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [_scanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    _scanBtn.titleEdgeInsets = UIEdgeInsetsMake(52, -_scanBtn.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    
   
    _scanBtn.backgroundColor=[UIColor clearColor];

    [_scanBtn addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
    [_scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_scanBtn];
}
- (void) dragMoving: (UIButton *) c withEvent:ev
{
    scanBtnFlag=1;
    c.center = [[[ev allTouches] anyObject] locationInView:self.view];
    //NSLog(@"%f,,,%f",c.center.x,c.center.y);
}

- (void)doScan:(UIButton *)button
{
    if (scanBtnFlag==0)
    {
        SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
        qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
            [aqrvc dismissViewControllerAnimated:NO completion:nil];
            
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:qrString]];
            [webView loadRequest:request];
            
            
        };
        qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
            [aqrvc dismissViewControllerAnimated:NO completion:nil];
        };
        qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
            [aqrvc dismissViewControllerAnimated:NO completion:nil];
        };
        [self presentViewController:qrcodevc animated:YES completion:nil];
    }
    scanBtnFlag=0;
}


-(void)loadLoginView{
    LoginViewController *shortCutView=[[LoginViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    
    [shortCutView setWeburl:[NSString stringWithFormat:@"%@%@",BaseUrl,@"nst/jumpmobilelogin.htm"]];
    [shortCutView setTopTitle:@"登录"];
    shortCutView.LoginFlagBlock = ^(LoginViewController *LoginView,NSInteger loginFlag){
        [LoginView dismissViewControllerAnimated:NO completion:nil];
        
        [self clickleftbtn];
            //[_myViewTitle setText:@"我的"];
       
    };
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
}



@end
