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
@property(nonatomic,copy)NSString *topTitle;
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

-(void)loadCollectionView{
    //[self createBackBtn];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh) collectionViewLayout:flowLayout];
    
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
