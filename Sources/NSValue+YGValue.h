//  Created by Songwen Ding on 2019/5/30.
//  Copyright © 2019 Songwen Ding. All rights reserved.

#import <UIKit/UIKit.h>
#import "YGValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSValue (YGValue)

+ (instancetype)valuewithYGValue:(YGValue)value;

@property (readonly) YGValue ygValue;

@end

NS_ASSUME_NONNULL_END
