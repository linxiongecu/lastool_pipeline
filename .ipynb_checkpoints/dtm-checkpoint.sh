#!/bin/bash

rm -rf ../tiles_dtms
mkdir ../tiles_dtms

wine $LASTOOLS/blast2dem.exe -i ../LazData/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1465n0428.laz \
        -keep_class 2 -thin_with_grid 0.5 -step 1.0  \
        -odir ../tiles_dtms -otif