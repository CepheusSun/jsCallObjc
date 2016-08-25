//
//  PSWebViewController.m
//  JSandNative
//
//  Created by 孙扬 on 16/8/24.
//  Copyright © 2016年 MichealSun. All rights reserved.
//

#import "PSWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JsObjcBridge.h"

@interface PSWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation PSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.jsContext                         = [[JSContext alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"callJS" style:UIBarButtonItemStylePlain target:self action:@selector(objcCallJsFunction)];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"injectJS" style:UIBarButtonItemStylePlain target:self action:@selector(objcInjectJsFunction)];
}

- (void)objcCallJsFunction {
    [self.jsContext[@"jsParamFunc"] callWithArguments:@[ @"ProgramerSunny" ]];
}

- (void)objcInjectJsFunction {
    NSString *js = @"function add(a,b) {alert(a+b)}";
    [self.jsContext evaluateScript:js];
    [self.jsContext[@"add"] callWithArguments:@[ @2, @3 ]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JsObjcBridge *model              = [[JsObjcBridge alloc] init];
    self.jsContext[@"JSInteractive"] = model;
    model.jsContext                  = self.jsContext;
    model.webView                    = self.webView;
    
    model.pSJsObjcBridgeBlock = ^(NSDictionary *param) {
        Class clz = NSClassFromString(param[@"vc"]);
        [self.navigationController pushViewController:[clz new] animated:YES];
    };

    model.pSJsObjcBridgeBlockWithReturn = ^(NSDictionary *param) {
        return param[@"vc"];
    };
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView                 = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        NSURL *url               = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
        NSURLRequest *request    = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    return _webView;
}


@end
