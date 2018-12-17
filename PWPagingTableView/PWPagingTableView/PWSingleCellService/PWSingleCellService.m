//
//  PWPagingTableViewService.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWSingleCellService.h"
#import "PWSingleCellServiceCell.h"
#import <Masonry/Masonry.h>

@interface PWSingleCellService() {
    Class _cellClass;
}
@end

@implementation PWSingleCellService

- (id)initWihtCellClass:(Class)cellClass bridge:(PWSingleCellServiceBridge *)bridge{
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _bridge = bridge;
        _bridge.service = self;
        [_bridge addBridgeObserver:self forKeyPath:@"dataArray" action:@selector(dataArrayChanged)];
    }
    return self;
}

- (void)dealloc{
    _cellClass = nil;
    _bridge.service = nil;
    [_bridge removeAllBridge];
    _bridge = nil;
}

- (void)setCell:(Class)cellClass{
    NSAssert(cellClass != nil, @"%@必须传入PWSingleCellServiceCell或者继承PWSingleCellServiceCell的类型" , self.class);
    _cellClass = cellClass;
    [self.tableview reloadData];
}

- (void)dataArrayChanged{
    [self.tableview reloadData];
}

- (PWSingleCellServiceBridge *)bridge{
    NSAssert(_bridge != nil, @"%@必须设置类型是PWSingleCellServiceBridge或者继承PWSingleCellServiceBridge的bridge" , self.class);
    return _bridge;
}

- (NSInteger)numberOfRows{
    NSAssert(_bridge != nil, @"%@必须设置类型是PWSingleCellServiceBridge或者继承PWSingleCellServiceBridge的bridge" , self.class);
    return _bridge.dataArray.count;
}

- (CGFloat)heightAtIndex:(NSInteger)index{
    NSAssert(_cellClass != nil, @"%@必须设置cellClass为类型是PWSingleCellServiceCell或者继承PWSingleCellServiceCell的Class" , self.class);
    NSAssert(_bridge != nil, @"%@必须设置类型是PWSingleCellServiceBridge或者继承PWSingleCellServiceBridge的bridge" , self.class);
    CGFloat height = 50;
    Class cN = _cellClass;
    SEL action = NSSelectorFromString(@"heightWithDict:");
    IMP imp = [cN methodForSelector:action];
    if (imp != nil) {
        CGFloat (*func)(id, SEL, id) = (void *)imp;
        height = func(cN, action, _bridge.dataArray.count > index ? _bridge.dataArray[index] : nil);
    }
    return height;
}

- (UITableViewCell *)cellAtIndex:(NSInteger)index{
    NSAssert(_cellClass != nil, @"%@必须设置cellClass为类型是PWSingleCellServiceCell或者继承PWSingleCellServiceCell的Class" , self.class);
    NSAssert(_bridge != nil, @"%@必须设置类型是PWSingleCellServiceBridge或者继承PWSingleCellServiceBridge的bridge" , self.class);
    PWSingleCellServiceCell * cell = [self.tableview dequeueReusableCellWithIdentifier:[_cellClass performSelector:@selector(identifier)]];
    if (!cell) {
        cell = [[_cellClass alloc] init];
    }
    if (_bridge.dataArray.count > index) {
        [cell setDict:_bridge.dataArray[index]];
    }
    return cell;
}
@end
