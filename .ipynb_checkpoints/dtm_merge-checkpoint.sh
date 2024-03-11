#!/bin/sh
echo "Merge DTM files"
ls -1 ../result/dtm_transform/*.tif > tiff_list.txt
# -ul_lr <ulx> <uly> <lrx> <lry>
#  upper-left
#  lower-right x and y,
gdal_merge.py -o ../result/FL_ENP_DTM_5m.tif --optfile tiff_list.txt -ps 5 5 -ul_lr 1460000 430000 1560000 350000