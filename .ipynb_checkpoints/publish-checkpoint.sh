#!/bin/sh
echo 'view las points in browser'

# Create a new directory
mkdir ../portal_dir
# not supported on this installation (x86_64 binary)
wine $LASTOOLS/laspublish.exe -i ../test/USGS_LPC_FL_WestEvergladesNP_2018_B18_e1470n0428.laz -odir ../portal_dir -o portal.html -olaz