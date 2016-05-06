//
//  AccountViewController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "AccountViewController.h"
#import "UIImageView+WebCache.h"
#import "PublicDefine.h"
#import "ShortCutViewController.h"
#import "DPAPI.h"
@interface AccountViewController ()<DPRequestDelegate,UIWebViewDelegate>
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
   [super viewDidLoad];
    [self loadNavTopView];
    
    //
    // Do any additional setup after loading the view.
  
}

# pragma 网络请求
- (void)createLoginRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"islogin" forKey:@"ut"];
    [api setAllwaysFlash:@"1"];
    NSString *myurl=[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/interface/islogin.htm"];;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    NSString *logstr=[dict objectForKey:@"result"];
    if ([logstr isEqualToString:@"true"]) {//已经登录
        [self loadNavTopView];
        [self loadUserImage];
        [self loadTableView];
    }
    else
    {
        
        _weburl=[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/loginmobile.html"];
        [self loadWebView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"我的");
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self createLoginRequest];
//    [self loadUserImage];
//    [self loadTableView];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"myInfo_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"myInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString *tittxt=@"我的";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
        
       
    }
    return self;
}
- (void)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex == 4)    //"我的账号"
    {
        NSLog(@"我的");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)clickleftbtn{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"left");
    
}



- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-30, 16, 50, 40)];
    viewTitle.text=@"我的";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}
-(void)loadUserImage{
    UIView *imgView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 150)];
    
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 120)];
    
    [backImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/images/images_25.jpg" ]]];
//    [backImg sd_setImageWithStr:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/images/images_25.jpg" ]];
    [imgView addSubview:backImg];
    
    
    
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 70, 70)];
    //[iconImg sd_setImageWithStr:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/images/avatar.jpg"]];
    
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/images/avatar.jpg"]]];
    
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = CGRectGetHeight(iconImg.bounds)/2;
    //    注意这里的ImageView 的宽和高都要相等
    //    layer.cornerRadiu 设置的是圆角的半径
    //    属性border 添加一个镶边
    iconImg.layer.borderWidth = 0.5f;
    iconImg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imgView addSubview:iconImg];
    
    UILabel *userLbl=[[UILabel alloc]initWithFrame:CGRectMake(90, 100, 100, 20)];
    userLbl.font=[UIFont systemFontOfSize:15];
    //userLbl.text=[stdPubFunc readUserName];
    [userLbl setTextColor:[UIColor whiteColor]];
    [imgView addSubview:userLbl];
    
    imgView.backgroundColor=MyGrayColor;
    [self.view addSubview:imgView];
    
}
-(void)loadTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+150, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"我的订单",@"待付款订单",@"已发货物流查询",@"收货地址管理",@"个人资料", nil];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setFrame:CGRectMake(fDeviceWidth/2-90, fDeviceHeight-140, 180, 50)];
    [publishBtn addTarget:self action:@selector(clickOutbtn) forControlEvents:UIControlEventTouchUpInside];
    [publishBtn setTitle:@"退出登录状态" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.backgroundColor=topSearchBgdColor;
    [self.view addSubview:publishBtn];
    //self.tableView.backgroundColor=collectionBgdColor;
}
-(void)clickOutbtn{
    [self createLoginOutRequest];
}
# pragma 网络请求
- (void)createLoginOutRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //[params setValue:@"logout" forKey:@"ut"];
    [api setAllwaysFlash:@"1"];
    
    NSString *myurl=[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/interface/logout.htm"];
    //@"http://192.168.0.13/nst/jumpmobilelogout.htm";
    //NetUrl;
    [api typeRequestWithURL:myurl params:params delegate:self];
}
- (void)typerequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    NSString *logstr=[dict objectForKey:@"result"];
    if ([logstr isEqualToString:@"true"]) {//退出登录成功
        [self.navigationController popViewControllerAnimated:YES];
        _weburl=[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/loginmobile.html"];
        [self loadWebView];
    }


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"MyInfotableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    UIImageView* cellImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_filter_arrow@2x"]];
    cell.accessoryView=cellImg;
    cell.textLabel.text = _tableDataSource[indexPath.row];
    
    
    return cell;
    
}

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/customer/myorder.html"] viewTitle:@"我的订单"];
            break;
        case 1:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/customer/myorder-0-1.html"] viewTitle:@"待付款订单"];
            break;
        case 2:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/customer/myorder-3-1.html"] viewTitle:@"已发货物流查询"];
            break;
        case 3:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/customer/address.html"] viewTitle:@"收货地址"];
            break;
        case 4:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/customer/personinfo.html"] viewTitle:@"个人资料"];
            break;
        case 5://我的发布
            //[self popMyPublicView];
            break;
        default:
            break;
    }
    
}

-(void)popMobileInfoView:(NSString*)urlStr viewTitle:(NSString*)sTitle{
    ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    [shortCutView setWeburl:urlStr];
    [shortCutView setTopTitle:sTitle];
    shortCutView.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
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
    
//    if ([location isEqualToString:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/"]]) {
//        backflag=1;
//    }
//    else
//        backflag=0;
    [_activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    if(1==[self getLoginInfo:webView])//登录成功,保存信息后返回主界面
    {
       
        [self loadUserImage];
        [self loadTableView];
        
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
