//
//  SMRFlutterPlugin.m
//  Runner
//
//  Created by Tinswin on 2020/11/21.
//

#import "SMRFlutterPlugin.h"

@implementation SMRFPHandler

+ (instancetype)handler {
    SMRFPHandler *instance = [[self alloc] init];
    return instance;
}

+ (BOOL)canResponseTarget:(id)target forSelectorName:(NSString *)selectorName {
    return [target respondsToSelector:NSSelectorFromString(selectorName)];
}

+ (BOOL)performTarget:(id)target forSelectorName:(NSString *)selectorName withObject:(SMRFPHandler *)object {
    SEL selector = NSSelectorFromString(selectorName);
    BOOL response = [self canResponseTarget:target forSelectorName:selectorName];
    if (!response) {
        return NO;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [target performSelector:selector withObject:object];
#pragma clang diagnostic pop
    return YES;
}

@end

@implementation SMRFPMethodHandler

+ (NSString *)p_methodName:(FlutterMethodCall *)call {
    if (![call.method hasSuffix:@":"]) {
        return [call.method stringByAppendingString:@":"];
    }
    return call.method;
}

+ (BOOL)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result target:(id)target {
    SMRFPMethodHandler *methodHandler = [SMRFPMethodHandler handler];
    methodHandler.call = call;
    methodHandler.result = result;
    NSString *selectorName = [self p_methodName:call];
    return [self performTarget:target forSelectorName:selectorName withObject:methodHandler];
}

@end

@implementation SMRFPEventHandler

- (void)dealloc {
    NSLog(@"release event handler");
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    if (self.onListen) {
        return self.onListen(arguments, events);
    }
    return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    if (self.onCancel) {
        self.onCancel(arguments);
    }
    return nil;
}

@end

@implementation SMRFlutterPlugin

+ (void)registerMethodChannelName:(NSString *)name
                        registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                         delegate:(id<FlutterPlugin>)delegate {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:name
                                binaryMessenger:registrar.messenger];
    [self registerMethodChannel:channel registrar:registrar delegate:delegate];
}

+ (void)registerMethodChannel:(FlutterMethodChannel *)channel
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                     delegate:(id<FlutterPlugin>)delegate {
    [registrar addMethodCallDelegate:delegate channel:channel];
}

+ (void)registerEventChannelName:(NSString *)name
                       registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                        settings:(void (^)(SMRFPEventHandler *handler))settings{
    FlutterEventChannel *channel =
    [FlutterEventChannel eventChannelWithName:name
                              binaryMessenger:registrar.messenger];
    [self registerEventChannel:channel registrar:registrar settings:settings];
}
+ (void)registerEventChannel:(FlutterEventChannel *)channel
                   registrar:(NSObject<FlutterPluginRegistrar>*)registrar
                    settings:(void (^)(SMRFPEventHandler *handler))settings {
    if (settings) {
        SMRFPEventHandler *handler = [SMRFPEventHandler handler];
        settings(handler);
        [channel setStreamHandler:handler];
    }
}

+ (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory
                     withId:(NSString*)factoryId
                  registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [registrar registerViewFactory:factory withId:factoryId];
}

+ (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory
                     withId:(NSString*)factoryId
                  registrar:(NSObject<FlutterPluginRegistrar>*)registrar
             blockingPolicy:(FlutterPlatformViewGestureRecognizersBlockingPolicy)blockingPolicy {
    [registrar registerViewFactory:factory withId:factoryId gestureRecognizersBlockingPolicy:blockingPolicy];
}

#pragma mark - FlutterPlugin

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![SMRFPMethodHandler handleMethodCall:call result:result target:self]) {
        result(FlutterMethodNotImplemented);
    }
}

@end
