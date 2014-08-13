//
//  MSMaze.m
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import "MSMaze.h"

@interface MSMaze ()

@property (nonatomic, strong)NSMutableArray *layers;

@property (nonatomic, assign)NSUInteger depth;
@property (nonatomic, assign)NSUInteger width;
@property (nonatomic, assign)NSUInteger height;

@end

@implementation MSMaze

- (id)initWithFileContents:(NSString *)contents {
    self = [super init];
    
    if (self) {
        NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSMutableArray *currentLayer = [NSMutableArray new];
        
        NSUInteger currentLine = 0;
        NSUInteger currentDepth = 0;
        
        self.layers = [NSMutableArray new];
        
        // First line of the file is number of layers
        self.depth = [lines[0] intValue];
        
        for (NSInteger i = 1; i < lines.count && self.layers.count < self.depth; i++ && currentLine++) {
            NSString *line = lines[i];
            
            if ([line isEqualToString:@""]) {
                // Empty line or end of file means we are moving on
                [self.layers addObject:currentLayer];
                currentLayer = [NSMutableArray new];
                currentDepth++;
                self.height = currentLine;
                currentLine = -1;
            } else {
                self.width = line.length;
                
                [currentLayer addObject:[NSMutableArray arrayWithCapacity:self.width]];
                
                for (NSInteger j = 0; j < line.length; j++) {
                    MSPositionState newPositionState = MSPositionStateFree;
                    unichar currentChar = [line characterAtIndex:j];
                    
                    switch (currentChar) {
                            // Starting point
                        case '#':
                            newPositionState = MSPositionStateSolid;
                            break;
                        case 'B':
                            newPositionState = MSPositionStateStart;
                            break;
                        case 'E':
                            newPositionState = MSPositionStateEnd;
                            break;
                        default:
                            break;
                    }
                    
                    MSPosition *newPosition = [[MSPosition alloc] initWithX:j withY:currentLine withZ:currentDepth withState:newPositionState];
                    
                    if (newPositionState == MSPositionStateStart) {
                        self.start = newPosition;
                    } else if (newPositionState == MSPositionStateEnd) {
                        self.end = newPosition;
                    }
                    
                    [currentLayer[currentLine] addObject:newPosition];
                }
            }
        }
        
        [self.layers addObject:currentLayer];
        self.height = currentLine;
    }
    
    return self;
}

- (NSArray *)getSurroundingPositionsAtPosition:(MSPosition *)position {
    NSMutableArray *surroundingPositions = [NSMutableArray new];
    
    int currentX = [position.x intValue];
    int currentY = [position.y intValue];
    int currentZ = [position.z intValue];
    
    // Grab all the surrounding positions
    if (currentZ > 0) {
        [surroundingPositions addObject:self.layers[currentZ - 1][currentY][currentX]];
    }
    
    if (currentZ < self.depth - 1) {
        [surroundingPositions addObject:self.layers[currentZ + 1][currentY][currentX]];
    }
    
    if (currentY > 0) {
        [surroundingPositions addObject:self.layers[currentZ][currentY - 1][currentX]];
    }
    
    if (currentY < self.height - 1) {
        [surroundingPositions addObject:self.layers[currentZ][currentY + 1][currentX]];
    }
    
    if (currentX > 0) {
        [surroundingPositions addObject:self.layers[currentZ][currentY][currentX - 1]];
    }
    
    if (currentX < self.width - 1) {
        [surroundingPositions addObject:self.layers[currentZ][currentY][currentX + 1]];
    }
    
    return surroundingPositions;
}

@end
