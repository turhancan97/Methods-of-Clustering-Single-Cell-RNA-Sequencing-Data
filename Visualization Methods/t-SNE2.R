# The “Rtsne” package has an implementation of t-SNE in R. 
# The package can be installed in R using the following command typed in the R console:
# install.packages("Rtsne")

train <- snedata::download_mnist()
# MNIST data can be downloaded from the MNIST website and can be converted into 
# a csv file with small amount of code.
# train<- read.csv(file.choose()) ## Choose the train.csv file downloaded
library(Rtsne)

## Curating the database for analysis with both t-SNE and PCA
Labels<-train$label
train$label<-as.factor(train$label)

## for plotting
colors = rainbow(length(unique(train$label)))
names(colors) = unique(train$label)

## Executing the algorithm on curated data
tsne <- Rtsne(train[,-1], dims = 2, perplexity=30, verbose=TRUE, max_iter = 500)
'''
Done in 649.10 seconds (sparsity = 0.001791)!
  Learning embedding...
Iteration 50: error is 120.719458 (50 iterations in 26.52 seconds)
Iteration 100: error is 120.719458 (50 iterations in 26.68 seconds)
Iteration 150: error is 120.715535 (50 iterations in 28.50 seconds)
Iteration 200: error is 112.319359 (50 iterations in 27.03 seconds)
Iteration 250: error is 104.976506 (50 iterations in 25.40 seconds)
Iteration 300: error is 5.099806 (50 iterations in 24.87 seconds)
Iteration 350: error is 4.685291 (50 iterations in 22.28 seconds)
Iteration 400: error is 4.436527 (50 iterations in 20.69 seconds)
Iteration 450: error is 4.259505 (50 iterations in 21.05 seconds)
Iteration 500: error is 4.123226 (50 iterations in 19.07 seconds)
Fitting performed in 242.10 seconds.
'''
exeTimeTsne<- system.time(Rtsne(train[,-1], dims = 2, perplexity=30, verbose=TRUE, max_iter = 500))
'''
Performing PCA
Read the 70000 x 50 data matrix successfully!
OpenMP is working. 1 threads.
Using no_dims = 2, perplexity = 30.000000, and theta = 0.500000
Computing input similarities...
Building tree...
- point 10000 of 70000
- point 20000 of 70000
- point 30000 of 70000
- point 40000 of 70000
- point 50000 of 70000
- point 60000 of 70000
- point 70000 of 70000
Done in 618.29 seconds (sparsity = 0.001791)!
Learning embedding...
Iteration 50: error is 120.719458 (50 iterations in 19.59 seconds)
Iteration 100: error is 120.719458 (50 iterations in 21.83 seconds)
Iteration 150: error is 120.716741 (50 iterations in 30.93 seconds)
Iteration 200: error is 112.251237 (50 iterations in 31.72 seconds)
Iteration 250: error is 104.929456 (50 iterations in 18.98 seconds)
Iteration 300: error is 5.099927 (50 iterations in 17.68 seconds)
Iteration 350: error is 4.689910 (50 iterations in 17.90 seconds)
Iteration 400: error is 4.439447 (50 iterations in 17.80 seconds)
Iteration 450: error is 4.259499 (50 iterations in 17.94 seconds)
Iteration 500: error is 4.121214 (50 iterations in 18.89 seconds)
Fitting performed in 213.27 seconds.
'''
# As can be seen t-SNE takes considerably longer time to execute on the same sample size of data than PCA.  

## Plotting
plot(tsne$Y, t='n', main="tsne")
text(tsne$Y, labels=train$label, col=colors[train$label])
# The plots can be used for exploratory analysis. 
# The output x & y co-ordinates and as well as cost can be used as features in classification algorithms.