import rasterio
from rasterio.merge import merge
import glob
# https://gis.stackexchange.com/questions/361213/merging-rasters-with-gdal-merge-py

# Directory containing the GeoTIFF files
input_dir = '../result/dtm_transform'

# Output file path for the merged GeoTIFF
output_file = '../result/merged_fl_v2.tif'  # Replace with your desired output file path

# List all GeoTIFF files in the input directory
input_files = glob.glob(input_dir + '/*.tif')

from osgeo import gdal
minX=1460000
minY=350000
maxX=1560000
maxY=430000
res=10
g = gdal.Warp(output_file, input_files, format="GTiff", xRes=res, yRes=res,
             outputBounds = (minX, minY, maxX, maxY))
g = None # Close file and flush to disk
print("Merged GeoTIFF files saved to:", output_file)