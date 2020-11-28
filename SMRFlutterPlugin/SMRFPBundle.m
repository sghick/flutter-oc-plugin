//
//  SMRFPBundle.m
//  demo
//
//  Created by Tinswin on 2020/11/28.
//

#import "SMRFPBundle.h"

@interface SMRFPBundle ()

@property (strong, nonatomic) NSString *root;

@end

@implementation SMRFPBundle

+ (void)registBundleWithRoot:(NSString *)root {
    [SMRFPBundle bundle].root = root;
}

+ (SMRFPBundle *)bundle {
    static SMRFPBundle *_bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bundle = [[SMRFPBundle alloc] init];
    });
    return _bundle;
}

+ (UIImage *)imageNamed:(NSString *)imageName {
    SMRFPBundle *bundle = [SMRFPBundle bundle];
    NSString *key = [bundle.root stringByAppendingPathComponent:imageName];
    NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
