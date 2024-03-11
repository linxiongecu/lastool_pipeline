#!/bin/sh
echo 'normalize point cloud'
wine $LASTOOLS/lasheight.exe -i ../test/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1470n0428.laz \
             -drop_above 120    -replace_z           -o ../test/normalized.laz -v

echo 'generate chm tif'
wine $LASTOOLS/lasgrid.exe -i ../test/normalized.laz  -step 1        -highest       \
           -subcircle 0.1  -fill 1 \
           -o ../test/chm_grd.tif -otif -v