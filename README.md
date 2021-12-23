# Image-Segmentation
I have applied EM(Expectation-Maximization) Algorithm to attain Image Segmentation assuming the original Image was from a GMM(Gaussian Mixture Model), assuming Univariate Gaussians.\
It is specially useful to segment image in cases like brainMRI scan as shown in one of the test image and output segmented images as it helps us label different parts of the brain based on Intensity Based MRI Images, automatically without Manual Intervention.

One Major Drawbacks of simply Using EM-Algorithm without modification are:
- It does not takes into account the correlation of neighbouring pixels and assumes each pixel density to be independent of all the other pixels.
- It commits many misclassification of pixels due to above reason

Usage:
- Run the lines of commands in `function-image-segment.R` Rscript.
- Before running it on example images keep the PNG(grayscale - Color PNG not supported yet) images in the same folder where the RScript is running.

Tip:
- Use RStudio for smoother experience.
