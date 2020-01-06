//
//  ViewController.m
//  GHSortedEventManager
//
//  Created by GuangHui Zhao on 2020/1/6.
//  Copyright © 2020 GuangHui Zhao. All rights reserved.
//

#import "ViewController.h"
#import "GHSortedEventManager.h"


@interface GHSortedEvent (GHTest)

+ (instancetype)event1;
+ (instancetype)event2;
+ (instancetype)event3;

@end

@implementation GHSortedEvent (GHTest)

+ (instancetype)event1 {
    GHSortedEvent *event = [GHSortedEvent new];
    event.sort = 1;
    [event setExecuteBlock:^{
        NSLog(@"even1");
    }];
    return event;
}

+ (instancetype)event2 {
    GHSortedEvent *event = [GHSortedEvent new];
    event.sort = 2;
    [event setExecuteBlock:^{
        NSLog(@"even2");
    }];
    return event;
}

+ (instancetype)event3 {
    GHSortedEvent *event = [GHSortedEvent new];
    event.sort = 3;
    [event setExecuteBlock:^{
        NSLog(@"even3");
    }];
    return event;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GHSortedEventManager *manager = [GHSortedEventManager sharedManager];
    //[self situation1:manager];
    [self situation2:manager];
}

- (void)situation1:(GHSortedEventManager *)manager {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [manager showEvent:[GHSortedEvent event3]];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [manager showEvent:[GHSortedEvent event1]];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [manager showEvent:[GHSortedEvent event2]];
    });
}

- (void)situation2:(GHSortedEventManager *)manager {
    manager.minTimeOutSeconds = @3;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [manager showEvent:[GHSortedEvent event3]];
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [manager showEvent:[GHSortedEvent event2]];
    });
}

@end
