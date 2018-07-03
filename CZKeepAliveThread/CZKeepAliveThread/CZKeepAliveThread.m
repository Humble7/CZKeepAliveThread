//
//  CZKeepAliveThread.m
//  CZKeepAliveThread
//
//  Created by zhen7216 on 2018/7/3.
//  Copyright © 2018 ChenZhen. All rights reserved.
//

#import "CZKeepAliveThread.h"


/**
 Define a subclass of NSThread internally.
 All thread-related operations are performed through CZThread
 */
@interface CZThread : NSThread

@end

@implementation CZThread
- (void)dealloc {
    NSLog(@"CZKeepAliveThread dealloc");
}
@end


@interface CZKeepAliveThread ()
@property (nonatomic, strong) CZThread *thread;
@end

@implementation CZKeepAliveThread

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSLog(@"begin");
        
        _thread = [[CZThread alloc] initWithBlock:^{
            
            // Create context
            CFRunLoopSourceContext context = {0};
            
            // Create source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(
                                                              kCFAllocatorDefault,
                                                              0,
                                                              &context
                                                              );
            
            // Add source to runloop
            CFRunLoopAddSource(
                               CFRunLoopGetCurrent(),
                               source,
                               kCFRunLoopDefaultMode
                               );
            
            // destory source
            CFRelease(source);
            
            // "false" mean that don't return After Source Handled
            CFRunLoopRunInMode(
                               kCFRunLoopDefaultMode,
                               1.0e10,
                               false
                               );
            
            NSLog(@"end");
        }];
        
        [self.thread start];
    }
    
    return self;
}

- (void)executeTaskWithBlock:(CZTaskBlock)task {
    if (!_thread || !task) return;
    
    [self performSelector:@selector(__executeTaskWithBlock:)
                 onThread:_thread
               withObject:task
            waitUntilDone:NO];
}

- (void)kill {
    if (!_thread) return;
    
    [self performSelector:@selector(__stop)
                 onThread:_thread
               withObject:nil
            waitUntilDone:YES];
}

- (void)dealloc {
    [self kill];
}

#pragma mark - private methods

- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeTaskWithBlock:(CZTaskBlock)task {
    task();
}

@end
