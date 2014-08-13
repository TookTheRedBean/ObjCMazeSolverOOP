//
//  MSPosition.h
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MSPositionStateFree,
    MSPositionStateSolid,
    MSPositionStateStart,
    MSPositionStateEnd
} MSPositionState;

@interface MSPosition : NSObject

@property (nonatomic, assign) MSPositionState state;
@property (nonatomic, assign) BOOL visited;
@property (nonatomic, strong) MSPosition *pastPosition;

- (id)initWithX:(NSUInteger)x withY:(NSUInteger)y withZ:(NSUInteger)z withState:(MSPositionState)state;

- (NSNumber *)x;
- (NSNumber *)y;
- (NSNumber *)z;

@end
