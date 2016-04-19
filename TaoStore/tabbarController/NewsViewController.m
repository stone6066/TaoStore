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


@interface NewsViewController ()
{
    NSMutableArray *_tableDataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;
}
@property(nonatomic,strong)UIButton *topBtn;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadTableView];
    [self loadBackToTopBtn];
    
    // 如果出现加载菊花和tableView重复出现的话，就设置FooterView，因为tableView默认对没有数据的列表也会显示cell
    self.tableView.tableFooterView = [UIView new];
    
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    _pageindex=1;

}
-(void)dealloc
{
    
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
    _pageindex=1;

}

-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-MainTabbarHeight-50, 40, 40);
    [_topBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _topBtn.clipsToBounds = YES;
    _topBtn.hidden = YES;
    [self.view addSubview:_topBtn];
}
- (void)backToTopButton{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
// MARK:  计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //MARK:列表滑动偏移量计算
    CGPoint point = [self.tableView contentOffset];
    
    if (point.y >= self.tableView.frame.size.height) {
        self.topBtn.hidden = NO;
        [self.view bringSubviewToFront:self.topBtn];
    } else {
        self.topBtn.hidden = YES;
    }
}

-(void)loadTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=collectionBgdColor;
    
   
    _tableDataSource=[[NSMutableArray alloc]init];
    _newsAllwaysFlash=@"0";
    //[self setHomeLastUpdateTime];
    // 自动刷新
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-30, 16, 50, 40)];
    viewTitle.text=@"发现";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}


@end
