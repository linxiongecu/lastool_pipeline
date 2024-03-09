#!/usr/bin/env python
# coding: utf-8

import glob
txts = glob.glob('../quality/USGS*.txt')
def check_ground_string(file_path):
    try:
        with open(file_path, 'r') as file:
            for line in file:
                if 'ground' in line:
                    return True
        return False
    except FileNotFoundError:
        print("File not found.")
        return False
n=0
for f in txts:
    if check_ground_string(f):
        pass
        #print("The file contains the string 'ground'.")
    else:
        n+=1
        print("file has no ground: ", f)
print(f'total number of files is {len(txts)}, but {n} files has no ground classification!')




