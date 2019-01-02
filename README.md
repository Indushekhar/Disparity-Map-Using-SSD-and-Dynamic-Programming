# Stereo-Map-Using-SSD-and-Dynamic-Programming

## Overview 

The objective of this project is to compute the stereo map from the stereo pair of two scan-line aligned images (tsukuba_l.png and tsukuba_r.png)
compute the disparity map of the stereo pair.

Two methods to achieve this are :

1. Sum of Squared Differences (SSD) as a patch similarity measure with a fixed window. 

2. Improving the baseline obtained from SSD matching using Dynamic Programming.


## Dependencies 

1. MATLAB R2017b 

MATLAB R2017b can be dowloaded from the [link](https://www.mathworks.com/products/new_products/release2017b.html).


## Input Images 

Below are the two stereo pair images on which the system evaluation has been done.

<p align="center">
  <img src="https://github.com/Indushekhar/Disparity-Map-Using-SSD-and-Dynamic-Programming/blob/master/input/tsukuba_l.png" alt="Left image"/>
</p>

<p align="center">
  <img src="https://github.com/Indushekhar/Disparity-Map-Using-SSD-and-Dynamic-Programming/blob/master/input/tsukuba_r.png" alt="Right image"/>
</p>


## Pipeline and Output

### Sum of Squared Differences (SSD) Approach

The MATLAB code for this part is in file ssd.m. Window should be large enough to have sufficient intensity variation, yet small enough to contain only pixels with about the same
disparity. There is always an trade off between them. Window size was chosen to be 11x11 for simple block matching. Image map was not smooth with 7x7 window.
As obvious the lamp is the front most part in the image,so its disparity is highest, Since disparity is inversely proportional to depth in the image.
The code will give output as below :

<p align="center">
  <img src="https://github.com/Indushekhar/Disparity-Map-Using-SSD-and-Dynamic-Programming/blob/master/output/ssd_output.png" alt="SSD output"/>
</p>


### SSD with Dynamic Programming

This technique improves the accuracy of the disparity map by taking into account the disparities of neighboring pixels Dynamic Programming basically introduces a smoothness constraint.

<p align="center">
  <img src="https://github.com/Indushekhar/Disparity-Map-Using-SSD-and-Dynamic-Programming/blob/master/output/dp_output.png" alt="DP output"/>
</p>


## Note 
Note: The code given here gives the output as greyscale image. To see the color map please reset the All Axes Colormaps from Colormap
editor menu. The menu will be opened along with the output grayscale map after code is executed
