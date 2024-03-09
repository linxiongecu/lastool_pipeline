#!/bin/bash



# Create clean folder for the output files of quality checking
rm -rf ../quality
mkdir ../quality

# Run lasinfo on the raw flight lines on 4 cores
# The parameter '-compute_density' instructs lasinfo to compute an estimate for
# the density of the points. The parameters '-odir quality' and '-otxt' tell lasinfo
# to output the result as simple ASCII files with the same file name but an '*.txt' 
# ending into the 'quality' subfolder
# too slow....
wine $LASTOOLS/lasinfo.exe -i ../LazData/*.laz \
        -compute_density \
        -odir ../quality -otxt \
        -cores 4

grep -n "ground" ../quality/*.txt


# Compute boundary around merged flight lines (and look for holes)
# Creates a polygonal outline of the spatial extend of the points in each flight line.
# The '-last_only' flag means we only use last returns to compute this outline and the
# '-thin_with_grid 2' flag eases the computational burden by keeping only one point for
# each 2 by 2 cell. The '-concavity 10' flag instructs lasboundary to report details
# of up to 10 meters along the outline and in the presence of '-holes'. The '-disjoint'
# flag allows lasboundary to report multiple polygonal outlines in case there are islands
# of LiDAR points. Finally, the '-odix _boundary' and '-okml' parameter tell LAStools to
# output each file to the KML format while adding the appendix '_boundary' to the file name
# Run on '-cores 4'
# too slow.....
wine $LASTOOLS/lasboundary.exe -i ../LazData/*.laz \
            -last_only -thin_with_grid 2 \
            -concavity 10 -disjoint -holes \
            -odir ../quality -odix _boundary -okml \
            -cores 4
# two slow
# Same as above after merging all LAZ files into one
# wine $LASTOOLS/lasboundary.exe -i ../LazData/*.laz -merged \
#             -last_only -thin_with_grid 2 \
#             -concavity 10 -disjoint -holes \
#             -o ../quality/boundary.kml
