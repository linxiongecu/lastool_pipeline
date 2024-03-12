# lastool_pipeline
use this for las/laz data processing

# download lidar data
bash download.sh

# quality check
## output infomation txt file and boundary kml file for each laz/las data.
bash quality.sh
## check files that have ground classification.
python check_ground.py

# data files are large, retile the las data to small chunks. 
bash tile.sh

# classify lidar data (if needed)
bash ground.sh

# generate DTM
bash dtm.sh
## all laz files
python dtm_parallel.py --cores 30
## assign epsg or tranform epsg 
bash dtm_transform.sh
## merge into one dtm 
bash dtm_merge.sh # much faster.

python dtm_merge.py # slower. 

# generate CHM
bash chm.sh

python chm_parallel.py # all laz files 
# merge CHM

bash chm_merge.sh

# to do
1 retile rest 61 files to smaller size, maybe 500m?

2 generate pit-free chms. 

https://rapidlasso.de/complete-lidar-processing-pipeline-from-raw-flightlines-to-final-products/