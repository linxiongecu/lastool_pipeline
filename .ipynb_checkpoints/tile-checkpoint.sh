#!/bin/sh
echo 'retile laz files'
# Use lastile to create a buffered tiling from the original
# flight strips. the flag '-files_are_flightlines' assures
# that points from different flight lines will get a unique
# flight lines ID stored in the 'point source ID' attribute
# that makes it possible to later identify from which points
# belong to the same flight strip. we use '-tile_size 1000'
# to specify the tile size and request a buffer of 50 meters
# around every tile with '-buffer 50'. this buffer helps to
# reduce edge artifacts at tile boundaries in a tile-based
# processing pipeline. we shift the coordinate plane tiling
# by 920 in x and 320 in y so that the flight strips fit in
# exactly 4 tiles (experimentally discovered). the '-olaz'
# flag requests compressed output tiles to overcome the I/O
# bottleneck.

# Remove existing directory recursively
rm -r ../tiles_raw

# Create a new directory
mkdir ../tiles_raw

#wine $LASTOOLS/lasindex.exe -i ../LazData/*.laz -cores 20
# -merged         : merge input files 
# -refine_tiling 1000000 , if datafile is > 1 million points. 
wine $LASTOOLS/lastile.exe -i ../LazData/*.laz -files_are_flightlines \
        -tile_size 500 -buffer 25 -refine_tiling 1000000   \
        -odir ../tiles_raw -olaz -cores 20