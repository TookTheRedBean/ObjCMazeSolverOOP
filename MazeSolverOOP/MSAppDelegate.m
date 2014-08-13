//
//  MSAppDelegate.m
//  MazeSolverOOP
//
//  Created by Kenner Miner on 8/12/14.
//  Copyright (c) 2014 Kenner Miner. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSSolver.h"

@implementation MSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *shortestPath = [MSSolver solveMazeFromFile:@"1"];

    if (!shortestPath) {
        NSLog(@"Unescapeable!");
    } else {
        NSLog(@"Escapeable: %@", shortestPath);
    }
}

@end
