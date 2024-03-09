#!/bin/sh
# https://rapidlasso.de/rasterizing-perfect-canopy-height-models-from-lidar/
wine $LASTOOLS/lasground.exe -i ../LazData/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1466n0422.laz -wilderness -o ../LazClassify/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1466n0422.laz