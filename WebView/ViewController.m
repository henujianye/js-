//
//  ViewController.m
//  WebView
//
//  Created by liuzhike on 17/1/11.
//  Copyright © 2017年 王建业. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic ,weak) UIWebView *webView;


@property WebViewJavascriptBridge *bridge;

@end

@implementation ViewController
- (void)viewDidLoad {
    
    
    //测试一下   Ven_3.0.0
    
    //main_master
    
    

    
    [super viewDidLoad];
    [self setupWebView];
    [self setupBtn];
    [self setupBridge];
    [self JsGetOc];
    [self OcGetJs];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)setupWebView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    self.webView = webView;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:@"http://xytest.staff.xdf.cn/ixue/html/zztest.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)setupBtn{
    UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    callBtn.frame = CGRectMake(50, 300, 100, 56);
    [callBtn setTitle:@"点击交互" forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(ocAndJsinteraction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callBtn aboveSubview:self.webView];

}

- (void)setupBridge{
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];

}

// JS主动调用OjbC的方法
- (void)JsGetOc{
    [self.bridge registerHandler:@"标示" handler:^(id data, WVJBResponseCallback responseCallback) {
        //data -----js传递的数据
        NSLog(@"data -----js传递的数据 : %@",data);
        //给js传递回调的参数
        responseCallback(@{@"给js传递回调的参数":@"xxxxx"});
    }];
}

- (void)OcGetJs{
    id data = @{@"给js传递的参数":@"xxxxxx"};
    [self.bridge callHandler:@"标示" data:data responseCallback:^(id responseData) {
        //js给oc的回调的参数
        NSLog(@"js给oc的回调的参数 : %@",responseData);
    }];
}



- (void)ocAndJsinteraction{
    NSLog(@"OC与JS交互");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *str = @"shareType=";
//    if ([request.URL.absoluteString containsString:str]) {
//        NSArray *ary = [request.URL.absoluteString componentsSeparatedByString:@"shareType="];
//        if ([ary.lastObject isEqualToString:@"ShareWX"]) {
//            NSLog(@"分享给好友");
//            
//        }else if ([ary.lastObject isEqualToString:@"SharePYQ"]){
//            NSLog(@"分享到朋友圈");
//            
//        }
//    }
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
};
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
};
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
};


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
