//
//  SMRFPBundle.h
//  demo
//
//  Created by Tinswin on 2020/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRFPBundle : NSObject

@property (strong, nonatomic, readonly) NSString *root;
@property (strong, nonatomic, readonly) NSString *extension;

+ (void)registBundleWithRoot:(NSString *)root;
+ (void)registBundleWithRoot:(NSString *)root extension:(nullable NSString *)extension;

+ (SMRFPBundle *)bundle;

+ (UIImage *)imageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
