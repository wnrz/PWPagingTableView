//
//  PWPagingTableViewTools.m
//  PWPagingTableView
//
//  Created by 王宁 on 2018/12/17.
//  Copyright © 2018年 peter wang. All rights reserved.
//

#import "PWPagingTableViewTools.h"

@implementation PWPagingTableViewTools


+ (NSBundle *)bundleWith:(Class)fromClass fileName:(NSString *)fileName fileType:(NSString *)fileType{
    __block NSBundle *bundle;
    NSArray *arr = [[NSBundle bundleForClass:fromClass] pathsForResourcesOfType:@"bundle" inDirectory:nil];
    __block NSString *path;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bundlePath = obj;
        path = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:fileType];
        if (path.length > 0) {
            bundle = [NSBundle bundleWithPath:bundlePath];
            *stop = YES;
        }
    }];
    return bundle;
}

+ (void)clearSubviews:(UIView *)view{
    if ([view isKindOfClass:[UIView class]]) {
        NSArray *subviews = [NSArray arrayWithArray:view.subviews];
        for (NSInteger i = subviews.count - 1 ; i >= 0 ; i--) {
            UIView *v = subviews[i];
            [v removeFromSuperview];
            v = nil;
        }
    }
}
@end
