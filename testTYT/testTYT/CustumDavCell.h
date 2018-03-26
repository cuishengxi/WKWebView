//
//  CustumDavCell.h
//  testTYT
//
//  Created by edz on 2018/3/21.
//  Copyright © 2018年 ManMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface CustumDavCell : UITableViewCell
@property(nonatomic,strong)WKWebView*webView;
@property(nonatomic,copy)NSString*detail;
@end
