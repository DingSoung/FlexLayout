//  Created by Songwen Ding on 2019/5/30.
//  Copyright © 2019 Songwen Ding. All rights reserved.

#import "NSValue+YGValue.h"

@implementation NSValue (YGValue)

+ (instancetype)valuewithYGValue:(YGValue)value {
    return [self valueWithBytes:&value objCType:@encode(YGValue)];
}

- (YGValue)ygValue {
    YGValue value;
    [self getValue:&value];
    return value;
}

@end

