//
//  LoginViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LoginViewController.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

#import "myInfoViewController.h"


@interface LoginViewController ()
{
    //UIButton *back;
    NSInteger backflag;
    NSURLRequest *request;
}
@end
//static LoginViewController *LoginView = nil; //第一步：静态实例，并初始化。
@implementation LoginViewController



@synthesize webView = _webView;
//+ (LoginViewController*) sharedInstance  //第二步：实例构造检查静态实例是否为nil
//{
//    @synchronized (self)
//    {
//        if (LoginView == nil)
//        {
//            [[self alloc] init];
//        }
//    }
//    return LoginView;
//}
//
//+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
//{
//    @synchronized (self) {
//        if (LoginView == nil) {
//            LoginView = [super allocWithZone:zone];
//            return LoginView;
//        }
//    }
//    return nil;
//}
//
//- (id) copyWithZone:(NSZone *)zone //第四步
//{
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    backflag=1;
   
    [self loadNavTopView];
    [self loadWebView];
    [self stdRightGesture];
    // Do any additional setup after loading the view.
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
-(void)clickleftbtn1
{
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
//    [self.webView setDelegate:self];
    
    NSString *myurl=@"http://192.168.0.38:8080/mlogin.jsp";
    
    request =[NSURLRequest requestWithURL:[NSURL URLWithString:myurl]];
    //request set
    [self.webView loadRequest:request];
    [self.view addSubview: self.webView];
}
-(void)clickleftbtn2
{
    NSString *msgStr= [_webView stringByEvaluatingJavaScriptFromString:@"getMsg();"];
    NSString *uidStr= [_webView stringByEvaluatingJavaScriptFromString:@"getUid();"];
    NSString *nicktr= [_webView stringByEvaluatingJavaScriptFromString:@"getNickname();"];
    NSString *userStr= [_webView stringByEvaluatingJavaScriptFromString:@"getUsername();"];
    
    NSLog(@"msgStr：%@,uidStr：%@,nicktr：%@,userStr：%@",msgStr,uidStr,nicktr,userStr);
}

//# pragma 网络请求
//- (void)createLoginRequest{
//    DPAPI *api = [[DPAPI alloc]init];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//
//    
//    [params setValue:@"islogin" forKey:@"ut"];
//    [api setAllwaysFlash:@"1"];
//    NSString *myurl=NetUrl;
//    [api loginRequestWithURL:myurl params:params delegate:self];
//}
//
//-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
//    NSDictionary *dict=result;
//    NSString *logstr=[dict objectForKey:@"msg"];
//    if ([logstr isEqualToString:@"ok"]) {//登陆成功
//        [self popMyInfoView];
//    }
//    else
//        [self loadWebView];
//}
//-(void)popMyInfoView{
//    myInfoViewController *LiveView=[[myInfoViewController alloc]init];
//    LiveView.hidesBottomBarWhenPushed=YES;
//    LiveView.navigationItem.hidesBackButton=YES;
//    LiveView.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:LiveView animated:YES];
//}



- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-20, -10, 40, 100)];
    viewTitle.text=_topTitle;
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    [self.view addSubview:topSearch];
}
-(void) loadWebView{
  
//    UIButton *back1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [back1 setFrame:CGRectMake(110, 22, 70, 42)];
//    back1.backgroundColor=[UIColor yellowColor];
//    [back1 addTarget:self action:@selector(clickleftbtn1) forControlEvents:UIControlEventTouchUpInside];
//    [TopView addSubview:back1];
//    
//    UIButton *back2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [back2 setFrame:CGRectMake(220, 22, 70, 42)];
//    back2.backgroundColor=[UIColor blueColor];
//    [back2 addTarget:self action:@selector(clickleftbtn2) forControlEvents:UIControlEventTouchUpInside];
//    [TopView addSubview:back2];
    
    
    
    //[self.view addSubview:TopView];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [self.webView setDelegate:self];
    
    
    
    request =[NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    //request set
    [self.webView loadRequest:request];
    [self.view addSubview: self.webView];
    
    
}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSString *location=webView.request.URL.absoluteString;
    
    if ([location isEqualToString:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/"]]) {
        backflag=1;
    }
    else
        backflag=0;
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    if(1==[self getLoginInfo:webView])//登录成功,保存信息后返回主界面
    {
        [stdPubFunc setIsLogin:@"1"];
        [self.navigationController popViewControllerAnimated:YES];
        self.LoginFlagBlock(self, 1);
        
        
    }
    
}
-(void)setMySession:(NSURLRequest*)Req{
    NSUserDefaults *MySession = [NSUserDefaults standardUserDefaults];
    NSString * userName = [MySession objectForKey:NSUserJSESSIONID];
    if (userName.length>0) {
        [Req setValue:userName forKey:@"JSESSIONID"];
    }
}
-(void)getSession{
   NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:_weburl]];
    NSUserDefaults *Session = [NSUserDefaults standardUserDefaults];
    for (NSHTTPCookie *cook in cookies) {
        if (([cook.name isEqualToString:@"JSESSIONID"])&&([cook.path isEqualToString:@"/mobile/"])) {
            NSLog(@"%@",cook.value) ;//保存JSESSIONID
            [Session setObject:cook.value forKey:NSUserJSESSIONID];
            [Session synchronize];
        }
    }
}
-(NSString*)readSession{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * session = [user objectForKey:NSUserJSESSIONID];
    return session;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;//return NO 的时候，webview就不会加载页面了
}

-(void)clickleftbtn
{
    if (1==backflag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
            //NSLog(@"canGoBack");
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


-(void)loadScanBtn{
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
    ////_scanBtn.backgroundColor=[UIColor redColor];
    [scanView addSubview:_scanBtn];
    
    //scanView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:scanView];
}
-(NSInteger)getLoginInfo:(UIWebView*)myWebView{
   // NSString *user= [myWebView stringByEvaluatingJavaScriptFromString:@"getUser();"];
    NSString *msgStr= [myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"msg\").value"];
    NSString *uidStr= [myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"uid\").value"];
    NSString *nicktr= [myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"nickname\").value"];
    NSString *userStr= [myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"username\").value"];
    if ([msgStr isEqualToString:@"1"]){
        [self saveLoginInfo:msgStr uid:uidStr nickname:nicktr username:userStr];
        return 1;
    }
    
    return 0;
}
- (void)doScan:(UIButton *)button
{
    [self getLoginInfo:self.webView];
    [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert();"];
}


-(void)saveLoginInfo:(NSString*)mymsg uid:(NSString*)myuid nickname:(NSString*)mynickname username:(NSString*)myusername{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:mymsg forKey:NSUserDefaultsMsg];
    [myuser setObject:myuid forKey:NSUserDefaultsUid];
    [myuser setObject:mynickname forKey:NSUserDefaultsNick];
    [myuser setObject:myusername forKey:NSUserDefaultsUsers];
    [myuser synchronize];
    
    NSLog(@"msgStr：%@,uidStr：%@,nicktr：%@,userStr：%@",mymsg,myuid,mynickname,myusername);
}

@end
