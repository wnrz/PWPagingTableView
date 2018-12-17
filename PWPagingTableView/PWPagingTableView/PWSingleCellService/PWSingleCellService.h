//
//  PWPagingTableViewService.h
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PWPagingTableViewService.h"
#import "PWSingleCellServiceCell.h"
#import "PWSingleCellServiceBridge.h"

@interface PWSingleCellService : PWPagingTableViewService{
    PWSingleCellServiceBridge *_bridge;
}

@property (nonatomic , strong , readonly) PWSingleCellServiceBridge *bridge;
- (id)initWihtCellClass:(Class)cellClass bridge:(PWSingleCellServiceBridge *)bridge;
- (void)setCell:(Class)cellClass;
- (void)dataArrayChanged;
@end
