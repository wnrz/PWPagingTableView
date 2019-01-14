//
//  PWPagingTableView.h
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PWPagingTableViewSingleService;
@interface PWPagingTableView : UITableView<UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>

@property (nonatomic, copy) void(^beginHeaderRefreshingOperation)(void);
@property (nonatomic, copy) void(^beginFooterRefreshingOperation)(void);
@property (nonatomic, copy) void(^toggleEvent)(id obj);
//@property (nonatomic, weak) id refreshHeader;
//@property (nonatomic, weak) id refreshFooter;
@property (nonatomic, strong) id mjheader;
@property (nonatomic, strong) id mjFooter;
@property(nonatomic,assign)BOOL enableTopRefresh;//允许下拉
@property(nonatomic,assign)BOOL enableBottomRefresh;//允许上拉
@property(nonatomic,assign)BOOL topBottomSwich;//上下拉 pagenum处理交换
@property(nonatomic,retain)NSMutableArray *services;//service集合 可以多个
@property(nonatomic,retain)PWPagingTableViewSingleService *singleService;//
@property (nonatomic, weak, nullable) id <UIScrollViewDelegate> scrollViewDelegate;

- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;
- (void)setData:(NSDictionary *)dict toClass:(Class)toClass;
- (void)loadData;
@end
