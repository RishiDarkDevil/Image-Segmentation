# Returns the segmented image matrix given an image
# image.name = ?, number of gaussians to be used(Default: 2), number of iterations(Default: 10), tolerance(Default: 1e-3)
Segment.Image.EM <- function(image.name, n.gaussians = 2, niter = 10, eps = 1e-3){
  # Required Package
  require(png)
  
  # Reading the image
  img <- readPNG(image.name)
  
  # Seeing the image matrix
  print("Image Info:")
  if(length(dim(img)) == 3)
    img <- img[ , ,1]
  print(dim(img))
  
  # Seeing the image
  grid::grid.raster(img)
  
  # I am assuming that the data is generated from 2 clusters(Normal Clusters)
  
  mu <- floor((-n.gaussians/2)+1):floor(n.gaussians/2) 
  sigma <- rep(1, n.gaussians)
  p <- rep(1/n.gaussians, n.gaussians)
  
  # Creating a matrix of N x 2 size where N = 200x200(i.e. total number of pixels) and 2 cause that's the probability that a particular pixel belongs
  # to a particular cluster
  prob.mat <- matrix(rep(0, dim(img)[1]*dim(img)[2]*n.gaussians), nrow = dim(img)[1]*dim(img)[2], ncol = n.gaussians)
  
  for(iter in 1:niter){
    
    # Expectation Step
    k <- 1
    for(j in 1:dim(img)[2]){
      for (i in 1:dim(img)[1]) {
        deno.prob <- 0
        num.prob.r <- c()
        for (r in 1:n.gaussians) {
          num.prob.r <- c(num.prob.r, p[r]*dnorm(img[i,j], mu[r], sigma[r]))
          deno.prob <- deno.prob + num.prob.r[r]
        }
        prob.mat[k, ] <- num.prob.r / deno.prob
        k <- k+1
      }
    }
    mu.o <- mu
    sigma.o <- sigma
    p.o <- p
    
    # Maximization Step
    mu <- colSums(prob.mat*c(img)) / colSums(prob.mat)
    sigma <- sqrt(colSums(prob.mat*(sweep(matrix(rep(c(img), n.gaussians), ncol = n.gaussians), 2, mu))^2)/colSums((prob.mat)))
    p <- colSums(prob.mat)/(dim(img)[1]*dim(img)[2])
    
    cat('iter:', iter, '\n', 'mu:', mu, '\n', 'sigma:', sigma, '\n', 'probs:', p, '\n')
    
    # Stops if the L_inf norm falls below tolerance or any of the param becomes NaN
    if((max(abs(mu.o - mu), abs(sigma.o-sigma), abs(p.o-p)) < eps) | NaN %in% mu | NaN %in% sigma | NaN %in% p)
      break
    if(iter == niter)
      print("Max. Iteration Limit Exceeded!")
  }
  
  # Visualizing the segmentation
  seg.img <- matrix(rep(c(img), n.gaussians), ncol = n.gaussians)
  seg.img[prob.mat < 0.5] = 1
  segmented.image <- list()
  
  for (i in 1:n.gaussians) {
    segmented.image[[paste('seg.img.mat.',i,sep='')]] <- matrix(seg.img[,i], nrow = dim(img)[1], ncol = dim(img)[2])
  }
  return(segmented.image)
}

# Usage:
dog.seg <- Segment.Image.EM("dog.png", 2, 10)
grid::grid.raster(dog.seg$seg.img.mat.1)
grid::grid.raster(dog.seg$seg.img.mat.2)
writePNG(dog.seg$seg.img.mat.1, "seg-dog-1.png")
writePNG(dog.seg$seg.img.mat.2, "seg-dog-2.png")

brain.seg <- Segment.Image.EM("brainMRI.png", 3, 100)
grid::grid.raster(brain.seg$seg.img.mat.1)
grid::grid.raster(brain.seg$seg.img.mat.2)
grid::grid.raster(brain.seg$seg.img.mat.3)
writePNG(brain.seg$seg.img.mat.1, "seg-brain-1.png")
writePNG(brain.seg$seg.img.mat.2, "seg-brain-2.png")
writePNG(brain.seg$seg.img.mat.3, "seg-brain-3.png")
