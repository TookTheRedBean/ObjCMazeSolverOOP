//
//  MSMaze.h
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPosition.h"

@interface MSMaze : NSObject

@property (nonatomic, strong)MSPosition *start;
@property (nonatomic, strong)MSPosition *end;

- (id)initWithFileContents:(NSString *)contents;

- (NSArray *)getSurroundingPositionsAtPosition:(MSPosition *)position;

@end
