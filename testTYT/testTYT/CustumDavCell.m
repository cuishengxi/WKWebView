//
//  CustumDavCell.m
//  testTYT
//
//  Created by edz on 2018/3/21.
//  Copyright © 2018年 ManMeng. All rights reserved.
//

#import "CustumDavCell.h"
#define CurrentScreenWidth  [UIScreen mainScreen].bounds.size.width
#define CurrentScreenHeighth  [UIScreen mainScreen].bounds.size.height
@implementation CustumDavCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
       
        self.contentView.backgroundColor = [UIColor grayColor];
        [self creatSubviews];
    }
    return self;
}
- (void)creatSubviews
{
    WKWebViewConfiguration *confifg = [[WKWebViewConfiguration alloc] init];
    confifg.selectionGranularity = WKSelectionGranularityCharacter;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(14, 0, CurrentScreenWidth-28, 1) configuration:confifg];
    self.contentView.backgroundColor = [UIColor whiteColor];
    // _webView.scalesPageToFit = NO;
    _webView.scrollView.scrollEnabled=NO;
    _webView.userInteractionEnabled = NO;
    _webView.opaque = NO;
    _webView.scrollView.bounces=NO;
    _webView.backgroundColor=[UIColor whiteColor];;
    _webView.scrollView.decelerationRate=UIScrollViewDecelerationRateNormal;
    [self.contentView addSubview:_webView];
}
- (void)setDetail:(NSString *)detail
{
    if(!_detail){
        _detail = detail;
        if (_detail.length >0) {
            
            NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "</head> \n"
                               "<body>"
                               "<meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\" name=\"viewport\" />"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               "$img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "<div id=\"testDiv\" style = \"height:100px; width:100px\"></div>"
                               "</body>"
                               "</html>",_detail];
            [self.webView loadHTMLString:htmls baseURL:nil];
//            [_webView loadHTMLString:[NSString stringWithFormat:@"<meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\" name=\"viewport\" />%@<div id=\"testDiv\" style = \"height:100px; width:100px\"></div>",_detail] baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
