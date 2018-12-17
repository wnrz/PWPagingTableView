//
//  PWPagingTableView.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWPagingTableView.h"
#import "PWPagingTableViewService.h"
#import "PWPagingTableViewSingleService.h"

@implementation PWPagingTableView

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

- (void)dealloc{
    _mjheader = nil;
    [self setMJH:nil];
    
    _mjFooter = nil;
    [self setMJF:nil];
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
    _singleService = nil;
    [self reloadData];
}

- (void)setSingleService:(PWPagingTableViewSingleService *)singleService{
    if ([singleService isKindOfClass:[PWPagingTableViewSingleService class]]) {
        _singleService = singleService;
        singleService.tableview = self;
    }else if (singleService == nil){
        _singleService = nil;
    }
    [_services removeAllObjects];
    _services = nil;
    [self reloadData];
}

- (void)setEnableTopRefresh:(BOOL)enableTopRefresh{
    _enableTopRefresh = enableTopRefresh;
    if (enableTopRefresh) {
        [self setupHeader];
    }else{
        [self setMJH:nil];
//        if (_refreshHeader) {
//            [_refreshHeader removeFromSuperview];
//            _refreshHeader = nil;
//        }
    }
}

- (void)setEnableBottomRefresh:(BOOL)enableBottomRefresh{
    _enableBottomRefresh = enableBottomRefresh;
    if (enableBottomRefresh) {
        [self setupFooter];
    }else{
        [self setMJF:nil];
//        if (_refreshFooter) {
//            [_refreshFooter removeFromSuperview];
//            _refreshFooter = nil;
//        }
    }
}

- (void)setMJH:(id)mjf{
    id target = self;
    SEL action = NSSelectorFromString(@"setMj_header:");
    IMP imp = [target methodForSelector:action];
    if (imp) {
        void (*func)(id, SEL, id) = (void *)imp;
        func(target, action, mjf);
    }
}

- (void)setupHeader
{
    if (NSClassFromString(@"MJRefreshNormalHeader")) {
        id target = NSClassFromString(@"MJRefreshNormalHeader");
        SEL action = NSSelectorFromString(@"headerWithRefreshingBlock:");
        if (action) {
            IMP imp = [target methodForSelector:action];
            if (imp) {
                id (*func)(id, SEL, id) = (void *)imp;
                __weak typeof(self) weakSelf = self;
                _mjheader = func(target, action, ^{
                    __weak typeof(weakSelf) strongSelf = weakSelf;
                    if (strongSelf.beginHeaderRefreshingOperation) {
                        strongSelf.beginHeaderRefreshingOperation();
                    }
                    
                    id target = strongSelf.mjheader;
                    SEL action = NSSelectorFromString(@"endRefreshing");
                    [target performSelector:action withObject:nil afterDelay:1];
                });
            }
        }
        if (_mjheader) {
            [self setMJH:_mjheader];
        }
    }
//    if (self.refreshHeader) {
//        [self.refreshHeader removeFromSuperview];
//        self.refreshHeader = nil;
//    }
//    if (NSClassFromString(@"SDRefreshHeaderView")) {
//        id refreshHeader = [[NSClassFromString(@"SDRefreshHeaderView") alloc] init];
//
//        [refreshHeader performSelector:@selector(addToScrollView:) withObject:self];
//        BOOL myBoolValue =  NO;
//        NSMethodSignature* signature = [[refreshHeader class] instanceMethodSignatureForSelector: @selector(isEffectedByNavigationController:)];
//        if (signature) {
//            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//            invocation.target = refreshHeader;
//            invocation.selector = @selector(isEffectedByNavigationController:);
//            [invocation setArgument:&myBoolValue atIndex:2];
//            [invocation invoke];
//        }
//        // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
//
//        __weak typeof(self) weakSelf = self;
//        [refreshHeader performSelector:@selector(setBeginRefreshingOperation:) withObject:^{
//            __weak typeof(weakSelf) strongSelf = weakSelf;
//            for (int i = 0 ; i < strongSelf.services.count; i++) {
//                id service = strongSelf.services[i];
//                if ([service isKindOfClass:[PWPagingTableViewService class]]) {
//                    if (strongSelf.topBottomSwich && ((PWPagingTableViewService *)service).canLoadMore) {
//                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageNum + ((PWPagingTableViewService *)service).pageRange;
//                        ((PWPagingTableViewService *)service).pageNum++;
//                    }else{
//                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageStart;
//                    }
//                    if ([service respondsToSelector:@selector(loadData)]) {
//                        [service performSelector:@selector(loadData)];
//                    }
//                }
//            }
//            if (strongSelf.beginHeaderRefreshingOperation) {
//                strongSelf.beginHeaderRefreshingOperation();
//            }
//            [strongSelf.refreshHeader performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
//        }];
//        // 进入页面自动加载一次数据
//        [refreshHeader performSelector:@selector(autoRefreshWhenViewDidAppear)];
//        self.refreshHeader = refreshHeader;
//    }
}

- (void)setMJF:(id)mjf{
    id target = self;
    SEL action = NSSelectorFromString(@"setMj_footer:");
    IMP imp = [target methodForSelector:action];
    if (imp) {
        void (*func)(id, SEL, id) = (void *)imp;
        func(target, action, mjf);
    }
}

- (void)setupFooter
{
    if (NSClassFromString(@"MJRefreshBackNormalFooter")) {
        id target = NSClassFromString(@"MJRefreshBackNormalFooter");
        SEL action = NSSelectorFromString(@"footerWithRefreshingBlock:");
        if (action) {
            IMP imp = [target methodForSelector:action];
            if (imp) {
                id (*func)(id, SEL, id) = (void *)imp;
                __weak typeof(self) weakSelf = self;
                _mjFooter = func(target, action, ^{
                    __weak typeof(weakSelf) strongSelf = weakSelf;
                    if (strongSelf.beginFooterRefreshingOperation) {
                        strongSelf.beginFooterRefreshingOperation();
                    }
                    
                    id target = strongSelf.mjFooter;
                    SEL action = NSSelectorFromString(@"endRefreshing");
                    [target performSelector:action withObject:nil afterDelay:1];
                });
            }
        }
        if (_mjFooter) {
            [self setMJF:_mjFooter];
        }
    }

//    if (self.refreshFooter) {
//        [self.refreshFooter removeFromSuperview];
//        self.refreshFooter = nil;
//    }
//    if (self.contentSize.height < self.frame.size.height) {
//        return;
//    }
//    if (NSClassFromString(@"SDRefreshFooterView")) {
//        id refreshFooter = [[NSClassFromString(@"SDRefreshFooterView") alloc] init];
//
//        BOOL myBoolValue = YES;
//        NSMethodSignature* signature = [[refreshFooter class] instanceMethodSignatureForSelector: @selector(isEffectedByNavigationController:)];
//        if (signature) {
//            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//            invocation.target = refreshFooter;
//            invocation.selector = @selector(isEffectedByNavigationController:);
//            [invocation setArgument:&myBoolValue atIndex:2];
//            [invocation invoke];
//        }
//        // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
//
//        [refreshFooter performSelector:@selector(addToScrollView:) withObject:self];
//        __weak typeof(self) weakSelf = self;
//        [refreshFooter performSelector:@selector(setBeginRefreshingOperation:) withObject:^{
//            __weak typeof(weakSelf) strongSelf = weakSelf;
//            for (int i = 0 ; i < strongSelf.services.count; i++) {
//                id service = strongSelf.services[i];
//                if ([service isKindOfClass:[PWPagingTableViewService class]]) {
//                    if (!strongSelf.topBottomSwich && ((PWPagingTableViewService *)service).canLoadMore) {
//                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageNum + ((PWPagingTableViewService *)service).pageRange;
//                    }else{
//                        ((PWPagingTableViewService *)service).pageNum = ((PWPagingTableViewService *)service).pageStart;
//                    }
//                    if ([service respondsToSelector:@selector(loadData)]) {
//                        [service performSelector:@selector(loadData)];
//                    }
//                }
//            }
//            if (strongSelf.beginFooterRefreshingOperation) {
//                strongSelf.beginFooterRefreshingOperation();
//            }
//            [strongSelf.refreshFooter performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
//        }];
//        self.refreshFooter = refreshFooter;
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_singleService) {
        return [_singleService numberOfSections];
    }
    return _services.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_singleService) {
        if ([_singleService respondsToSelector:@selector(numberOfRows:)]) {
            return [_singleService numberOfRows:section];
//            SEL theSelector = NSSelectorFromString(@"numberOfRows:");
//            NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:
//                                          [PWPagingTableViewSingleService instanceMethodSignatureForSelector:theSelector]];
//            [anInvocation setSelector:theSelector];
//            [anInvocation setTarget:_singleService];
//            [anInvocation setArgument:&section atIndex:2];
//            NSInteger tempResultSet;
//            [anInvocation invoke];
//            [anInvocation getReturnValue:&tempResultSet];
//            NSInteger result = tempResultSet;
//            return result;
        }
    }
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(numberOfRows)]) {
                return [service numberOfRows];
            }
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        if ([_singleService respondsToSelector:@selector(heightAtIndex:section:)]) {
            return [_singleService heightAtIndex:indexPath.row section:indexPath.section];
        }
    }
    if (_services.count > indexPath.section) {
        id service = _services[indexPath.section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(heightAtIndex:)]) {
                return [service heightAtIndex:indexPath.row];
            }
        }
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_singleService) {
//        if ([_singleService respondsToSelector:@selector(estimatedHeightAtIndex:section:)]) {
//            return [_singleService estimatedHeightAtIndex:indexPath.row section:indexPath.section];
//        }
//    }
//    if (_services.count > indexPath.section) {
//        id service = _services[indexPath.section];
//        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
//            if ([service respondsToSelector:@selector(estimatedHeightAtIndex:)]) {
//                return [service estimatedHeightAtIndex:indexPath.row];
//            }
//        }
//    }
//    return 0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell;
    if (_singleService) {
        cell = [_singleService cellAtIndex:indexPath.row section:indexPath.section];
        return cell;
    }
    if (_services.count > indexPath.section) {
        id service = _services[indexPath.section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(cellAtIndex:)]) {
                cell = [service cellAtIndex:indexPath.row];
            }
        }
    }
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        [_singleService didSelectAtIndex:indexPath.row section:indexPath.section];
        return;
    }
    if (_services.count > indexPath.section) {
        id service = _services[indexPath.section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(didSelectAtIndex:)]) {
               return [service didSelectAtIndex:indexPath.row];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_singleService) {
        return [_singleService heightForHeader:section];
    }
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(heightForHeader)]) {
                return [service heightForHeader];
            }
//            NSNumber *height = [(PWPagingTableViewService *)service heightForHeader];
//            if ([height isKindOfClass:[NSNumber class]]) {
//                return [height doubleValue];
//            }
        }
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    if (_singleService) {
//        return [_singleService estimatedHeightForHeader:section];
//    }
//    if (_services.count > section) {
//        id service = _services[section];
//        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
//            if ([service respondsToSelector:@selector(estimatedHeightForHeader)]) {
//                return [service estimatedHeightForHeader];
//            }
//            //            NSNumber *height = [(PWPagingTableViewService *)service heightForHeader];
//            //            if ([height isKindOfClass:[NSNumber class]]) {
//            //                return [height doubleValue];
//            //            }
//        }
//    }
//    return 0;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_singleService) {
        return [_singleService viewForHeader:section];
    }
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
    if (_singleService) {
        return [_singleService heightForFooter:section];
    }
    if (_services.count > section) {
        id service = _services[section];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            if ([service respondsToSelector:@selector(heightForFooter)]) {
                return [service heightForFooter];
            }
//            NSNumber *height = [(PWPagingTableViewService *)service heightForFooter];
//            if ([height isKindOfClass:[NSNumber class]]) {
//                return [height doubleValue];
//            }
        }
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
//    if (_singleService) {
//        return [_singleService estimatedHeightForFooter:section];
//    }
//    if (_services.count > section) {
//        id service = _services[section];
//        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
//            if ([service respondsToSelector:@selector(estimatedHeightForFooter)]) {
//                return [service estimatedHeightForFooter];
//            }
//            //            NSNumber *height = [(PWPagingTableViewService *)service heightForFooter];
//            //            if ([height isKindOfClass:[NSNumber class]]) {
//            //                return [height doubleValue];
//            //            }
//        }
//    }
//    return 0;
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_singleService) {
        return [_singleService viewForFooter:section];
    }
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        [_singleService commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        return;
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            [service commitEditingStyle:editingStyle forRowAtIndex:@([indexPath row])];
            return;
        }
    }
    return;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (_singleService) {
        [_singleService moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        return;
    }
    if (_services.count > [destinationIndexPath section]) {
        id service = _services[[destinationIndexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            [service moveRowAtIndex:@([sourceIndexPath row]) toIndex:@([destinationIndexPath row])];
            return;
        }
    }
    return;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        return [_singleService canEditRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service canEditRowAtIndex:@([indexPath row])];
        }
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        return [_singleService canMoveRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service canMoveRowAtIndex:@([indexPath row])];
        }
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        return [_singleService editingStyleForRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service editingStyleForRowAtIndex:@([indexPath row])];
        }
    }
    return NO;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_singleService) {
        return [_singleService titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service titleForDeleteConfirmationButtonForRowAtIndex:@([indexPath row])];
        }
    }
    return @"";
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        return [_singleService editActionsForRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service editActionsForRowAtIndex:@([indexPath row])];
        }
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_singleService) {
        return [_singleService shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            return [service shouldIndentWhileEditingRowAtIndex:@([indexPath row])];
        }
    }
    return NO;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_singleService) {
        [_singleService willBeginEditingRowAtIndexPath:indexPath];
        return;
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
             [service willBeginEditingRowAtIndex:@([indexPath row])];
            return;
        }
    }
    return;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_singleService) {
        [_singleService didEndEditingRowAtIndexPath:indexPath];
        return;
    }
    if (_services.count > [indexPath section]) {
        id service = _services[[indexPath section]];
        if ([service isKindOfClass:[PWPagingTableViewService class]]) {
            [service didEndEditingRowAtIndex:@([indexPath row])];
            return;
        }
    }
    return;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_singleService) {
        [_singleService willDisplayCell:cell forRowAtIndexPath:indexPath];
        return;
    }
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_enableBottomRefresh && !_mjFooter) {
        [self setupFooter];
    }
}
@end
