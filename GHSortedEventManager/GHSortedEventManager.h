//
//  GHSortedEventManager.h
//  StudyiOS13
//
//  Created by GuangHui Zhao on 2020/1/6.
//  Copyright © 2020 GuangHui Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//保持顺序任务
@interface GHSortedEvent : NSObject

@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,assign) NSTimeInterval timeOutSeconds;
@property (nonatomic,copy) void (^executeBlock)(void);

@end

@interface GHSortedEventManager : NSObject

//保持超时顺序，超时时间以此变为 min,min+0.01,min+0.02,...保证超时后依旧有序，否则超时后的顺序由event的timeOutSeconds保证
@property (nonatomic,strong) NSNumber *minTimeOutSeconds;

+ (instancetype)sharedManager;
- (instancetype)init NS_UNAVAILABLE;

- (void)showEvent: (GHSortedEvent *)event;

@end



NS_ASSUME_NONNULL_END
