//
//  MSSolver.m
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import "MSMaze.h"
#import "MSSolver.h"

@implementation MSSolver

+ (NSString *)solveMazeFromFile:(NSString *)fileName {
    NSString *fileRoot = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
    
    MSMaze *maze = [[MSMaze alloc] initWithFileContents:contents];
    NSMutableArray *BFSQueue = [NSMutableArray arrayWithArray:@[maze.start]];
    MSPosition *finalPosition;
    
    while (BFSQueue.count > 0) {
        MSPosition *testPos = [BFSQueue objectAtIndex:0];
        NSArray *surroundingPositions = [maze getSurroundingPositionsAtPosition:testPos];
        
        [BFSQueue removeObjectAtIndex:0];
        
        // Check the surrounding positions for the exit and potential next moves
        for (MSPosition *position in surroundingPositions) {
            if (position.state == MSPositionStateEnd) {
                finalPosition = position;
                position.pastPosition = testPos;
                
                return [MSSolver convertPositionToDirections:finalPosition];
            } else if (position.state != MSPositionStateSolid && !position.visited) {
                [BFSQueue addObject:position];
                position.visited = YES;
                position.pastPosition = testPos;
            }
        }
    }
    
    return nil;
}

+ (NSString *)convertPositionToDirections:(MSPosition *)endPosition{
    MSPosition *nextPosition;
    NSMutableString *directionString = [NSMutableString new];
    NSMutableArray *path = [NSMutableArray new];
    
    while (endPosition.pastPosition) {
        [path addObject:endPosition];
        nextPosition = endPosition.pastPosition;
        endPosition = nextPosition;
    }
    
    [path addObject:endPosition];
    
    for (NSInteger i = path.count - 1; i > 0; i--) {
        MSPosition *currentPosition = path[i];
        MSPosition *nextPosition = path[i - 1];
        
        if (currentPosition.x < nextPosition.x) {
            [directionString appendString:@"E"];
        } else if (currentPosition.x > nextPosition.x) {
            [directionString appendString:@"W"];
        } else if (currentPosition.y > nextPosition.y) {
            [directionString appendString:@"N"];
        } else if (currentPosition.y < nextPosition.y) {
            [directionString appendString:@"S"];
        } else if (currentPosition.z > nextPosition.z) {
            [directionString appendString:@"D"];
        } else if (currentPosition.z < nextPosition.z) {
            [directionString appendString:@"U"];
        }
    }
    
    return directionString;
}

@end
