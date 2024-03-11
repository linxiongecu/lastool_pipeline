from dask.distributed import Client, progress
import dask
import sys
import subprocess
import glob
import os
import argparse
@dask.delayed
def dtm_function(file):
    # Define the command as a list of arguments
    command = " ".join([
        "wine",
        "$LASTOOLS/blast2dem.exe",
        "-i",
        file,
        "-keep_class",
        "2",
        "-thin_with_grid",
        "0.5",
        "-step",
        "1.0",
        "-odir",
        "../tiles_dtms",
        "-otif"
    ])
    #print(file)
    # Execute the command
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process laz to dtm')
    parser.add_argument('--test',  action='store_true', help='test run')
    parser.add_argument('--cores', type=int, default=4, help='Number of cores')
    args = parser.parse_args()
    client = Client(n_workers=args.cores, threads_per_worker=1)
    print(f'## -- dask client opened at: {client.dashboard_link}')
    laz_files = glob.glob("../LazData/*.laz")
    if args.test: laz_files=laz_files[:3]
    os.makedirs("../tiles_dtms", exist_ok=True)
    cmds = [dtm_function(arg1) for arg1 in laz_files]  
    progress(dask.persist(*cmds))
    client.close()
    sys.exit("## -- DONE")
# example use
# python dtm_parallel.py --test