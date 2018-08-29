//
//  IPAPatchEntry.m
//  IPAPatch
//
//  Created by wutian on 2017/3/17.
//  Copyright © 2017年 Weibo. All rights reserved.
//

#import "IPAPatchEntry.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation IPAPatchEntry

+ (void)load
{
    // DO YOUR WORKS...
    [self ph_loadExtension];
    
    // For Example:
//    [self for_example_showAlert];
}

+ (void)ph_loadExtension {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ph_loadFLEX];
    });
}

+ (void)ph_loadFLEX {
    Class theFLEXManagerCls = NSClassFromString(@"FLEXManager");
    
    SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
    id theFLEXManagerInstance = ((id (*)(id, SEL))[theFLEXManagerCls methodForSelector:sharedManagerSelector])(theFLEXManagerCls, sharedManagerSelector);
    
    SEL showExplorerSelector = NSSelectorFromString(@"showExplorer");
    ((void (*)(id, SEL))[theFLEXManagerInstance methodForSelector:showExplorerSelector])(theFLEXManagerInstance, showExplorerSelector);
}

+ (void)for_example_showAlert
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Hacked" message:@"Hacked with IPAPatch" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL]];
        UIViewController * controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }
        [controller presentViewController:alertController animated:YES completion:NULL];
    });
}

@end
