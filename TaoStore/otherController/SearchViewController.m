//
//  SearchViewController.m
//  TaoStore
//
//  Created by tianan-apple on 16/4/25.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "SearchViewController.h"
#import "PublicDefine.h"
#import "SYQRCodeViewController.h"
#import "ShortCutViewController.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "goodsSectionHome.h"
#import "ShopViewCell.h"
#import "goodsHome.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sortType=@"3D";//默认 创建时间
    
    
    [self loadSeachView];
    [self loadCollectionView];
    [self loadBackToTopBtn];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-TopSeachHigh-40, 40, 40);
    [_topBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _topBtn.clipsToBounds = YES;
    _topBtn.hidden = YES;
    [self.view addSubview:_topBtn];
}
- (void)backToTopButton{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}
// MARK:  计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //MARK:列表滑动偏移量计算
    CGPoint point = [self.collectionView contentOffset];
    
    if (point.y >= self.collectionView.frame.size.height) {
        self.topBtn.hidden = NO;
        [self.view bringSubviewToFront:self.topBtn];
    } else {
        self.topBtn.hidden = YES;
    }
}

-(void)initTopImg:(UIView*)backView{
    CGFloat btnWidth=fDeviceWidth/4 -5;
    CGFloat imgSpear=fDeviceWidth/4 -5;
    CGFloat imgLeftX=50;
    _upImgArr=[[NSMutableArray alloc]init];
    _downImgArr=[[NSMutableArray alloc]init];


    _defaultTitle=[[UILabel alloc]initWithFrame:CGRectMake(12, 2, 60, 40)];
    _defaultTitle.text=@"默认";
    _defaultTitle.font=[UIFont systemFontOfSize:15];
    _defaultTitle.textColor=[UIColor blackColor];
    
    _saleNumsTitle=[[UILabel alloc]initWithFrame:CGRectMake(12+imgSpear, 2, 60, 40)];
    _saleNumsTitle.text=@"销量";
    _saleNumsTitle.font=[UIFont systemFontOfSize:15];
    _saleNumsTitle.textColor=[UIColor blackColor];
    
    _priceTitle=[[UILabel alloc]initWithFrame:CGRectMake(12+imgSpear*2, 2, 60, 40)];
    _priceTitle.text=@"价格";
    _priceTitle.font=[UIFont systemFontOfSize:15];
    _priceTitle.textColor=[UIColor blackColor];
    
    _populTitle=[[UILabel alloc]initWithFrame:CGRectMake(12+imgSpear*3, 2, 60, 40)];
    _populTitle.text=@"人气";
    _populTitle.font=[UIFont systemFontOfSize:15];
    _populTitle.textColor=[UIColor blackColor];
    
    [backView addSubview:_defaultTitle];
    [backView addSubview:_saleNumsTitle];
    [backView addSubview:_priceTitle];
    [backView addSubview:_populTitle];
    
    for (int i=0; i<4; i++) {
        UIImageView *upImg=[[UIImageView alloc]initWithFrame:CGRectMake(imgLeftX+i*imgSpear, 10, 12, 12)];
        UIImageView *downImg=[[UIImageView alloc]initWithFrame:CGRectMake(imgLeftX+i*imgSpear, 20, 12, 12)];
        if (i==0) {
            upImg.image=[UIImage imageNamed:@"top_1"];
        }
        else
            upImg.image=[UIImage imageNamed:@"top"];
        
        downImg.image=[UIImage imageNamed:@"bottom"];
        
        [backView addSubview:upImg];
        [backView addSubview:downImg];
        [_upImgArr addObject:upImg];
        [_downImgArr addObject:downImg];
        UIButton *sortBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [sortBtn setFrame:CGRectMake(2+i*(fDeviceWidth/4), 2, btnWidth, 40)];
        sortBtn.tag=i;
        [sortBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:sortBtn];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSearchToken:(NSString *)searchToken{
    _searchToken=searchToken;
}

-(void)setTopImg:(NSInteger)imgIdex upDown:(NSInteger)imgFlag{
    for (int i=0; i<4; i++) {
        UIImageView * imgTmp=_upImgArr[i];
         UIImageView * imgTmp1=_downImgArr[i];
        if (i==imgIdex) {
            if (imgFlag==0) {
                imgTmp.image=[UIImage imageNamed:@"top_1"];
                imgTmp1.image=[UIImage imageNamed:@"bottom"];
            }
            else
            {
                imgTmp.image=[UIImage imageNamed:@"top"];
                imgTmp1.image=[UIImage imageNamed:@"bottom_1"];
            }
        }
        else
        {
            imgTmp.image=[UIImage imageNamed:@"top"];
            imgTmp1.image=[UIImage imageNamed:@"bottom"];
        }
        
        
    }

}

-(void)sortBtnClick:(UIButton *)button{
    NSInteger imgflags=0;
    switch (button.tag) {
        case 0://默认点击
            if ([_sortType isEqualToString:@"3D"]) {
                _sortType=@"33D";
                imgflags=1;
                
            }
            else
            {
                _sortType=@"3D";
                imgflags=0;
            }
            break;
        case 1://销量
            if ([_sortType isEqualToString:@"2D"]) {
                _sortType=@"22D";
                imgflags=1;
            }
            else
            {
                _sortType=@"2D";
                imgflags=0;
            }
            break;
        case 2://价格
            if ([_sortType isEqualToString:@"1D"]) {
                _sortType=@"11D";
                imgflags=1;
            }
            else
            {
                _sortType=@"1D";
                imgflags=0;
            }
            break;
        case 3://人气
            if ([_sortType isEqualToString:@"4D"]) {
                _sortType=@"44D";
                imgflags=1;
            }
            else
            {
                _sortType=@"4D";
                imgflags=0;
            }
            break;
        default:
            break;
    }
    [self setTopImg:button.tag upDown:imgflags];
    _pageindex=1;
    [self loadCollectionViewData:_pageindex sortType:_sortType];
}
-(void)loadSortBarView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 45)];
    
    
    //sortBtn.backgroundColor=[UIColor redColor];
    [self initTopImg:topView];
    topView.backgroundColor=MyGrayColor;
   
    [self.view addSubview:topView];
}
-(void)loadCollectionView{
    [self loadSortBarView];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+45, fDeviceWidth, fDeviceHeight-TopSeachHigh-45) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor =collectionBgdColor;// [UIColor whiteColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainCell"];
    
    _pageindex=1;
    //_sortAllwaysFlash=@"0";
    
    _dataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    [self loadCollectionViewData:_pageindex sortType:_sortType];
    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadCollectionViewData:_pageindex sortType:_sortType];
        [weakSelf.collectionView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_dataSource.count>0) {
            _pageindex+=1;
        }
        else
            _pageindex=1;
        [self loadCollectionViewData:_pageindex sortType:_sortType];
        // 结束刷新
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
}


-(void)loadCollectionViewData:(NSInteger)pageno sortType:(NSString*)sType{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    //NSString *urlStr = [NSString stringWithFormat:@"%@%@",NetUrl,@"UsrStore.asmx/GetPartsList"];
    
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                @"pageNo":[NSString stringWithFormat:@"%d",1],
                                @"pageSize":[NSString stringWithFormat:@"%d",20]
                                };
    //    NSString *PN=[NSString stringWithFormat:@"%@%d",@"&pageNo=",pageNo];POST
    //     NSString *urlstr=[NSString stringWithFormat:@"%@%@",NetUrl,@"&ut=indexVilliageGoods"];
    //
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%ld",BaseUrl,BasePath,@"interface/searchgoods.htm?title=",_searchToken,@"&sort=",sType,@"&pb.pageSize=20",@"&pb.pageNo=",(long)pageno];
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
                                              goodsSectionHome *gHome=[[goodsSectionHome alloc]init];
                                              if (1==pageno) {
                                                  _dataSource=[gHome assignGoodsWithDict:jsonDic];
                                              }
                                              else{
                                                  [_dataSource addObjectsFromArray:[gHome assignGoodsWithDict:jsonDic]];
                                              }
                                              //[_dataSource addObjectsFromArray:arrtmp];
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
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    //[cell sizeToFit];
    goodsHome *md=_dataSource[indexPath.item];
    [cell showUIWithModel:md];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((fDeviceWidth/2)-3, HomeCellHeight);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2, 2, 2);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每行UICollectionCellView 的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodsHome *md=_dataSource[indexPath.item];
   
    
    [self loadGoodsView:md.goodsDealUrl];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)loadGoodsView:(NSString*)goods_url{
    ShortCutViewController * goodsView=[[ShortCutViewController alloc]init];
    [goodsView setWeburl:goods_url];
    [goodsView setTopTitle:@"商品详情"];
    goodsView.hidesBottomBarWhenPushed=YES;
    goodsView.navigationItem.hidesBackButton=YES;
    goodsView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:goodsView animated:YES];
    
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
    
    //scanBtn.backgroundColor=[UIColor yellowColor];
    [scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:scanBtn];
    
    //    UIBarButtonItem *topBarBtn=[[UIBarButtonItem alloc]initWithCustomView:topSearch];
    //    self.navigationItem.rightBarButtonItem=topBarBtn;
    [self.view addSubview:topSearch];
    
    
    _seachTextF = [[UITextField alloc] initWithFrame:CGRectMake(35, -1, fDeviceWidth-100-35, 35)];
    _seachTextF.backgroundColor = [UIColor clearColor];
    [_seachTextF setTintColor:[UIColor blueColor]];
    _seachTextF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
   // UIColor *mycolor=[UIColor whiteColor];
//    _seachTextF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索你喜欢的商品" attributes:@{NSForegroundColorAttributeName: mycolor}];
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


- (void)doSeach:(UIButton *)button
{
    _pageindex=1;
    _sortType=@"1D";
    [self loadCollectionViewData:_pageindex sortType:_sortType];
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


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_seachTextF resignFirstResponder];
}

-(void)hiddenKeyBoard
{
    if ([_seachTextF isFirstResponder]) {
        [_seachTextF resignFirstResponder];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    [self doSeach:nil];
    return YES;
}
@end
