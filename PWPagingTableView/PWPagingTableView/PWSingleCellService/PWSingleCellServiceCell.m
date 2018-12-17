//
//  BaseQuoCell.m
//  AFNetworking
//
//  Created by 王宁 on 2018/7/14.
//

#import "PWSingleCellServiceCell.h"

@implementation PWSingleCellServiceCell

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


+ (NSString *)identifier{
    return NSStringFromClass([PWSingleCellServiceCell class]);
}

//+ (CGFloat)heightWithDict:(NSDictionary *)dict{
//    return 50;
//}

- (void)setDict:(NSDictionary *)dict{
    
}
@end
