//
//  ViewController.m
//  testTYT
//
//  Created by edz on 2018/3/16.
//  Copyright © 2018年 ManMeng. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CustumDavCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>
{
    CGFloat webHeight;
}
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)WKWebView*webView;
@property(nonatomic,assign)CGFloat type;
@property(nonatomic,strong)UIView*headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView=self.headerView;
    
    [self.view addSubview:self.tableView];
    
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_type == 1&&indexPath.row==0){
        return webHeight;
    }// 当前tableview是加载web状态时 cell返回高度
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CustumDavCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        _webView = cell.webView;
        cell.webView.navigationDelegate = self;
        cell.webView.UIDelegate = self;
        cell.selectionStyle = 0;
        _type=1;
        cell.detail = @"<img src=\"http://resource.xing6688.com/data/image/font/e/36/66784.png\" alt=\"\" />";
        return cell;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementById(\"testDiv\").offsetTop"completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        //获取页面高度，并重置webview的frame
        CGFloat lastHeight  = [result doubleValue];
        webView.frame = CGRectMake(14, 0, self.view.bounds.size.width - 28, lastHeight);
        webHeight = lastHeight;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];

}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*v=[UIView new];
    v.backgroundColor=[UIColor redColor];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击改变头部视图的高度
    [self.tableView beginUpdates];
    self.headerView.backgroundColor=[UIColor blueColor];
    self.headerView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 300);
    [self.tableView setTableHeaderView: self.headerView];
    [self.tableView endUpdates];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断webView所在的cell是否可见，如果可见就layout
    NSArray *cells = self.tableView.visibleCells;
    for (CustumDavCell *cell in cells) {
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            CustumDavCell *webCell = (CustumDavCell *)cell;
            [webCell.webView setNeedsLayout];
        }
    }
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[CustumDavCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(WKWebView*)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:config];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView*)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]init];
        _headerView.frame=CGRectMake(0, 0, 10, 10);
        _headerView.backgroundColor=[UIColor redColor];
    }
    return _headerView;
}

@end
