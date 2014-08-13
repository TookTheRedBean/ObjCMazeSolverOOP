ObjCMazeSolverOOP
==============

To use:
Open the project up in XCode and run. By default, the included sample.txt file is run. Feel free to modify the file to try out other mazes! Or add your own files to the project and change the referenced file in the AppDelegate.


MSPosition is a general container for metadata about each position in the maze.

MSMaze is contains a 3D array made up of MSPositions, and some functions for building the maze and querying locations surrounding a location.

MSSolver is a static class with functions that run the BFS over the maze to find the shortest path, and then return that shortest path as a string of directions.
