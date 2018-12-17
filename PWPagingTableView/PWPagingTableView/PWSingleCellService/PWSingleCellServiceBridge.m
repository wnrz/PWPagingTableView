//
//  PWPagingTableViewService.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWSingleCellServiceBridge.h"

@implementation PWSingleCellServiceBridge

- (void)loadData{
    
}

- (NSArray *)dataArray{
    if (_dataArray == nil){
        _dataArray =  [NSArray array];
    }
    return _dataArray;
}
@end
