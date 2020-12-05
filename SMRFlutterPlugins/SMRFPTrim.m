//
//  SMRFPTrim.m
//  message_plugin
//
//  Created by Tinswin on 2020/12/3.
//

#import "SMRFPTrim.h"

@implementation SMRFPTrim

+ (id)trimNSNull:(id)obj {
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

@end
