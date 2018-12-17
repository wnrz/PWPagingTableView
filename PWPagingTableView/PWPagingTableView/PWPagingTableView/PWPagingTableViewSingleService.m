//
//  PWPagingTableViewSingleService.m
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PWPagingTableViewSingleService.h"
#import "PWPagingTableView.h"

@implementation PWPagingTableViewSingleService

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

- (NSInteger)numberOfSections{
    return 0;
}

- (NSInteger)numberOfRows:(NSInteger)section{
    return 0;
}

- (CGFloat)heightAtIndex:(NSInteger)index section:(NSInteger)section{
    return 0;
}

- (CGFloat)estimatedHeightAtIndex:(NSInteger)index section:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)cellAtIndex:(NSInteger)index section:(NSInteger)section{
    return nil;
}

- (void)didSelectAtIndex:(NSInteger)index section:(NSInteger)section{
    [self.tableview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section] animated:YES];
}

- (CGFloat)heightForHeader:(NSInteger)section{
    return 0;
}

- (CGFloat)estimatedHeightForHeader:(NSInteger)section{
    return 0;
}

- (UIView *)viewForHeader:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)heightForFooter:(NSInteger)section{
    return 0;
}

- (CGFloat)estimatedHeightForFooter:(NSInteger)section{
    return 0;
}

- (UIView *)viewForFooter:(NSInteger)section{
    return [[UIView alloc] init];
}

// 当增减按钮按下时，用来处理数据和UI的回调。
// 8.0版本后加入的UITableViewRowAction不在这个回调的控制范围内，UITableViewRowAction有单独的回调Block。
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

// 这个回调实现了以后，就会出现更换位置的按钮，回调本身用来处理更换位置后的数据交换。
- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

// 这个回调决定了在当前indexPath的Cell是否可以编辑。
- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

// 这个回调决定了在当前indexPath的Cell是否可以移动。
- (BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

// 这个回调很关键，返回Cell的编辑样式。
- (UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

// 删除按钮的文字
- (NSString *)titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

// 8.0后侧滑菜单的新接口，支持多个侧滑按钮。
- (NSArray *)editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @[];
}

// 这个接口决定编辑状态下的Cell是否需要缩进。
- (BOOL)shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

// 这是两个状态回调
- (void)willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

- (void)loadData{
    [_tableview reloadData];
}

- (void)reloadTableSection:(NSInteger)section{
    [_tableview reloadData];
    return;
//    if (_tableview && [_tableview isKindOfClass:[PWPagingTableView class]]) {
//        if ([((PWPagingTableView *)_tableview).services containsObject:self]) {
//            NSInteger index = [((PWPagingTableView *)_tableview).services indexOfObject:self];
//            [_tableview reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    }
}
@end
