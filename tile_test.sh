#!/bin/sh
echo 'retile laz files'

# Remove existing directory recursively
rm -r ../tiles_raw
# Create a new directory
mkdir ../tiles_raw
#wine $LASTOOLS/lasindex.exe -i ../LazData/*.laz -cores 20
# -merged         : merge input files 
# ProjectFlorida/USGS3DEPinFL/test/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1470n0428.laz
#refine_tiling is points number 
#
wine $LASTOOLS/lastile.exe -i ../test/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1470n0428.laz  \
        -tile_size 1000  -refine_tiling 10000000 -buffer 10   \
        -odir ../tiles_raw -olaz
wine $LASTOOLS/lastile.exe -i ../tiles_raw/*_1000.laz \
		  -refine_tiling 10000000 \
		  -odir ../tiles_raw -olaz 
#		  -cores 4 
wine $LASTOOLS/lastile.exe -i ../tiles_raw/*_500.laz \
		  -refine_tiling 10000000 \
		  -odir ../tiles_raw -olaz
#		  -cores 4 

# echo 'split las file'
# wine $LASTOOLS/lassplit.exe -i ../test/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1470n0428.laz  \
#         -odir ../tiles_raw -olaz -digits 3 -split 1000000