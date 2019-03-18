//
//  PWPagingTableViewService.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWPagingTableViewService.h"
#import "PWPagingTableView.h"
#import "PWPagingTableViewTools.h"
#import <Masonry/Masonry.h>

@implementation PWPagingTableViewService

- (instancetype)initWithNib:(NSArray *)nib{
    self = [super init];
    if (self) {
        self.pageNum = 1;
        self.pageStart = 1;
        self.pageSize = 10;
        self.pageRange = 1;
        self.canLoadMore = NO;
        self.array = [[NSMutableArray alloc] init];
        self.nib = nib;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.pageNum = 1;
        self.pageStart = 1;
        self.pageSize = 10;
        self.pageRange = 1;
        self.canLoadMore = NO;
        self.array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc{
    [PWPagingTableViewTools clearSubviews:sectionView];
    [sectionView removeFromSuperview];
    sectionView = nil;
    [_array removeAllObjects];
    _array = nil;
    _nib = nil;
    _toggleEvent = nil;
}

- (void)viewWillAppear{
    
}

- (void)viewWillDisappear{
    
}

- (void)viewDidAppear{
    
}

- (void)viewDidDisappear{
    
}

- (void)setData:(NSDictionary *)dict{
    
}

- (NSInteger)numberOfRows{
    return 0;
}

- (CGFloat)heightAtIndex:(NSInteger)index{
    return 0;
}

- (CGFloat)estimatedHeightAtIndex:(NSInteger)index{
    return 0;
}

- (UITableViewCell *)cellAtIndex:(NSInteger)index{
    return nil;
}

- (void)didSelectAtIndex:(NSInteger)index{
    [self.tableview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:self.section] animated:YES];
}

- (CGFloat)heightForHeader{
    return sectionView.frame.size.height;
}

- (CGFloat)estimatedHeightForHeader{
    return 0;
}

- (UIView *)viewForHeader{
    return sectionView;
}

- (CGFloat)heightForFooter{
    return 0;
}

- (CGFloat)estimatedHeightForFooter{
    return 0;
}

- (UIView *)viewForFooter{
    return [[UIView alloc] init];
}

// 当增减按钮按下时，用来处理数据和UI的回调。
// 8.0版本后加入的UITableViewRowAction不在这个回调的控制范围内，UITableViewRowAction有单独的回调Block。
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSNumber *)index{
    
}

// 这个回调实现了以后，就会出现更换位置的按钮，回调本身用来处理更换位置后的数据交换。
- (void)moveRowAtIndex:(NSNumber *)sourceIndex toIndex:(NSNumber *)destinationIndex{
    
}

// 这个回调决定了在当前indexPath的Cell是否可以编辑。
- (BOOL)canEditRowAtIndex:(NSNumber *)index{
    return NO;
}

// 这个回调决定了在当前indexPath的Cell是否可以移动。
- (BOOL)canMoveRowAtIndex:(NSNumber *)index{
    return NO;
}

// 这个回调很关键，返回Cell的编辑样式。
- (UITableViewCellEditingStyle)editingStyleForRowAtIndex:(NSNumber *)index{
    return UITableViewCellEditingStyleNone;
}

// 删除按钮的文字
- (NSString *)titleForDeleteConfirmationButtonForRowAtIndex:(NSNumber *)index{
    return @"删除";
}

// 8.0后侧滑菜单的新接口，支持多个侧滑按钮。
- (NSArray *)editActionsForRowAtIndex:(NSNumber *)index{
    return @[];
}

// 这个接口决定编辑状态下的Cell是否需要缩进。
- (BOOL)shouldIndentWhileEditingRowAtIndex:(NSNumber *)index{
    return NO;
}

// 这是两个状态回调
- (void)willBeginEditingRowAtIndex:(NSNumber *)index{
    
}

- (void)didEndEditingRowAtIndex:(NSNumber *)index{
    
}

- (void)loadData{
    [_tableview reloadData];
}

- (void)reloadTableSection{
    if (_tableview && [_tableview isKindOfClass:[PWPagingTableView class]]) {
        if ([((PWPagingTableView *)_tableview).services containsObject:self]) {
            NSInteger index = [((PWPagingTableView *)_tableview).services indexOfObject:self];
            [_tableview reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    //    {
    //        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    }
    //    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    //    {
    //        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    }
}

- (NSInteger)section{
    if (_tableview && [_tableview isKindOfClass:[PWPagingTableView class]]) {
        if ([((PWPagingTableView *)_tableview).services containsObject:self]) {
            NSInteger index = [((PWPagingTableView *)_tableview).services indexOfObject:self];
            return index;
        }
    }
    return 0;
}

- (void)setSectionViews:(NSArray *)array{
    float kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    if (array.count == 1) {
        sectionView = array[0];
        float height = sectionView.frame.size.height;
        sectionView.frame = CGRectMake(0, 0, kScreenWidth, height);
        return;
    }
    if (array && array.count > 0) {
        sectionView = sectionView ? sectionView : [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [PWPagingTableViewTools clearSubviews:sectionView];
        __block float height = 0;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = obj;
            view.tag = idx;
            view.frame = CGRectMake(0, height, kScreenWidth, view.frame.size.height);
            [self->sectionView addSubview:view];
//            view.sd_layout.leftEqualToView(self->sectionView).topSpaceToView(self->sectionView, height).rightEqualToView(self->sectionView).heightIs(view.frame.size.height);
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self->sectionView);
                make.top.equalTo(self->sectionView).offset(height);
                make.height.mas_equalTo(view.frame.size.height);
            }];
            height = height + view.frame.size.height;
        }];
        sectionView.frame = CGRectMake(0, 0, kScreenWidth, height);
    }else{
        [PWPagingTableViewTools clearSubviews:sectionView];
        [sectionView removeFromSuperview];
        sectionView = nil;
    }
}

- (UIView *)sectionView{
    return sectionView;
}
@end
