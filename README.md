# Image-Segmentation
I have applied EM(Expectation-Maximization) Algorithm to attain Image Segmentation assuming the original Image was from a GMM(Gaussian Mixture Model), assuming Univariate Gaussians.\
It is specially useful to segment image in cases like brainMRI scan as shown in one of the test image and output segmented images as it helps us label different parts of the brain based on Intensity Based MRI Images, automatically without Manual Intervention.

One Major Drawbacks of simply Using EM-Algorithm without modification are:
- It does not takes into account the correlation of neighbouring pixels and assumes each pixel density to be independent of all the other pixels.
- It commits many misclassification of pixels due to above reason

Functions used in the `function-image-segment.R`:
- `Segment.Image.EM`: It takes the PNG image name, number of gaussians or clusters to use, number of iterations of EM Algorithm to run, Tolerance Value. It outputs a list which contains matrices corresponding to the segmented image use `grid::grid.raster(<one of the matrices from the list>)` or similar function to display the matrix as image.

Usage:
- Run the lines of commands in `function-image-segment.R` Rscript.
- Before running it on example images keep the PNG(grayscale - Color PNG not supported yet) images in the same folder where the RScript is running.

Tip:
- Use RStudio for smoother experience.
