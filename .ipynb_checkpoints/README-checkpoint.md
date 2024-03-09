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

# generate CHM
bash chm.sh