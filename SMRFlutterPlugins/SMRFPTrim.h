//
//  SMRFPTrim.h
//  message_plugin
//
//  Created by Tinswin on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define trimNSNull(obj) ([SMRFPTrim trimNSNull:obj])

@interface SMRFPTrim : NSObject

+ (id)trimNSNull:(id)obj;

@end

NS_ASSUME_NONNULL_END
