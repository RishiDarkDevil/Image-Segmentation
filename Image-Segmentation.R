library(png)

# Reading the image
img <- readPNG('chess.png')
# This example is only concerning the chess.png

# Seeing the image matrix
dim(img)
img[100:150, 1:25]
img[img == 1] = 0.5

# Seeing the image
grid::grid.raster(img)

# I am assuming that the data is generated from 2 clusters(Normal Clusters)
# Set the mu.1 = -1, mu.2 = 1, sigma.1 = 1, sigma.2 = 1, p.1 = 0.5, p.2 = 0.5
mu.1 <- -1
mu.2 <- 1
sigma.1 <- 1
sigma.2 <- 1
p.1 <- 0.5
p.2 <- 0.5

# Creating a matrix of N x 2 size where N = 200x200(i.e. total number of pixels) and 2 cause that's the probability that a particular pixel belongs
# to a particular cluster
prob.mat <- matrix(rep(0, 200*200*2), nrow = 200*200, ncol = 2)

# Expectation step
k <- 1
for(j in 1:dim(img)[2]){
  for (i in 1:dim(img)[1]) {
    prob.mat[k,1] <- p.1*dnorm(img[i,j], mu.1, sigma.1) / (p.1*dnorm(img[i,j], mu.1, sigma.1) + p.2*dnorm(img[i,j], mu.2, sigma.2))
    prob.mat[k,2] <- p.2*dnorm(img[i, j], mu.2, sigma.2) / (p.1*dnorm(img[i,j], mu.1, sigma.1) + p.2*dnorm(img[i,j], mu.2, sigma.2))
    k <- k+1
  }
}
prob.mat

# Maximization Step
mu.1 <- sum(prob.mat[,1]*c(img))/sum(prob.mat[,1])
mu.2 <- sum(prob.mat[,2]*c(img))/sum(prob.mat[,2])
sigma.1 <- sqrt(sum(prob.mat[,1]*(c(img)-mu.1)^2)/sum(prob.mat[,1]))
sigma.2 <- sqrt(sum(prob.mat[,2]*(c(img)-mu.2)^2)/sum(prob.mat[,2]))
p.1 <- sum(prob.mat[,1])/(dim(img)[1]*dim(img)[2])
p.2 <- sum(prob.mat[,2])/(dim(img)[1]*dim(img)[2])

# Iterating EM
for(iter in 1:14){
  k <- 1
  for(j in 1:dim(img)[2]){
    for (i in 1:dim(img)[1]) {
      prob.mat[k,1] <- p.1*dnorm(img[i,j], mu.1, sigma.1) / (p.1*dnorm(img[i,j], mu.1, sigma.1) + p.2*dnorm(img[i,j], mu.2, sigma.2))
      prob.mat[k,2] <- p.2*dnorm(img[i, j], mu.2, sigma.2) / (p.1*dnorm(img[i,j], mu.1, sigma.1) + p.2*dnorm(img[i,j], mu.2, sigma.2))
      k <- k+1
    }
  }
  mu.1 <- sum(prob.mat[,1]*c(img))/sum(prob.mat[,1])
  mu.2 <- sum(prob.mat[,2]*c(img))/sum(prob.mat[,2])
  sigma.1 <- sqrt(sum(prob.mat[,1]*(c(img)-mu.1)^2)/sum(prob.mat[,1]))
  sigma.2 <- sqrt(sum(prob.mat[,2]*(c(img)-mu.2)^2)/sum(prob.mat[,2]))
  p.1 <- sum(prob.mat[,1])/(dim(img)[1]*dim(img)[2])
  p.2 <- sum(prob.mat[,2])/(dim(img)[1]*dim(img)[2])
  
  cat(mu.1, mu.2, sigma.1, sigma.2, p.1, p.2, '\n')
}

# Visualizing the segmentation
prob.mat
seg.img.1 <- c(img)
seg.img.1[prob.mat[,1] < 0.5] = 1
seg.img.1 <- matrix(seg.img.1, dim(img)[1], dim(img)[2])
seg.img.2 <- c(img)
seg.img.2[prob.mat[,2] < 0.5] = 1
seg.img.2 <- matrix(seg.img.2, dim(img)[1], dim(img)[2])
grid::grid.raster(seg.img.1)
grid::grid.raster(seg.img.2)
