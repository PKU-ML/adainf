import os
from argparse import ArgumentDefaultsHelpFormatter, ArgumentParser
import cv2
import numpy as np
parser = ArgumentParser(formatter_class=ArgumentDefaultsHelpFormatter)
parser.add_argument('--imagepath',type=str,help="Folder path of generated imags.")
parser.add_argument('--outpath',type=str,help="Outpath of generated dataset in npz format for data inflation.")
args = parser.parse_args()
IMAGE_EXTENSIONS = ('bmp', 'jpg', 'jpeg', 'pgm', 'png', 'ppm',
                    'tif', 'tiff', 'webp')
images = []
labels = []
for root, _, files in os.walk(args.imagepath):
    for filename in files:
        if filename.lower().endswith(IMAGE_EXTENSIONS):
            image = cv2.imread(os.path.join(root, filename))
            images.append(image)
            
images = np.array(images)
labels = np.ones(len(images),dtype=np.int64)*(-1)
labels = np.array(labels)
np.savez(args.outpath, image=images, label=labels)