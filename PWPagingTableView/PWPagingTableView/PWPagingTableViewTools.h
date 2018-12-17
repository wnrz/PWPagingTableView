//
//  PWPagingTableViewTools.h
//  PWPagingTableView
//
//  Created by 王宁 on 2018/12/17.
//  Copyright © 2018年 peter wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWPagingTableViewTools : NSObject

+ (NSBundle *)bundleWith:(Class)fromClass fileName:(NSString *)fileName fileType:(NSString *)fileType;

+ (void)clearSubviews:(UIView *)view;
@end

NS_ASSUME_NONNULL_END

