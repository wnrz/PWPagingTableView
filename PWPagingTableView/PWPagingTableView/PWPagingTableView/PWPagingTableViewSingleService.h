//
//  PWPagingTableViewSingleService.h
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^PWPagingTableViewSingleServiceBlock)(id obj);
@interface PWPagingTableViewSingleService : NSObject

@property(nonatomic , assign)int pageNum;
@property(nonatomic , assign)int pageStart;
@property(nonatomic , assign)int pageSize;
@property(nonatomic , assign)int pageRange;
@property(nonatomic , assign)BOOL canLoadMore;
@property(nonatomic , weak)UITableView *tableview;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSArray *nib;
@property(nonatomic,copy) PWPagingTableViewSingleServiceBlock toggleEvent;

- (instancetype)initWithNib:(NSArray *)nib;
- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;
- (void)setData:(NSDictionary *)dict;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRows:(NSInteger)section;
- (CGFloat)heightAtIndex:(NSInteger)index section:(NSInteger)section;
- (CGFloat)estimatedHeightAtIndex:(NSInteger)index section:(NSInteger)section;
- (UITableViewCell *)cellAtIndex:(NSInteger)index section:(NSInteger)section;
- (void)didSelectAtIndex:(NSInteger)index section:(NSInteger)section;
- (CGFloat)heightForHeader:(NSInteger)section;
- (CGFloat)estimatedHeightForHeader:(NSInteger)section;
- (UIView *)viewForHeader:(NSInteger)section;
- (CGFloat)heightForFooter:(NSInteger)section;
- (CGFloat)estimatedHeightForFooter:(NSInteger)section;
- (UIView *)viewForFooter:(NSInteger)section;
- (void)loadData;
- (void)reloadTableSection:(NSInteger)section;

// 当增减按钮按下时，用来处理数据和UI的回调。
// 8.0版本后加入的UITableViewRowAction不在这个回调的控制范围内，UITableViewRowAction有单独的回调Block。
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
// 这个回调实现了以后，就会出现更换位置的按钮，回调本身用来处理更换位置后的数据交换。
- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
// 这个回调决定了在当前indexPath的Cell是否可以编辑。
- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
// 这个回调决定了在当前indexPath的Cell是否可以移动。
- (BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
// 这个回调很关键，返回Cell的编辑样式。
- (UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
// 删除按钮的文字
- (NSString *)titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
// 8.0后侧滑菜单的新接口，支持多个侧滑按钮。
- (NSArray *)editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
// 这个接口决定编辑状态下的Cell是否需要缩进。
- (BOOL)shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
// 这是两个状态回调
- (void)willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
