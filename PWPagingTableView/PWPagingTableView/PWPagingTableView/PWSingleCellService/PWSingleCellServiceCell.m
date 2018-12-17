//
//  BaseQuoCell.m
//  AFNetworking
//
//  Created by 王宁 on 2018/7/14.
//

#import "PWSingleCellServiceCell.h"
#import "PWPagingTableViewTools.h"

@implementation PWSingleCellServiceCell

+ (NSString *)identifier{
    return [NSString stringWithFormat:@"PWSingleCellServiceCell_%@" , NSStringFromClass(self.class)];
}

+ (CGFloat)height{
    return 44;
}

- (instancetype)init{
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"."]) {
        NSArray *array = [className componentsSeparatedByString:@"."];
        if (array.count > 1) {
            className = [className componentsSeparatedByString:@"."][1];
        }
    }
    NSBundle *bundle = [PWPagingTableViewTools bundleWith:self.class fileName:className fileType:@"nib"];
    if (bundle) {
        NSArray *array = [bundle loadNibNamed:className owner:self options:nil];
        self = array[0];
    }else{
        self = [super init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDict:(NSDictionary *)dict{
    
}
@end
