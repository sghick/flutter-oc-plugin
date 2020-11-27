//
//  SMRFlutterPlugin.h
//  Runner
//
//  Created by Tinswin on 2020/11/21.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDSFPHandler : NSObject

+ (instancetype)handler;

+ (BOOL)canResponseTarget:(id)target forSelectorName:(NSString *)selectorName;
+ (BOOL)performTarget:(id)target forSelectorName:(NSString *)selectorName withObject:(BDSFPHandler *)object;

@end

@interface BDSFPMethodHandler : BDSFPHandler

@property (strong, nonatomic) FlutterMethodCall *call;
@property (copy  , nonatomic) FlutterResult result;

/** call at `- handleMethodCall:result:` */
+ (BOOL)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result target:(id)target;

@end

typedef FlutterError *_Nullable(^BDSFPListen)(id arguments, FlutterEventSink events);
typedef FlutterError *_Nullable(^BDSFPCancel)(id arguments);

@interface BDSFPEventHandler : BDSFPHandler<FlutterStreamHandler>

@property (copy  , nonatomic) BDSFPListen onListen;
@property (copy  , nonatomic) BDSFPCancel onCancel;

@end

@interface SMRFlutterPlugin : NSObject<FlutterPlugin>

/** MethodChannel */
+ (void)registerMethodChannelName:(NSString *)name
                        registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                         delegate:(id<FlutterPlugin>)delegate;
+ (void)registerMethodChannel:(FlutterMethodChannel *)channel
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                     delegate:(id<FlutterPlugin>)delegate;

/** EventChannel */
+ (void)registerEventChannelName:(NSString *)name
                       registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                        settings:(void (^)(BDSFPEventHandler *handler))settings;
+ (void)registerEventChannel:(FlutterEventChannel *)channel
                   registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                    settings:(void (^)(BDSFPEventHandler *handler))settings;

/** ViewFactory */
+ (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory
                     withId:(NSString*)factoryId
                  registrar:(NSObject<FlutterPluginRegistrar>*)registrar;
+ (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory
                     withId:(NSString*)factoryId
                  registrar:(NSObject<FlutterPluginRegistrar>*)registrar
             blockingPolicy:(FlutterPlatformViewGestureRecognizersBlockingPolicy)blockingPolicy;

@end

NS_ASSUME_NONNULL_END
