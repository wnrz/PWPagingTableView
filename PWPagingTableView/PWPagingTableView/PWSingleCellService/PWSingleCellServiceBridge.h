//
//  PWPagingTableViewService.h
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PWDataBridge/PWBaseDataBridge.h>

@class PWSingleCellService;
@interface PWSingleCellServiceBridge : PWBaseDataBridge{
}

@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , weak) PWSingleCellService *service;

- (void)loadData;
@end
