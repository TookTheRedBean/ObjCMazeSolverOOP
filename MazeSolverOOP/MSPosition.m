//
//  MSPosition.m
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import "MSPosition.h"

@interface MSPosition()

@property (nonatomic, strong) NSDictionary *coordinates;

@end

@implementation MSPosition

- (id)init {
    return [self initWithX:0 withY:0 withZ:0 withState:MSPositionStateFree];
}

// Designiated init
- (id)initWithX:(NSUInteger)x withY:(NSUInteger)y withZ:(NSUInteger)z withState:(MSPositionState)state {
    self = [super init];
    
    if (self) {
        self.coordinates = @{
                            @"x": [NSNumber numberWithInteger:x],
                            @"y": [NSNumber numberWithInteger:y],
                            @"z": [NSNumber numberWithInteger:z]
                            };
        
        self.state = state;
        
        if (state == MSPositionStateStart) {
            self.visited = YES;
        }
    }
    
    return self;
}

- (NSNumber *)x {
    return self.coordinates[@"x"];
}

- (NSNumber *)y {
    return self.coordinates[@"y"];
}

- (NSNumber *)z {
    return self.coordinates[@"z"];
}


@end
