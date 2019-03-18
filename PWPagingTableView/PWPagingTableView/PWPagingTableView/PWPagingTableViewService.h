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

typedef void(^PWPagingTableViewServiceBlock)(id obj);
@interface PWPagingTableViewService : PWBaseDataBridge{
    UIView *sectionView;
}

@property(nonatomic , assign)int pageNum;
@property(nonatomic , assign)int pageStart;
@property(nonatomic , assign)int pageSize;
@property(nonatomic , assign)int pageRange;
@property(nonatomic , assign)BOOL canLoadMore;
@property(nonatomic , weak)UITableView *tableview;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSArray *nib;
@property(nonatomic,copy) PWPagingTableViewServiceBlock toggleEvent;

- (instancetype)initWithNib:(NSArray *)nib;
- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;
- (void)setData:(NSDictionary *)dict;
- (NSInteger)numberOfRows;
- (CGFloat)heightAtIndex:(NSInteger)index;
- (CGFloat)estimatedHeightAtIndex:(NSInteger)index;
- (UITableViewCell *)cellAtIndex:(NSInteger)index;
- (void)didSelectAtIndex:(NSInteger)index;
- (CGFloat)heightForHeader;
- (CGFloat)estimatedHeightForHeader;
- (UIView *)viewForHeader;
- (CGFloat)heightForFooter;
- (CGFloat)estimatedHeightForFooter;
- (UIView *)viewForFooter;
- (void)loadData;
- (void)reloadTableSection;
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

// 当增减按钮按下时，用来处理数据和UI的回调。
// 8.0版本后加入的UITableViewRowAction不在这个回调的控制范围内，UITableViewRowAction有单独的回调Block。
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSNumber *)index;
// 这个回调实现了以后，就会出现更换位置的按钮，回调本身用来处理更换位置后的数据交换。
- (void)moveRowAtIndex:(NSNumber *)sourceIndex toIndex:(NSNumber *)destinationIndex;
// 这个回调决定了在当前indexPath的Cell是否可以编辑。
- (BOOL)canEditRowAtIndex:(NSNumber *)index;
// 这个回调决定了在当前indexPath的Cell是否可以移动。
- (BOOL)canMoveRowAtIndex:(NSNumber *)index;
// 这个回调很关键，返回Cell的编辑样式。
- (UITableViewCellEditingStyle)editingStyleForRowAtIndex:(NSNumber *)index;
// 删除按钮的文字
- (NSString *)titleForDeleteConfirmationButtonForRowAtIndex:(NSNumber *)index;
// 8.0后侧滑菜单的新接口，支持多个侧滑按钮。
- (NSArray *)editActionsForRowAtIndex:(NSNumber *)index;
// 这个接口决定编辑状态下的Cell是否需要缩进。
- (BOOL)shouldIndentWhileEditingRowAtIndex:(NSNumber *)index;
// 这是两个状态回调
- (void)willBeginEditingRowAtIndex:(NSNumber *)index;
- (void)didEndEditingRowAtIndex:(NSNumber *)index;

- (NSInteger)section;
- (void)setSectionViews:(NSArray *)array;
- (UIView *)sectionView;
- (UIView *)sectionViewWith:(int)index;
@end
