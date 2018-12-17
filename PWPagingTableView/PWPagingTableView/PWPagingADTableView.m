//
//  PWPagingTableView.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWPagingADTableView.h"
#import "PWPagingTableViewService.h"

@implementation PWPagingADTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.services = [[NSMutableArray alloc] init];
        self.topBottomSwich = NO;
        self.enableTopRefresh = YES;
        self.enableBottomRefresh = YES;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.services = [[NSMutableArray alloc] init];
        self.topBottomSwich = NO;
        self.enableTopRefresh = YES;
        self.enableBottomRefresh = YES;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.services = [[NSMutableArray alloc] init];
        self.topBottomSwich = NO;
        self.enableTopRefresh = YES;
        self.enableBottomRefresh = YES;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (void)viewWillAppear{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        if ([service respondsToSelector:@selector(viewWillAppear)]) {
            [service performSelector:@selector(viewWillAppear) withObject:nil];
        }
    }
}

- (void)viewWillDisappear{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        if ([service respondsToSelector:@selector(viewWillDisappear)]) {
            [service performSelector:@selector(viewWillDisappear) withObject:nil];
        }
    }
}

- (void)viewDidAppear{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        if ([service respondsToSelector:@selector(viewDidAppear)]) {
            [service performSelector:@selector(viewDidAppear) withObject:nil];
        }
    }
}

- (void)viewDidDisappear{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        if ([service respondsToSelector:@selector(viewDidDisappear)]) {
            [service performSelector:@selector(viewDidDisappear) withObject:nil];
        }
    }
}

- (void)setData:(NSDictionary *)dict toClass:(__unsafe_unretained Class)toClass{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        if (toClass == nil || [service isKindOfClass:toClass]) {
            if ([service respondsToSelector:@selector(setData:)]) {
                [service performSelector:@selector(setData:) withObject:dict];
            }
        }
    }
}

- (void)setServices:(NSMutableArray *)services{
    _services = services;
    for (int i = 0 ; i < services.count; i++) {
        id service = _services[i];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            ((PWPagingTableViewService *)service).tableview = self;
        }
    }
}

- (void)setEnableTopRefresh:(BOOL)enableTopRefresh{
    _enableTopRefresh = enableTopRefresh;
    if (enableTopRefresh) {
        [self setupHeader];
    }else{
        if (_refreshHeader) {
            [_refreshHeader removeFromSuperview];
            _refreshHeader = nil;
        }
    }
}

- (void)setEnableBottomRefresh:(BOOL)enableBottomRefresh{
    _enableBottomRefresh = enableBottomRefresh;
    if (enableBottomRefresh) {
        [self setupFooter];
    }else{
        if (_refreshFooter) {
            [_refreshFooter removeFromSuperview];
            _refreshFooter = nil;
        }
    }
}

- (void)setupHeader
{
    if (NSClassFromString(@"SDRefreshHeaderView")) {
        id refreshHeader = [[NSClassFromString(@"SDRefreshHeaderView") alloc] init];
        
        [refreshHeader performSelector:@selector(addToScrollView:) withObject:self];
        BOOL myBoolValue =  NO;
        NSMethodSignature* signature = [[refreshHeader class] instanceMethodSignatureForSelector: @selector(isEffectedByNavigationController:)];
        if (signature) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = refreshHeader;
            invocation.selector = @selector(isEffectedByNavigationController:);
            [invocation setArgument:&myBoolValue atIndex:2];
            [invocation invoke];
        }
        // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
        
        __weak typeof(self) weakSelf = self;
        [refreshHeader performSelector:@selector(setBeginRefreshingOperation:) withObject:^{
            for (int i = 0 ; i < self->_services.count; i++) {
                id service = self->_services[i];
                if ([service isKindOfClass:[PWPagingTableViewService class]]) {
                    if (weakSelf.topBottomSwich && ((PWPagingTableViewService *)service).canLoadMore) {
                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageNum + ((PWPagingTableViewService *)service).pageRange;
                        ((PWPagingTableViewService *)service).pageNum++;
                    }else{
                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageStart;
                    }
                    if ([service respondsToSelector:@selector(loadData)]) {
                        [service performSelector:@selector(loadData)];
                    }
                }
            }
            if (weakSelf.beginHeaderRefreshingOperation) {
                weakSelf.beginHeaderRefreshingOperation();
            }
            [weakSelf.refreshHeader performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
        }];
        // 进入页面自动加载一次数据
        [refreshHeader performSelector:@selector(autoRefreshWhenViewDidAppear)];
        self.refreshHeader = refreshHeader;
    }
}

- (void)setupFooter
{
    if (NSClassFromString(@"SDRefreshFooterView")) {
        id refreshFooter = [[NSClassFromString(@"SDRefreshFooterView") alloc] init];
        
        [refreshFooter performSelector:@selector(addToScrollView:) withObject:self];
        BOOL myBoolValue = YES; 
        NSMethodSignature* signature = [[refreshFooter class] instanceMethodSignatureForSelector: @selector(isEffectedByNavigationController:)];
        if (signature) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = refreshFooter;
            invocation.selector = @selector(isEffectedByNavigationController:);
            [invocation setArgument:&myBoolValue atIndex:2];
            [invocation invoke];
        }
        // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
        
        __weak typeof(self) weakSelf = self;
        [refreshFooter performSelector:@selector(setBeginRefreshingOperation:) withObject:^{
            for (int i = 0 ; i < self->_services.count; i++) {
                id service = self->_services[i];
                if ([service isKindOfClass:[PWPagingTableViewService class]]) {
                    if (!weakSelf.topBottomSwich && ((PWPagingTableViewService *)service).canLoadMore) {
                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageNum + ((PWPagingTableViewService *)service).pageRange;
                    }else{
                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageStart;
                    }
                    if ([service respondsToSelector:@selector(loadData)]) {
                        [service performSelector:@selector(loadData)];
                    }
                }
            }
            if (weakSelf.beginFooterRefreshingOperation) {
                weakSelf.beginFooterRefreshingOperation();
            }
            [weakSelf.refreshFooter performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
        }];
        self.refreshFooter = refreshFooter;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _services.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(numberOfRows)]) {
                return [[service performSelector:@selector(numberOfRows)] intValue];
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell;
    if (_services.count > indexPath.section) {
        id service = _services[indexPath.section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(cellAtIndex:)]) {
                cell = [service performSelector:@selector(cellAtIndex:) withObject:@(indexPath.row)];
            }
        }
    }
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_services.count > indexPath.section) {
        id service = _services[indexPath.section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(didSelectAtIndex:)]) {
               [service performSelector:@selector(didSelectAtIndex:) withObject:@(indexPath.row)];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(heightForHeader)]) {
                return [service heightForHeader];
            }
//            NSNumber *height = [(PWPagingTableViewService *)service heightForHeader];
//            if ([height isKindOfClass:[UIView class]]) {
//                return [height doubleValue];
//            }
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            UIView *view = [(PWPagingTableViewService *)service viewForHeader];
            if ([view isKindOfClass:[UIView class]]) {
                return view;
            }
        }
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(heightForFooter)]) {
                return [service heightForFooter];
            }
//            NSNumber *height = [(PWPagingTableViewService *)service heightForFooter];
//            if ([height isKindOfClass:[UIView class]]) {
//                return [height doubleValue];
//            }
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            UIView *view = [(PWPagingTableViewService *)service viewForFooter];
            if ([view isKindOfClass:[UIView class]]) {
                return view;
            }
        }
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            [service willDisplayCell:cell forRowAtIndexPath:indexPath];
            return;
        }
    }
    return;
}

- (void)loadData{
    for (int i = 0 ; i < _services.count; i++) {
        id service = _services[i];
        [(PWPagingTableViewService *)service loadData];
    }
}
@end
