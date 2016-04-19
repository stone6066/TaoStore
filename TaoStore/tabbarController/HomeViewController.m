//
//  HomeViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/23.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "HomeViewController.h"
#import "PublicDefine.h"
#import "HomeCollectionViewCell.h"
#import "MJRefresh.h"
#import "ShopViewCell.h"
#import "SVProgressHUD.h"
#import "dealModel.h"
#import "HomeHeaderCellView.h"



@interface HomeViewController ()
{
    NSMutableArray *_dataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSMutableArray *_fakeColor;
    
    UITextField * _seachTextF;
    NSMutableArray *_menuArray;
    UIButton *btn;
    NSString *_homeAllwaysFlash;
    NSMutableArray *_dataSource1;
    NSMutableArray *_dataSource2;
    NSMutableArray *_dataSource3;
    NSArray *HomeAreaImgArr;
}
@property(nonatomic,strong)UIButton *topBtn;

@end

@implementation HomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"首页";
        
        self.tabBarItem.title=tittxt;
        
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}

-(void)dealloc
{

}

static NSString * const reuseIdentifier = @"MainCell";
static NSString * const cellIndentifier = @"menucell";


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    _dataSource1 = [NSMutableArray array];
    _dataSource2 = [NSMutableArray array];
    _dataSource3 = [NSMutableArray array];
    HomeAreaImgArr=[[NSArray alloc]initWithObjects:@"http://img-ta-01.b0.upaiyun.com/14501731824942597.jpg",@"http://img-ta-01.b0.upaiyun.com/14501731913836533.jpg",@"http://img-ta-01.b0.upaiyun.com/14501732051780326.jpg",@"http://img-ta-01.b0.upaiyun.com/14501732166057415.jpg",@"http://img-ta-01.b0.upaiyun.com/14501732275660418.jpg",@"http://img-ta-01.b0.upaiyun.com/14501732363305851.jpg", nil];
    [self loadSeachView];
    
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"menuData" ofType:@"plist"];
    //_menuArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [self loadHomeCollectionView];
    [self loadBackToTopBtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
   
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_seachTextF resignFirstResponder];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

static NSString * const aoScrollid = @"aoScrollid";//轮播页面
-(void)loadHomeCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor = collectionBgdColor;//
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    UINib *homeHeader=[UINib nibWithNibName:@"HomeHeaderCellView" bundle:nil];
    [self.collectionView registerNib:homeHeader forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeHeader"];
    
    [self.collectionView registerClass:[ADCollectionViewCell  class] forCellWithReuseIdentifier:cellIndentifier];
    
    [self.collectionView registerClass:[AOScrollerView  class] forCellWithReuseIdentifier:aoScrollid];
    
    [self.collectionView registerClass:[AreaCell  class] forCellWithReuseIdentifier:@"AreaCellId"];
    
    _homeAllwaysFlash=@"0";
    //[self setHomeLastUpdateTime];
    
    _pageindex=1;
    [self loadCollectionViewData:_pageindex];
    
    // 下拉刷新
     __unsafe_unretained __typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadCollectionViewData:_pageindex];
        [weakSelf.collectionView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
   
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _pageindex+=1;
        [self loadCollectionViewData:_pageindex];
        // 结束刷新
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
   
}

-(void)loadCollectionViewData:(NSInteger)pageNo{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    //NSString *urlStr = [NSString stringWithFormat:@"%@%@",NetUrl,@"UsrStore.asmx/GetPartsList"];
    
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                @"pageNo":[NSString stringWithFormat:@"%d",1],
                                @"pageSize":[NSString stringWithFormat:@"%d",20]
                                };
    NSString *PN=[NSString stringWithFormat:@"%@%ld",@"&pageNo=",pageNo];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",NetUrl,@"&ut=indexVilliageGoods",PN];
   
    [ApplicationDelegate.httpManager GET:urlstr
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
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                         if ([suc isEqualToString:@"ok"]) {
                                              //成功
                                              [SVProgressHUD showSuccessWithStatus:k_Success_Load];
                                              dealModel *dm=[[dealModel alloc]init];
                                              NSArray *tmpArr= [dm asignModelWithDict:jsonDic];
                                              if (_pageindex==1) {
                                                  [_dataSource removeAllObjects];
                                              }
                                              [_dataSource addObjectsFromArray:tmpArr];
                                              [self makeDataSource];
                                              [self.collectionView reloadData];
                                              
                                              
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

-(void)makeDataSource{
    NSLog(@"count:%ld",_dataSource.count);
    if(_dataSource.count>12)
    {
        [_dataSource1 removeAllObjects];
        [_dataSource2 removeAllObjects];
        [_dataSource3 removeAllObjects];
        for (int i=0; i<6; i++) {
            [_dataSource1 addObject:_dataSource[i]];
        }
        for (int i=6; i<12; i++) {
            [_dataSource2 addObject:_dataSource[i]];
        }
        for (int i=12; i<_dataSource.count; i++) {
            [_dataSource3 addObject:_dataSource[i]];
        }
    }
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (3==section) {
        return _dataSource1.count;
    }
    if (4==section) {
        return _dataSource2.count;
    }
    if (5==section) {
        return _dataSource3.count;
    }
    else
        return 1;
    

}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

//调整header的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ((0==section)||(1==section)||(2==section)) {
        return CGSizeMake(fDeviceWidth, 0);
    }
    else
        return CGSizeMake(fDeviceWidth, 50);
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //轮播加载============================
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:HomeAdUrl1,HomeAdUrl2,HomeAdUrl3,nil];
        //设置标题数组
        NSMutableArray *strArr = [[NSMutableArray alloc]initWithObjects:@"餐企商超",@"物流信息",@"商务服务", nil];
        
        NSMutableArray *urlArr = [[NSMutableArray alloc]initWithObjects:@"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg",@"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg",@"http://img-ta-01.b0.upaiyun.com/14609471436342429.jpg",nil];
        
        
        _myheaderView=[[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr dealUrl:urlArr height:AdHight];
        //设置委托
        _myheaderView.vDelegate=self;
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:aoScrollid forIndexPath:indexPath];
        [cell addSubview:_myheaderView];//头部广告栏
        
        return cell;
        
    }
    else  if (indexPath.section==1)
    {
        ADCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
        cell=[cell initWithFrame:CGRectMake(0, 0, fDeviceWidth, 160) AdShowType:1];
        cell.delegate=self;
        
        //NSLog(@"NSIndexPath:%ld",indexPath.item);
        return cell;

    }
    else  if (indexPath.section==2)
    {
        
        AreaCell *Acell = [[AreaCell alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 160) imgArr:HomeAreaImgArr];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AreaCellId" forIndexPath:indexPath];
        Acell.delegate=self;
        [cell addSubview:Acell];
        return cell;
    }
    else  if (indexPath.section==3)
    {
        ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        dealModel *md=_dataSource1[indexPath.item];
        [cell showUIWithModel:md];
        return cell;
    }
    else  if (indexPath.section==4)
    {
        ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        dealModel *md=_dataSource2[indexPath.item];
        [cell showUIWithModel:md];
        return cell;
    }
    else
    {
        ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        dealModel *md=_dataSource3[indexPath.item];
        [cell showUIWithModel:md];
        return cell;
    }
    //[cell sizeToFit];
}

-(void)AreaBtnClick:(NSInteger)sendTag{
    NSLog(@"AreaBtnClick:%ld",sendTag);
}
//头部显示的内容_mySeparateView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    {
        
        HomeHeaderCellView *headerView =  [collectionView dequeueReusableSupplementaryViewOfKind :
                                           UICollectionElementKindSectionHeader   withReuseIdentifier:@"homeHeader"   forIndexPath:indexPath];
        if (indexPath.section==3)
        {
            headerView.mainTitle.text=@"新品推荐";
            headerView.dealTitle.text=@"当季食材 先享为快";
        }
        else if (indexPath.section==4)
        {
            headerView.mainTitle.text=@"健康蔬果";
            headerView.dealTitle.text=@"产地直供 每天到家";
        }
        else if (indexPath.section==5)
        {
            headerView.mainTitle.text=@"热门推荐";
            headerView.dealTitle.text=@"爆款美食 任君挑选";
        }
        return headerView;
    }
    
}




#pragma mark --UICollectionViewDelegateFlowLayout

-(CGSize) getHomeViewStyle:(NSInteger)viewCellIndex
{
    switch (viewCellIndex) {
        case 3:
            return CGSizeMake((fDeviceWidth/3)-3, fDeviceWidth/3+62);
            break;
        case 4:
            return  CGSizeMake((fDeviceWidth/3)-3, fDeviceWidth/3+62);
            break;
        case 5:
            return  CGSizeMake((fDeviceWidth/2)-3, fDeviceWidth/2+62);
            break;
        default:
            return  CGSizeMake((fDeviceWidth/2)-3, HomeCellHeight);
            break;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return  CGSizeMake(fDeviceWidth-2, AdHight);
            break;
        case 1:
            return  CGSizeMake(fDeviceWidth-4, 158);
            break;
        case 2:
            return  CGSizeMake(fDeviceWidth-4, 158);
            break;
        default:
            return [self getHomeViewStyle:indexPath.section];
            break;
    }
    
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
    if (indexPath.section==0) {
        
        NSLog(@"%ld---%ld---select:",indexPath.section,indexPath.item);
    }
    else
    {
       NSLog(@"%ld---%ld---select:",indexPath.section,indexPath.item);
    }
    
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hiddenKeyBoard
{
    if ([_seachTextF isFirstResponder]) {
        [_seachTextF resignFirstResponder];
    }
}

UIImage * bundleImageImageName(NSString  *imageName)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",imageName] ofType:nil inDirectory:@""];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
    return image;
}
- (void)loadSeachView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
//    UIImageView * seachLogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
//    seachLogo.userInteractionEnabled = YES;
//    seachLogo.image =[UIImage imageNamed:@"topLogo"];
//    seachLogo.userInteractionEnabled = YES;
//    [topSearch addSubview:seachLogo];
    
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
    UIColor *mycolor=[UIColor whiteColor];
    _seachTextF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索你喜欢的商品" attributes:@{NSForegroundColorAttributeName: mycolor}];
    
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
    
}
- (void)doScan:(UIButton *)button
{
   
//    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
//    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
//        [aqrvc dismissViewControllerAnimated:NO completion:nil];
//        goodsViewController *goodsView=[[goodsViewController alloc]init];
//        goodsView.hidesBottomBarWhenPushed=YES;
//        goodsView.navigationItem.hidesBackButton=YES;
//        
//        [goodsView setGoodsUrl:qrString];
//        [self.navigationController pushViewController:goodsView animated:YES];
//        
//    };
//    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
//        [aqrvc dismissViewControllerAnimated:NO completion:nil];
//    };
//    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
//        [aqrvc dismissViewControllerAnimated:NO completion:nil];
//    };
//    [self presentViewController:qrcodevc animated:YES completion:nil];
}
-(void)hideTabbar{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:YES];
        }
    }
}

-(void)showTabbar{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:NO];
        }
    }
}

- (void)shortCutClick:(NSInteger)sendTag{
    NSString *strurl=@"";
    NSString *titleStr=@"淘翼夏";
    switch (sendTag) {
        case 10:
            ;
            break;
        case 11:
            {
             strurl=@"http://m.kuaidi100.com/";
             titleStr=@"查快递";
            }
            break;
        case 12:
            strurl=@"http://m.kuaidi100.com/network/plist.jsp";
            titleStr=@"寄快递";
            
            break;
        case 13:
            strurl=@"http://m.tuniu.com/";
            titleStr=@"景点门票";
            
            break;
        default:
            break;
    }
   
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    [self doSeach:nil];
    return YES;
}

//轮播广告点击跳转事件
#pragma AOScrollViewDelegate
-(void)buttonClick:(NSString*)vid vname:(NSString*)vname{
    NSString *strurl=vid;
    NSString *titleStr=vname;
    if ([strurl length]>0) {
        NSLog(@"跳转链接不为空");
    }
    else{
        NSLog(@"跳转链接为空");
    }
    
}

@end
