#!/bin/bash

# Destination directory for the transformed files
destination="../result/dtm_transform/"

# Ensure the destination directory exists
mkdir -p "$destination"

# Loop through all GeoTIFF files in the current directory
for file in ../tiles_dtms/*.tif; do
    # Check if file exists
    if [ -f "$file" ]; then
        # Extract the filename without the directory path
        filename=$(basename "$file")
        
        # Assign EPSG code 6350 to the GeoTIFF file
        gdalwarp -t_srs EPSG:6350 "$file" "${destination}${filename}"
        echo "Assigned EPSG 6350 to $file"
    fi
done
