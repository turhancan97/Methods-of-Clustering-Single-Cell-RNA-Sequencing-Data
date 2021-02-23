# Methods of Clustering Single-Cell RNA Sequencing Data
![Single-Cell](https://user-images.githubusercontent.com/22428774/108861140-f5730c00-75ff-11eb-8eaf-ffbfc04f840f.JPG)

Today it is possible to obtain genome-wide transcriptome data from single cells using high-throughput sequencing. It is what we call single-cell RNA-Sequencing or scRNA-Seq. The main advantage of single-cell RNA-Sequencing is that it allows researchers to measure gene expression levels at the resolution of single cells. In that sense, single-cell RNA-Sequencing is analogous to a bowl of fruits, where each piece of fruit is a cell whose type can be identified. Why is it amazing? It is because the cellular resolution and the genome-wide scope offers the unprecedented opportunity to investigate at the cellular level fundamental biological questions, such as stem cell differentiation or the discovery and characterization of rare cell types. It makes it possible to address issues that are intractable using other methods, e.g. bulk RNA-sequencing. Using bulk sequencing, which is the technology that was developed before single-cell sequencing, you get an averaged gene expression profile of all the cells in the sample. Continuing the fruit analogy, bulk RNA-Seq could be viewed as a smoothie, where you sample a mixture of blended fruits which gives you an average signal of all cells in the sample. So, using bulk RNA-Sequencing, it is not possible to identify the different cell-types within one sample.

![Ekran Alıntısı](https://user-images.githubusercontent.com/22428774/108856257-eccc0700-75fa-11eb-85b7-89e1c15f74ac.PNG)

## scRNA-Seq could revolutionize personalized medicine in cancer
Why is single-cell RNA-Sequencing a revolution in biology? Well, it's because it has plenty of applications, especially in cancer, microbiology, and neurology. For example, in personalized medicine in cancer, it could enable researchers to identify individual clones and biomarkers in a tumor, and select precision drugs for each of them. This is not possible using bulk RNA-sequencing where you get an average gene expression profile of all the cells in the tumor. It's what's represented in the figure here where red, blue, and purple cells have been identified as different cell types and could be targeted separately by different drugs when single-cell RNA-sequencing is used.

![Ekran Alıntısı2](https://user-images.githubusercontent.com/22428774/108857282-fbff8480-75fb-11eb-9130-20c6f1a8e1a8.PNG)

## Data structure
With single-cell RNA-Seq, the data you get out from the lab after the preprocessing is this big matrix where you have the genes as the rows and the cells as the columns. Inside the matrix you have counts corresponding to the number of reads aligned to each gene and each cell where a read is a sequence of nucleotides (A,T,C,G). You also get two other matrices corresponding to the cell-level and gene-level covariates. For the gene-level covariates, you for example have the length of the genes or the GC content which is the percentage of nucleotides G and C compared to nucleotides A and T. For the cell-level covariates, you could have quality control measures of the cells, for example, the batches in which the cells have been sequenced.With single-cell RNA-Seq, the data you get out from the lab after the preprocessing is this big matrix where you have the genes as the rows and the cells as the columns. Inside the matrix you have counts corresponding to the number of reads aligned to each gene and each cell where a read is a sequence of nucleotides (A,T,C,G). You also get two other matrices corresponding to the cell-level and gene-level covariates. For the gene-level covariates, you for example have the length of the genes or the GC content which is the percentage of nucleotides G and C compared to nucleotides A and T. For the cell-level covariates, you could have quality control measures of the cells, for example, the batches in which the cells have been sequenced.

![Ekran Alıntısı3](https://user-images.githubusercontent.com/22428774/108857671-60badf00-75fc-11eb-81d4-d7815e1452af.PNG)

Now, in the matrix of counts, there are many more zeros than in bulk RNA-sequencing. The zeros can be biological when a gene is simply not expressed in a cell. For example, genes involved in the division of the cell are not expressed at each step of the cell cycle. The zeros can also be technical when the sequencing machine fails to sequence reads from a gene and a cell. In that case, you observe a zero in the count matrix instead of an actual count. It's what people call dropouts.

# Typical workflow

## Exponential scaling of scRNA-Seq in the last decade
The development of new methods and protocols for scRNA-Seq is currently a very active area of research, and several protocols have been published over the last few years. The image here taken from Svensson et al paper shows on the y-axis that the number of cells per dataset has increased from 1 cell for the very first dataset in 2009 to up to 1 million cells for datasets generated today.

![Ekran Alıntısı4](https://user-images.githubusercontent.com/22428774/108857996-bd1dfe80-75fc-11eb-94f6-1a4b32db3b99.PNG)

## scRNE-seq workflow

After seeing the different technologies in figure above, let's now get an overview of the different steps of a typical workflow to analyze single-cell RNA-seq.

* Quality control
* Normalization
* Dimensionality reduction
* Clustering
* Differential expression analysis

![Ekran Alıntısı5](https://user-images.githubusercontent.com/22428774/108858495-459c9f00-75fd-11eb-9110-b3fa33018d47.PNG)

1. **Quality control** : The very first step when working with scRNA-Seq data is to filter out low-quality cells and genes to ensure that technical effects do not distort downstream analysis results. Two common measures of cell quality are the library size and cell coverage. The library size is defined as the total sum of counts across all genes, where here the word "library" refers to a cell. And the cell coverage is defined as the average number of genes with non-zero counts for that cell.
2. **Normalization** : Once the problematic cells have been removed, a typical workflow to analyze scRNA-Seq data includes several steps. The first step is the normalization of cell- and gene- specific biases. It is a critical step in the analysis pipeline that adjusts for unwanted biological and technical effects that can mask the biological signal of interest.
3. **Dimensionality reduction** : Then, the large majority of scRNA-Seq analyses include a dimensionality reduction step where the number of dimensions goes from J (that is the number of genes) to K which is smaller than J. This step achieves a two-fold objectives: first the data become more tractable, and second noise can be reduced while preserving the signal of interest.
4. **Clustering** : The third step, is to group the cells according to the low-dimensional matrix K by N computed in the previous step where N is the total number of cells in the dataset. From this step, you get a cluster label for each cell.
5. **Differential expression analysis** : Finally, the last step is to find biomarkers between identified groups of cells, that is, find genes that are differentially expressed between groups of cells. This gives you an overview of the typical workflow used to analyze scRNA-Seq data.

## GC content
The GC content (or guanine-cytosine content) is the percentage of bases on a DNA or RNA molecule that are either guanine (G) or cytosine (C) out of four possible bases. In addition to guanine (G) and cytosine (C), the other bases are adenine (A), and thymine (T) in DNA or uracil (U) in RNA. We'll see later in the course that GC content could be a bias in scRNA-Seq.

# Load, create, and access single-cell datasets in R
## SingleCellExperiment class
SingleCellExperiment class. It’s a S4 class developed by Aaron Lun and Davide Risso. And it’s very useful to analyze single-cell data because it allows you to easily store and retrieve the matrix of counts but also information about the cells and the genes. You remember the three matrices (one with the raw counts, and the other two for gene and cell-level information), the idea here is that we are going to use only one R object to store these three matrices.

`SingleCellExperiment (SCE)` is a S4 class for storing data from single-cell experiments and it can store and retrieve: matrix of counts:
- [x] Cell and gene information
- [x] Spike-in information,
- [x] Dimensionality reduction coordinates,
- [x] Size factors for each cell,
- [x] Usual metadata for genes and cells.
in a single R object!

* How does it work in practice? First, you need to install and load the SingleCellExperiment package using the usual biocLite and library functions.

[Click to install](https://bioconductor.org/packages/3.9/bioc/html/SingleCellExperiment.html )

The SingleCellExperiment class is a lightweight Bioconductor container for storing and manipulating single-cell genomics data. It extends the
RangedSummarizedExperiment class and follows similar conventions, i.e., rows should represent features (genes, transcripts, genomic regions)
and columns should represent cells. It provides methods for storing dimensionality reduction results and data for alternative feature sets (e.g.,
synthetic spike-in transcripts, antibody-derived tags). It is the central data structure for Bioconductor single-cell packages like scater and scran.

![SingleCellExperiment](https://user-images.githubusercontent.com/22428774/108861218-09b70900-7600-11eb-9ff8-34a65d28bf06.JPG)

# dropClust Package
The dropClust pipeline enables user to performspeedy analysis of ultra-large scRNA-seq data. The major functionalities of the end-to-end pipeline include data normalization,
gene selection, unsupervised clustering of transcriptomes, low dimensional visualization of the complete data and differential expression analysis.

[Click for dropClust R package and tutorial](https://github.com/debsin/dropClust)

In this project, dropClust package has been used to analyse scRNA-seq data (ABT data and PBMC data). dropClust works on a SingleCellExperiment class object, so that first the datasets has been converted to sce class object.

# Comparison

Dunn index and clustering comparison was performed by tuning of various parameters separately for ABT and PBMC data. You can see the results in figures below.

![Ekran Alıntısı6](https://user-images.githubusercontent.com/22428774/108863086-e2f9d200-7601-11eb-9425-2d61534e6eeb.PNG)

![Ekran Alıntısı7](https://user-images.githubusercontent.com/22428774/108863148-f311b180-7601-11eb-908e-84c89ed55f13.PNG)

# Reference

1. Lun AT, McCarthy DJ, Marioni JC. A step-by-step workflow for low-level analysis of single-cell RNA-seq data with Bioconductor. 2016; doi:10.12688/f1000research.9501.2
2. Marczyk M, Patwardhan GA, Zhao J, Qu R, Li X, Wali VB, Gupta AK, Pillai MM, Kluger Y, Yan Q, Hatzis C, Pusztai L, Gunasekharan V. Multi-Omics Investigation of Innate Navitoclax Resistance in Triple-Negative Breast Cancer Cells. Cancers. 2020; 12(9):2551. https://doi.org/10.3390/cancers12092551
3. Sinha D, Kumar A, Kumar H, Bandyopadhyay S, Sengupta D. dropClust: Efficient clustering of ultra-large scRNA-seq data. 2018; doi:10.1101/170308
4. McInnes L, Healy J, Melville J. UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction. 2018; https://arxiv.org/abs/1802.03426
5. Perraudeau F, Risso D, Street K et al. Bioconductor workflow for single-cell RNA sequencing: Normalization, dimensionality reduction, clustering, and lineage inference 2017; 6:1158 https://doi.org/10.12688/f1000research.12122.1


