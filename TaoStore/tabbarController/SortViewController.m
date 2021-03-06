//
//  SortViewController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "SortViewController.h"

#import "PublicDefine.h"
#import "SVProgressHUD.h"
#import "sortModel.h"
#import "MultilevelMenu.h"
#import "sortDealViewController.h"
#import "SYQRCodeViewController.h"
#import "ShortCutViewController.h"
#import "SearchViewController.h"

@interface SortViewController ()<UITextFieldDelegate>
{
UITextField * _seachTextF;
}
@end

@implementation SortViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"assortment_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"assortment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"分类";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    [self loadsortSeachView];
    [self loadSortData];
    
}


-(void)loadSortView:(NSArray*)dataArr{
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight) WithData:dataArr withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
        sortDealViewController *sortDealView=[[sortDealViewController alloc]init];
        //sortDealView.navigationItem.title=info.meunName;
        sortDealView.hidesBottomBarWhenPushed=YES;
        sortDealView.navigationItem.hidesBackButton=YES;
        [sortDealView setSortListId:info.ID];
        [sortDealView setTopTitle:info.meunName];
        [self.navigationController pushViewController:sortDealView animated:YES];
        //NSLog(@"点击的 菜单%@",info.meunName);
    }];
    
    [self.view addSubview:view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_seachTextF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIImage * sbundleImageImageName(NSString  *imageName)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",imageName] ofType:nil inDirectory:@""];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
    return image;
}
- (void)loadsortSeachView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UIImageView * seachBgV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 25, fDeviceWidth-95, 30)];
    seachBgV.userInteractionEnabled = YES;
    seachBgV.image =[UIImage imageNamed:@"seachBgd"];
    seachBgV.userInteractionEnabled = YES;
    [topSearch addSubview:seachBgV];
    
    
    UIImageView * scanLogo = [[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth-40, 25, 22, 22)];
    scanLogo.userInteractionEnabled = YES;
    scanLogo.image =[UIImage imageNamed:@"scan"];
    scanLogo.userInteractionEnabled = YES;
    [topSearch addSubview:scanLogo];
    
    
    UILabel *scanTxt=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-41, 45, 40, 20)];
    scanTxt.text=@"扫一扫";
    scanTxt.font=[UIFont systemFontOfSize:8];
    scanTxt.textColor=[UIColor whiteColor];
    [topSearch addSubview:scanTxt];
    
    UIButton * scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(topSearch.frame.size.width-48, 0, 50, 50)];
    
    //scanBtn.backgroundColor=[UIColor yellowColor];
    [scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:scanBtn];
    
    
    [self.view addSubview:topSearch];
    
    
    _seachTextF = [[UITextField alloc] initWithFrame:CGRectMake(35, -1, fDeviceWidth-100-35, 35)];
    _seachTextF.backgroundColor = [UIColor clearColor];
    [_seachTextF setTintColor:[UIColor blueColor]];
    _seachTextF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    UIColor *mycolor=[UIColor whiteColor];
    _seachTextF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索你喜欢的商品" attributes:@{NSForegroundColorAttributeName: mycolor}];
    
    [_seachTextF setReturnKeyType:UIReturnKeySearch];
    _seachTextF.textColor=[UIColor whiteColor];
    [seachBgV addSubview:_seachTextF];
    _seachTextF.delegate=self;
    UIButton * seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(45, 24, 40, 35)];
    [seachBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [topSearch addSubview:seachBtn];
    [seachBtn setImage:[UIImage imageNamed:@"queryBtn@2x"] forState:UIControlStateNormal];
    [seachBtn setImage:[UIImage imageNamed:@"queryBtn@2x"] forState:UIControlStateHighlighted];
    [seachBtn addTarget:self action:@selector(doSeach:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)sortHiddenKeyBoard
{
    if ([_seachTextF isFirstResponder]) {
        [_seachTextF resignFirstResponder];
    }
}

- (void)doScan:(UIButton *)button
{
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        ShortCutViewController *goodsView=[[ShortCutViewController alloc]init];
        goodsView.hidesBottomBarWhenPushed=YES;
        goodsView.navigationItem.hidesBackButton=YES;
        [goodsView setWeburl:qrString];
       
        [self.navigationController pushViewController:goodsView animated:YES];
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
}

-(void)sortShowTabbar{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:NO];
        }
    }
}
- (void)doSeach:(UIButton *)button
{
    if (_seachTextF.text.length>0) {
        SearchViewController *searchView=[[SearchViewController alloc]init];
        searchView.hidesBottomBarWhenPushed=YES;
        searchView.navigationItem.hidesBackButton=YES;
        
        [searchView setSearchToken:_seachTextF.text];
        
        [self.navigationController pushViewController:searchView animated:YES];
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    [self doSeach:nil];
    return YES;
}

-(void)loadSortData{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    //NSString *urlStr = [NSString stringWithFormat:@"%@%@",NetUrl,@"UsrStore.asmx/GetPartsList"];
    
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                @"pageNo":[NSString stringWithFormat:@"%d",1],
                                @"pageSize":[NSString stringWithFormat:@"%d",20]
                                };
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,BasePath,@"interface/getgoodscate.htm"];
    NSLog(@"asorturlstr:%@",urlstr);
    [ApplicationDelegate.httpManager POST:urlstr
                              parameters:paramDict
                                progress:^(NSProgress * _Nonnull uploadProgress) {}
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     //http请求状态
                                     if (task.state == NSURLSessionTaskStateCompleted) {
                                         NSError* error;
                                         NSDictionary* jsonDic = [NSJSONSerialization
                                                                  JSONObjectWithData:responseObject
                                                                  options:kNilOptions
                                                                  error:&error];
                                         //NSLog(@"数据：%@",jsonDic);
                                         NSString *suc=[jsonDic objectForKey:@"result"];
                                         
                                         //
                                         if ([suc isEqualToString:@"true"]) {
                                             //成功
                                             [SVProgressHUD showSuccessWithStatus:k_Success_Load];
                                             sortModel *SM=[[sortModel alloc]init];
                                             NSArray *datatmp=[SM asignModelWithDict:jsonDic];
                                             [self loadSortView:datatmp];
                                             
                                             
                                             
                                             
                                         } else {
                                             //失败
                                             [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                             
                                         }
                                         
                                     } else {
                                         [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     //请求异常
                                     [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                 }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
