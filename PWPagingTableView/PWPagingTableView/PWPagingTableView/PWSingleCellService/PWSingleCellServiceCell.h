//
//  BaseQuoCell.h
//  AFNetworking
//
//  Created by 王宁 on 2018/7/14.
//

#import <UIKit/UIKit.h>
#import "PWSingleCellServiceCell.h"

@protocol PWSingleCellServiceCellProtocol <NSObject>
+ (NSString *)identifier;
+ (CGFloat)heightWithDict:(NSDictionary *)dict;
@end

@interface PWSingleCellServiceCell : UITableViewCell

+ (NSString *)identifier;

+ (CGFloat)height;
- (void)setDict:(NSDictionary *)dict;
@end
