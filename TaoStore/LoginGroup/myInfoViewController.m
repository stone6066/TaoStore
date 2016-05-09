//
//  myInfoViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "myInfoViewController.h"
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"
#import "ShortCutViewController.h"
#import "DPAPI.h"
#import "stdPubFunc.h"

@interface myInfoViewController ()<DPRequestDelegate>
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation myInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadUserImage];
    [self loadTableView];
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

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-20, -10, 40, 100)];
    viewTitle.text=@"我的";
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

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadUserImage{
    UIView *imgView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 150)];
    
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 120)];
    
    [backImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,@"mobile/images/images_25.jpg" ]]];
    [imgView addSubview:backImg];
    
    
    
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 70, 70)];
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
    userLbl.text=[stdPubFunc readUserName];
    [userLbl setTextColor:[UIColor whiteColor]];
    [imgView addSubview:userLbl];
    
    imgView.backgroundColor=MyGrayColor;
    [self.view addSubview:imgView];
    
}

-(void)loadTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+150, fDeviceWidth, fDeviceHeight-TopSeachHigh-150-100)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"我的订单",@"待付款订单",@"已发货物流查询",@"收货地址管理",@"个人资料",@"我的发布", nil];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setFrame:CGRectMake(fDeviceWidth/2-90, fDeviceHeight-80, 180, 50)];
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
    
    NSString *myurl=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"interface/logout.htm"];
    //@"http://192.168.0.13/nst/jumpmobilelogout.htm";
    //NetUrl;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    NSString *logstr=[dict objectForKey:@"msg"];
    if ([logstr isEqualToString:@"ok"]) {//退出登录成功
        [self.navigationController popViewControllerAnimated:YES];
        self.LoginOutFlagBlock(self,1);
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
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder.html"] viewTitle:@"我的订单"];
            break;
        case 1:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder-0-1.html"] viewTitle:@"待付款订单"];
            break;
        case 2:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/myorder-3-1.html"] viewTitle:@"已发货物流查询"];
            break;
        case 3:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/address.html"] viewTitle:@"收货地址"];
            break;
        case 4:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"customer/personinfo.html"] viewTitle:@"个人资料"];
            break;
        case 5://我的发布
            [self popMyPublicView];
            break;
        default:
            break;
    }
    
}


-(void)popMyPublicView{
//    MyPublicViewController *LiveView=[[MyPublicViewController alloc]init];
//    LiveView.hidesBottomBarWhenPushed=YES;
//    LiveView.navigationItem.hidesBackButton=YES;
//    LiveView.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:LiveView animated:YES];
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
@end
