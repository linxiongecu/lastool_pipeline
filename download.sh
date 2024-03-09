#!/bin/sh
echo "List lidar data"
# aws s3 ls s3://mybucket/ --recursive | wc -l
#aws s3 ls --no-sign-request s3://usgs-lidar-public/FL_WestEvergladesNP_topobathymetric_2018/ept-data/ --recursive | wc -l
echo "Download lidar data"
# need an account 
# fatal error: Unable to locate credentials
#aws s3 cp s3://usgs-lidar-public/FL_WestEvergladesNP_topobathymetric_2018/ept-data/ LazData --recursive

# another method 
# skip downloaded folder.
wget --recursive --no-parent  -P LazData  --no-directories --continue https://rockyweb.usgs.gov/vdelivery/Datasets/Staged/Elevation/LPC/Projects/FL_WestEvergladesNP_2018_B18/FL_WestEvergladesNP_topobathymetric_2018/LAZ/
