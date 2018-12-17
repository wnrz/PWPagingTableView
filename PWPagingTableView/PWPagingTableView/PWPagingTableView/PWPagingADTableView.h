//
//  PWPagingTableView.h
//  Widgets
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PWPagingADTableView : UITableView<UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>

@property (nonatomic, copy) void(^beginHeaderRefreshingOperation)(void);
@property (nonatomic, copy) void(^beginFooterRefreshingOperation)(void);
@property (nonatomic, copy) void(^toggleEvent)(id obj);
@property (nonatomic, weak) id refreshHeader;
@property (nonatomic, weak) id refreshFooter;
@property(nonatomic,assign)BOOL enableTopRefresh;
@property(nonatomic,assign)BOOL enableBottomRefresh;
@property(nonatomic,assign)BOOL topBottomSwich;
@property(nonatomic,retain)NSMutableArray *services;

- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;
- (void)setData:(NSDictionary *)dict toClass:(Class)toClass;
- (void)loadData;
@end
