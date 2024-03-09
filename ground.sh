#!/bin/bash
#!/bin/bash

# Add LAStools to PATH
export PATH=$PATH:..

# Specify the number of cores to use
NUM_CORES=4

# Create clean folder for the ground-classified tiles
rm -rf ../tiles_ground
mkdir ../tiles_ground

# Use lasground to find bare-earth points in all tiles
lasground -i ../tiles_raw/*.laz \
          -metro -extra_fine \
          -odir ../tiles_ground -olaz \
          -cores $NUM_CORES

# Create clean folder for the denoised tiles
rm -rf ../tiles_denoised
mkdir ../tiles_denoised

# Use lasheight to remove low and high outliers
lasheight -i ../tiles_ground/*.laz \
          -drop_above 120 -drop_below -3 \
          -odir ../tiles_denoised -olaz \
          -cores $NUM_CORES

# Create clean folder for the classified tiles
rm -rf ../tiles_classified
mkdir ../tiles_classified

# Use lasclassify to identify buildings and trees
lasclassify -i ../tiles_denoised/*.laz \
            -odir ../tiles_classified -olaz \
            -cores $NUM_CORES

# Create clean folder for the final tiles (stripped of the buffer)
rm -rf ../tiles_final
mkdir ../tiles_final

# Use lastile to remove the buffer from the classified tiles
lastile -i ../tiles_classified/*.laz \
        -remove_buffer \
        -odir ../tiles_final -olaz
