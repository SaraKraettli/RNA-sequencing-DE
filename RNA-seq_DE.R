## RNA-sequencing

## 5. Exploratory data analysis
## Installing and loading necessary packages
install.packages("BiocManager")
BiocManager::install("DESeq2")
library(DESeq2)

# Read Counts & Column Data from txt files
counts <- read.csv('C:/Users/Sara/OneDrive - Universitaet Bern/RNA-sequencing/Project/4_Number_of_Reads/counts.txt', header = T, sep = "\t")
metaData <- read.csv('C:/Users/Sara/OneDrive - Universitaet Bern/RNA-sequencing/Project/4_Number_of_Reads/colData.txt', header = T, sep = "\t")

# Create DESeqDataSet object
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = metaData,
                              design= ~group+tissue + group:tissue, tidy = TRUE)

# Run DESeq function
dds <- DESeq(dds)

# list the coefficients
resultsNames(dds) 

# Remove the dependence of the variance on the mean
rld <- rlog(dds, blind=TRUE)

# Visualize clustering
plotPCA(rld, intgroup=c("group", "tissue"))


# 6. Differential expression analysis
# Extract pairwise contrast for the lung group (Control vs. Case)
res_lung <- results(dds, contrast=list(c("group_WT_Control_vs_WT_Case","groupWT_Control.tissueLung")), alpha = 0.05)

head(res_lung)

# How many genes are differentially expressed?
DE_lung <- res_lung[which(res_lung$padj<0.05),]
sum(DE_lung$padj < 0.05, na.rm =T)

# How many are overexpressed or underexpressed? (compared to control) (Note that > 0 means underexpressed in the case, because the comparison is Cotnrol vs. Case)
# Underexpressed in case
sum(DE_lung$log2FoldChange>0)
# Overexpressed in case
sum(DE_lung$log2FoldChange<0)

# Select 2 genes of particular interest
Irf7 <- DE_lung["ENSMUSG00000025498",]
Mx1 <- DE_lung["ENSMUSG00000000386",]

# See if up or down regulated
if(Irf7$log2FoldChange>0){
  print("Irf7 is underexpressed")
} else {print("Irf7 is overexpressed")}
if(Mx1$log2FoldChange>0){
  print("Mx1 is underexpressed")
} else {print("Mx1 is overexpressed")}


# 7. Overrepresentation analysis
# Install and load necessary packages
BiocManager::install("clusterProfiler")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("enrichplot")
library(clusterProfiler)
library(org.Mm.eg.db)
library(enrichplot)

# Run overrepresentation analysis
ego_lung <- enrichGO(gene          = DE_lung@rownames,
                     universe      = res_lung@rownames,
                     OrgDb         = org.Mm.eg.db,
                     ont           = "BP",
                     keyType = "ENSEMBL",
                     pAdjustMethod = "BH",
                     pvalueCutoff = 0.05,
                     qvalueCutoff  = 0.2,
                     readable = TRUE,
                     pool = TRUE)
head(ego_lung)

# Visualize results
barplot(ego_lung, showCategory = 20)
