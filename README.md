# Image-Segmentation
I have applied EM(Expectation-Maximization) Algorithm to attain Image Segmentation assuming the original Image was from a GMM(Gaussian Mixture Model), assuming Univariate Gaussians.\
It is specially useful to segment image in cases like brainMRI scan as shown in one of the test image and output segmented images as it helps us label different parts of the brain based on Intensity Based MRI Images, automatically without Manual Intervention.

For Details about the Project written in a proper way with all the supporting mathematical expression, explanations, etc. refer to `Image-Segmentation.html`(Download and Run for better Experience). You can take a look at `Image-Segmentation.md`(But Github doesn't support Latex rendering in markdown yet). The code that generated both these previously mentioned files is written neatly in `Image-Segmentation.Rmd`(R-Markdown File)

One Major Drawbacks of simply Using EM-Algorithm without modification are:
- It does not takes into account the correlation of neighbouring pixels and assumes each pixel density to be independent of all the other pixels.
- It commits many misclassification of pixels due to above reason

Functions used in the `function-image-segment.R`:
- `Segment.Image.EM`: It takes the PNG image name, number of gaussians or clusters to use, number of iterations of EM Algorithm to run, Tolerance Value. It outputs a list which contains matrices corresponding to the segmented image use `grid::grid.raster(<one of the matrices from the list>)` or similar function to display the matrix as image.
- The same function written in Rmd File supports JPEG images or Matrices too as input now.

Usage:
- Run the lines of commands in `function-image-segment.R` Rscript.
- Before running it on example images keep the PNG(grayscale - Color PNG not supported yet) images in the same folder where the RScript is running.

Tip:
- Use RStudio for smoother experience.
