//
//  SMRFPBundle.h
//  demo
//
//  Created by Tinswin on 2020/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRFPBundle : NSObject

+ (void)registBundleWithRoot:(NSString *)root;

+ (SMRFPBundle *)bundle;

+ (UIImage *)imageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
