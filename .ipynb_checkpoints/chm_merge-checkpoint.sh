#!/bin/sh
echo "Merge CHM files"
ls -1 ../tiles_chms/*.tif > tiff_list.txt
# -ul_lr <ulx> <uly> <lrx> <lry>
#  upper-left
#  lower-right x and y,
gdal_merge.py -o ../result/FL_ENP_CHM_5m.tif --optfile tiff_list.txt -ps 5 5 -ul_lr 1460000 430000 1560000 350000