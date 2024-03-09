#!/bin/bash

rm -rf ../tiles_dtms
mkdir ../tiles_dtms

wine $LASTOOLS/blast2dem.exe -i ../LazData/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1465n0428.laz \
        -keep_class 2 -thin_with_grid 0.5 -step 1.0  \
        -odir ../tiles_dtms -otif
rm -rf ../tiles_hillshaded_dtms
# mkdir ../tiles_hillshaded_dtms
# wine $LASTOOLS/blast2dem.exe -i ../LazData/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1465n0428.laz \
#         -keep_class 2 -thin_with_grid 0.5 -step 1.0  -hillshade \
#         -odir ../tiles_hillshaded_dtms -opng 

# # run las2dem on the ground-classified tiles to create raster DTMs
# # in ESRI ASCII format (*.asc) for each individual tile.
# # Explanation: las2dem parameters are similar to the batch script.
# # *.laz
# # *.laz
# wine $LASTOOLS/blast2dem.exe -i ../tiles_raw/*.laz \
#         -keep_class 2 -thin_with_grid 0.5 -step 1.0 -use_tile_bb \
#         -odir tiles_dtms -oasc 


# # create clean folder for the hillshaded DTM rasters


# # use las2dem to create individual hillshaded DTM rasters
# # from the LiDAR points that were classified as ground in each tile.
# wine $LASTOOLS/blast2dem.exe -i ../tiles_raw/*.laz \
#         -keep_class 2 -thin_with_grid 0.5 -step 1.0 -use_tile_bb -hillshade \
#         -odir tiles_hillshaded_dtms -opng 


# # create clean folder for the false-colored slope DTM rasters
# rm -rf ./tiles_slope_dtms
# mkdir ./tiles_slope_dtms

# # use las2dem to create individual false-colored slope DTM rasters
# # from the LiDAR points of each ground-classified tile.
# wine $LASTOOLS/blast2dem.exe -i ../tiles_raw/*.laz \
#         -keep_class 2 -thin_with_grid 0.5 -step 1.0 -use_tile_bb -slope -false \
#         -odir tiles_slope_dtms -opng 


# # use las2dem to create a hillshaded DSM raster from the LiDAR points
# # of the '-merged' final tiles.
# wine $LASTOOLS/blast2dem.exe -i ../tiles_raw/*.laz -merged \
#         -first_only -thin_with_grid 0.5 
#         -step 1.0 -hillshade \
#         -o hillshaded_dsm.png
