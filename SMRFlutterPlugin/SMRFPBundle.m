//
//  SMRFPBundle.m
//  demo
//
//  Created by Tinswin on 2020/11/28.
//

#import "SMRFPBundle.h"

@interface SMRFPBundle ()

@end

@implementation SMRFPBundle

- (void)setRoot:(NSString * _Nonnull)root {
    _root = root;
}

- (void)setExtension:(NSString * _Nonnull)extension {
    _extension = extension;
}

+ (void)registBundleWithRoot:(NSString *)root {
    [self registBundleWithRoot:root extension:@"png"];
}

+ (void)registBundleWithRoot:(NSString *)root extension:(NSString *)extension {
    [SMRFPBundle bundle].root = root;
    [SMRFPBundle bundle].extension = extension;
}

+ (SMRFPBundle *)bundle {
    static SMRFPBundle *_bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bundle = [[SMRFPBundle alloc] init];
    });
    return _bundle;
}

+ (UIImage *)imageNamed:(NSString *)name {
    UIImage *image = [self p_imageScaleNamed:name];
    if (!image) {
        image = [self p_imageNamed:name];
    }
    return image;
}


+ (UIImage *)p_imageScaleNamed:(NSString *)name {
    NSString *imageName = name;
    if (![name hasSuffix:@"@2x"] && ![name hasSuffix:@"@3x"]) {
        imageName = [imageName stringByAppendingFormat:@"@%@x", @(UIScreen.mainScreen.scale)];
    }
    return [self imageNamed:imageName];
}

+ (UIImage *)p_imageNamed:(NSString *)name {
    SMRFPBundle *bundle = [SMRFPBundle bundle];
    NSString *key = [bundle.root stringByAppendingPathComponent:name];
    if (bundle.extension && ![key.pathExtension isEqualToString:bundle.extension]) {
        key = [key stringByAppendingPathExtension:bundle.extension];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
