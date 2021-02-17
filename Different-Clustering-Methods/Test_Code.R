library(dropClust)
set.seed(0)
sce <-readfiles(path = "C:/Users/asus/Desktop/Silezya_Proje/Proje_Dosyalari/Single-Cell-Project/Methods-of-clustering-single-cell-RNA-sequencing-data/Clustering Methods/hg19/")
sce
dim(sce)
keep_feature <- rowSums(counts(sce) > 0) > 0
sce <- sce[keep_feature, ]
sce <- perCellQCMetrics(sce)
par(mfrow=c(1,2))
hist(sce$total, xlab="Library sizes", main="", col="grey80", ylab="Number of cells")
hist(sce$detected, xlab="Number of Detected Features", main="",col="grey80", ylab="Number of cells")
ave.counts <- rowMeans(counts(sce))
keep <- ave.counts >= 1
sum(keep)
hist(log10(ave.counts), breaks=100, main="", col="grey80",
     xlab=expression(Log[10]~"average count"))
abline(v=log10(1), col="blue", lwd=2, lty=2)