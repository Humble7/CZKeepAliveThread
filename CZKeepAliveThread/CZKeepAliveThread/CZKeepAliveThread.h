//
//  CZKeepAliveThread.h
//  CZKeepAliveThread
//
//  Created by zhen7216 on 2018/7/3.
//  Copyright © 2018 ChenZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CZTaskBlock)(void);

@interface CZKeepAliveThread : NSObject


/**
 Execute the task in the current thread.

 @param task The task that you want to be executed
 */
- (void)executeTaskWithBlock:(CZTaskBlock)task;

- (void)kill;

@end
