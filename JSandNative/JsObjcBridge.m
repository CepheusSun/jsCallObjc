//
//  JsObjcModel.m
//  JSandNative
//
//  Created by 孙扬 on 16/8/24.
//  Copyright © 2016年 MichealSun. All rights reserved.
//

#import "JsObjcBridge.h"

@implementation JsObjcBridge

- (void)jsCallNativeWithParam:(NSDictionary *)param{
    self.pSJsObjcBridgeBlock(param);
}

- (NSString *)jsCallNativeWithParamWithReturn:(NSDictionary *)param{
    return self.pSJsObjcBridgeBlockWithReturn(param);
}

@end
