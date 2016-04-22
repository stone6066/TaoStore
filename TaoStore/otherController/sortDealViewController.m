//
//  sortDealViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "sortDealViewController.h"
#import "PublicDefine.h"
#import "MJRefresh.h"
#import "dealModel.h"
#import "ShopViewCell.h"
#import "SVProgressHUD.h"
#import "goodsSectionHome.h"
@interface sortDealViewController ()
{
    NSMutableArray *_dataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSMutableArray *_fakeColor;
    NSString *_sortAllwaysFlash;
}
@property(nonatomic,copy)NSString *sortListId;
@property(nonatomic,copy)NSString *sortType;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,strong)UIImageView *topImg;
@property(nonatomic,strong)UIImageView *bottomImg;
@end


@implementation sortDealViewController
static NSString * const mySortIdentifier = @"MainCell";

-(void)setSortListId:(NSString *)sortListId
{
    _sortListId=sortListId;
}
-(void)setTopTitle:(NSString *)topTitle
{
    _topTitle=topTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sortType=@"1D";
    _topImg=[[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 12, 12)];
    _bottomImg=[[UIImageView alloc]initWithFrame:CGRectMake(50, 20, 12, 12)];
    [self loadNavTopView];
    [self loadCollectionView];
    [self loadBackToTopBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self loadWebView];
   
}



-(void)clickleftbtn{
   
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"left");
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createBackBtn
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //[back setTitle:@"Back" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(5, 2, 60, 24)];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = barButton;
}

-(void)sortBtnClick{
    if ([_sortType isEqualToString:@"1D"]) {
        _sortType=@"11D";
        _topImg.image=[UIImage imageNamed:@"top_1"];
        _bottomImg.image=[UIImage imageNamed:@"bottom"];
    }
    else
    {
        _sortType=@"1D";
        _topImg.image=[UIImage imageNamed:@"top"];
        _bottomImg.image=[UIImage imageNamed:@"bottom_1"];
    }
    _pageindex=1;
    [self loadCollectionViewData:_pageindex sortType:_sortType];
}
-(void)loadSortBarView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 45)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 60, 40)];
    lbl.text=@"价格";
    lbl.font=[UIFont systemFontOfSize:15];
    lbl.textColor=[UIColor blackColor];
    [topView addSubview:lbl];
    _topImg.image=[UIImage imageNamed:@"top"];
    _bottomImg.image=[UIImage imageNamed:@"bottom_1"];
    [topView addSubview:_topImg];
    [topView addSubview:_bottomImg];
    UIButton *sortBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sortBtn setFrame:CGRectMake(2, 2, 60, 40)];
    //sortBtn.backgroundColor=[UIColor redColor];
    [topView addSubview:sortBtn];
    topView.backgroundColor=MyGrayColor;
    [sortBtn addTarget:self action:@selector(sortBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
}
-(void)loadCollectionView{
    //[self createBackBtn];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopViewCell" bundle:nil] forCellWithReuseIdentifier:mySortIdentifier];
    
    _pageindex=1;
    _sortAllwaysFlash=@"0";
    
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
        _pageindex+=1;
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
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%ld",BaseUrl,@"paistore_m_site/interface/getgoodsbycat.htm?catid=",_sortListId,@"&sort=",sType,@"&pageSize=20",@"&pageNo=",pageno];
    //NSLog(@"urlstr:%@",urlstr);
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
    ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mySortIdentifier forIndexPath:indexPath];
    //[cell sizeToFit];
    dealModel *md=_dataSource[indexPath.item];
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

}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态



-(void)dealloc
{
    
}

-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _sortTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sortTopBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-60, 40, 40);
    [_sortTopBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_sortTopBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _sortTopBtn.clipsToBounds = YES;
    _sortTopBtn.hidden = YES;
    [self.view addSubview:_sortTopBtn];
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
        self.sortTopBtn.hidden = NO;
        [self.view bringSubviewToFront:self.sortTopBtn];
    } else {
        self.sortTopBtn.hidden = YES;
    }
}

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //[back setTitle:@"Back" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(8, 24, 60, 24)];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-80, 16, 150, 40)];
    viewTitle.text=_topTitle;
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}

@end
