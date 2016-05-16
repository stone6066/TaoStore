//
//  SerachShopViewController.m
//  TaoStore
//
//  Created by tianan-apple on 16/5/12.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SerachShopViewController.h"
#import "PublicDefine.h"
#import "SYQRCodeViewController.h"
#import "ShortCutViewController.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface SerachShopViewController ()

@end

@implementation SerachShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSeachView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadSeachView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 26, 60, 24)];
    backImg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backImg];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setFrame:CGRectMake(0, 22, 50, 44)];
    
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    //back.backgroundColor=[UIColor yellowColor];
    [topSearch addSubview:back];
    
    
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
    
    
    [scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:scanBtn];
    
   
    [self.view addSubview:topSearch];
    
    
    _seachTextF = [[UITextField alloc] initWithFrame:CGRectMake(35, -1, fDeviceWidth-100-35, 35)];
    _seachTextF.backgroundColor = [UIColor clearColor];
    [_seachTextF setTintColor:[UIColor blueColor]];
    _seachTextF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
   
    _seachTextF.text=_searchToken;
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

- (void)doScan:(UIButton *)button
{
    
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
        ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
        shortCutView.hidesBottomBarWhenPushed=YES;
        shortCutView.navigationItem.hidesBackButton=YES;
        
        [shortCutView setWeburl:qrString];
        [shortCutView setTopTitle:@"商品详情"];
        [shortCutView setScanFlag:1];
        shortCutView.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:shortCutView animated:YES];
        
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
}


-(void)loadCollectionViewData:(NSInteger)pageno sortType:(NSString*)sType{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    //NSString *urlStr = [NSString stringWithFormat:@"%@%@",NetUrl,@"UsrStore.asmx/GetPartsList"];
    
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                @"pageNo":[NSString stringWithFormat:@"%d",1],
                                @"pageSize":[NSString stringWithFormat:@"%d",20]
                                };
   //    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%ld",BaseUrl,@"search/store.htm?name=",_searchToken,@"&sort=",sType,@"&pagesize=20",@"&page=",(long)pageno];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%ld",@"http://192.168.0.211:8080/paistore_m_site/search/store.htm?name=",_searchToken,@"&pagesize=20",@"&page=",(long)pageno];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"ser_urlstr:%@",urlstr);
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
                                          NSLog(@"ser数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"result"];
                                          
                                          //
                                          if ([suc isEqualToString:@"true"]) {
                                              //成功
                                              
                                              [self.collectionView reloadData];
                                              
                                              [SVProgressHUD showSuccessWithStatus:k_Success_Load];
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
