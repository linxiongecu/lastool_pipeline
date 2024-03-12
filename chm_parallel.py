# ideas from https://groups.google.com/g/lastools/c/haE2F4NRggU

from dask.distributed import Client, progress
import dask
import sys
import subprocess
import glob
import os
import argparse
@dask.delayed
def norm_las(file):
    # Define the command as a list of arguments
    command = " ".join([
        "wine",
        "$LASTOOLS/lasheight.exe",
        "-i",
        file,
        "-drop_below",
        "-3",
        "-drop_above",
        "120",
        "-replace_z",
        "-odir",
        "../tiles_norm",
        "-olaz"
    ])
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    #print(result)
    bs = os.path.basename(file)
    return "../tiles_norm/" + bs
@dask.delayed
def chm_function(file):
    # Define the command as a list of arguments
    command = " ".join([
        "wine",
        "$LASTOOLS/blast2dem.exe",
        "-i",
        file,
        "-first_only",
        "-step",
        "1.0",
        "-odir",
        "../tiles_chms",
        "-otif"
    ])
    #print(file)
    # Execute the command
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process laz to chm')
    parser.add_argument('--test',  action='store_true', help='test run')
    parser.add_argument('--cores', type=int, default=4, help='Number of cores')
    parser.add_argument('--resume', action='store_true', help='resume from last generation')
    args = parser.parse_args()
    client = Client(n_workers=args.cores, threads_per_worker=1)
    print(f'## -- dask client opened at: {client.dashboard_link}')
    laz_files = glob.glob("../LazData/*.laz")
    if args.test: laz_files=laz_files[:3]
    os.makedirs("../tiles_norm", exist_ok=True)
    os.makedirs("../tiles_chms", exist_ok=True)
    if args.resume:
        print('## -- skip existing files...')
        keep = []
        for f in laz_files:
            bs = os.path.basename(f)
            bs_chm_path = "../tiles_chms/" + bs[:-3] + 'tif'
            if not os.path.exists(bs_chm_path):
                keep.append(f)
        laz_files = keep
        print('## -- number of rest files: ', len(laz_files))
    res =[]
    for f in laz_files:
        result1 = norm_las(f)
        result2 = chm_function(result1)
        res.append(result2)
    progress(dask.persist(*res))
    client.close()
    sys.exit("## -- DONE")
# example use
# python chm_parallel.py --resume --cores 15