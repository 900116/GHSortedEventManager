//
//  GHSortedEventManager.m
//  StudyiOS13
//
//  Created by GuangHui Zhao on 2020/1/6.
//  Copyright © 2020 GuangHui Zhao. All rights reserved.
//

#import "GHSortedEventManager.h"

@implementation GHSortedEvent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeOutSeconds = 3;
    }
    return self;
}

@end

@interface GHSortedEventManager ()

@property (nonatomic,strong) NSConditionLock *lock;

@end

@implementation GHSortedEventManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GHSortedEventManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [NSConditionLock new];
        [self.lock unlockWithCondition:0];
    }
    return self;
}

- (void)showEvent:(GHSortedEvent *)event {
    
    NSTimeInterval timeOutSeconds = event.timeOutSeconds;
    
    if (self.minTimeOutSeconds) {
        timeOutSeconds = [self.minTimeOutSeconds doubleValue] + event.sort + 0.01;
    }
    
    [self.lock lockWhenCondition:event.sort-1 beforeDate:[NSDate dateWithTimeIntervalSinceNow:timeOutSeconds]];
    event.executeBlock();
    [self.lock unlockWithCondition:event.sort];
}

@end
