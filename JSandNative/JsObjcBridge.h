//
//  JsObjcModel.h
//  JSandNative
//
//  Created by 孙扬 on 16/8/24.
//  Copyright © 2016年 MichealSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PsJsObjcDelegate <JSExport>

- (void)jsCallNativeWithParam:(NSDictionary *)param;
- (NSString *)jsCallNativeWithParamWithReturn:(NSDictionary *)param;

@end


@interface JsObjcBridge : NSObject <PsJsObjcDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, copy) void (^pSJsObjcBridgeBlock)(NSDictionary *param);
@property (nonatomic, copy) NSString *(^pSJsObjcBridgeBlockWithReturn)(NSDictionary *param);

@end
