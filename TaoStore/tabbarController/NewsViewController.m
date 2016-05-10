//
//  NewsViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "NewsViewController.h"
#import "PublicDefine.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "orderListModel.h"
#import "stdPubFunc.h"
#import "DPAPI.h"

@interface NewsViewController ()<DPRequestDelegate>
{
    UIButton *back;
    UIImageView *backImg;
    NSInteger backflag;
    NSInteger scanBtnFlag;//1拖动状态 0停止状态
}
@property(nonatomic,strong)UIButton *topBtn;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
  
}
-(void)loadData{
  
}
-(void)dealloc
{
    
}

-(void)setWeburl:(NSString *)weburl{
    _weburl=weburl;
}
-(void)setTopTitle:(NSString *)topTitle{
    _topTitle=topTitle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"discovery_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"discovery"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString *tittxt=@"订单";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
        
        self.navigationItem.title=@"订单";
        [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self createLoginRequest];
    
}
-(void)clickleftbtn{
    
    if ([_webView canGoBack]) {
        [_webView goBack];
        //NSLog(@"canGoBack");
    }
    else
    {
        _weburl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder.html"];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
        [_webView loadRequest:request];
    }
    
}



- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-30, 16, 50, 40)];
    viewTitle.text=@"订单";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    backImg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backImg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backImg];
    //返回按钮
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    back.hidden=YES;
    backImg.hidden=YES;
    [self.view addSubview:topSearch];
}

# pragma 网络请求
- (void)createLoginRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"islogin" forKey:@"ut"];
    [api setAllwaysFlash:@"1"];
    NSString *myurl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"interface/islogin.htm"];;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    NSString *logstr=[dict objectForKey:@"result"];
    if ([logstr isEqualToString:@"true"]) {//已经登录
        _weburl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder.html"];
        
    }
    else
    {
        
        _weburl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"loginmobile.html"];
        
    }
    [self loadWebView];
}


-(void) loadWebView{
    //[self.view addSubview:TopView];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [self.webView setDelegate:self];
    
    
    NSLog(@"_weburl:%@",_weburl);
    _request =[NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    //request set
    [self.webView loadRequest:_request];
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
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [_activityIndicator setCenter:view.center];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:_activityIndicator];
    
    [_activityIndicator startAnimating];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSString *location=webView.request.URL.absoluteString;
    
   
    //NSLog(@"%@",location);
    if ([location isEqualToString:_weburl]) {
        back.hidden=YES;
        backImg.hidden=YES;
    }
    else
    {
        back.hidden=NO;
        backImg.hidden=NO;
    }
    
    [_activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    if(1==[self getLoginInfo:webView])//登录成功,保存信息后返回主界面
    {
        
        _weburl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder.html"];
        NSLog(@"订单%@",_weburl);
        [self loadWebView];
        
    }
    
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
