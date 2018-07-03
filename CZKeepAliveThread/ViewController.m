//
//  ViewController.m
//  CZKeepAliveThread
//
//  Created by zhen7216 on 2018/7/3.
//  Copyright © 2018 ChenZhen. All rights reserved.
//

#import "ViewController.h"
#import "CZKeepAliveThread.h"

@interface ViewController ()
@property (nonatomic, strong) CZKeepAliveThread *thread;
@end

@implementation ViewController

- (IBAction)killThread:(id)sender {
    [_thread kill];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CZKeepAliveThread *thread = [[CZKeepAliveThread alloc] init];
    [thread executeTaskWithBlock:^{
        NSLog(@"\n 👩executing task on %@\n", [NSThread currentThread]);
    }];
    
    self.thread = thread;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_thread executeTaskWithBlock:^{
        NSLog(@"\n 👨executing task on %@\n", [NSThread currentThread]);
    }];
}




@end
