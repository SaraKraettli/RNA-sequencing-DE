# RNA-sequencing-DE
Repository for the documented code used for the analysis in the course "RNA-sequencing".

Project: Detect differentially expressed genes from bulk RNA-seq data.

# 1. Getting Started
(Everything on the IBU-cluster)

Create working directories:  
```
$ cd /data/courses/rnaseq/toxoplasma_de  
$ mkdir skraettli_workspace
$ cd skraettli_workspace
$ mkdir 2_Quality_Checks
$ mkdir 3_Mapping
$ mkdir 4_Number_of_Reads
``` 

# 2. Quality Checks
(Everything on the IBU-cluster)

Go to appropriate working directory:  
```
$ cd /data/courses/rnaseq/toxoplasma_de/skraettli_workspace/2_Quality_Checks
```

Create and eddit script:  
```
$ vim run_fastQC.sh
```

Submit Job:  
```
$ sbatch run_fastQC.sh
```


# 3. Map reads to the reference genome
(Everything on the IBU-cluster)

Go to appropriate working directory:  
```
$ cd /data/courses/rnaseq/toxoplasma_de/skraettli_workspace/3_Mapping
```

Create directory for the reference genome:  
```
$ mkdir Reference
```

Upload downloaded Mus_musculus.GRCm39.dna.primary_assembly.fa.gz & Mus_musculus.GRCm39.104.gtf.gz to directory "Reference"

Create and edit script to produce index files for Hisat2:  
```
$ vim produce_index_files.sh
```

Submit Job:  
```
$ sbatch produce_index_files.sh
```

Create and edit script to map reads with hisat2:  
```
$ vim map_reads.sh
```

Create directories for input and output files:  
```
$ mkdir Input_hisat2
$ mkdir Output_hisat2
```

Create links to the read-files:  
```
$ ln -s /data/courses/rnaseq/toxoplasma_de/reads/*.fastq.gz ./Input_hisat2
```

Submit Jobs for all samples:  
```
$ sbatch map_reads.sh 18
$ sbatch map_reads.sh 19
$ sbatch map_reads.sh 20
$ sbatch map_reads.sh 21
$ sbatch map_reads.sh 22
$ sbatch map_reads.sh 37
$ sbatch map_reads.sh 38
$ sbatch map_reads.sh 39
$ sbatch map_reads.sh 49
$ sbatch map_reads.sh 50
$ sbatch map_reads.sh 51
$ sbatch map_reads.sh 52
$ sbatch map_reads.sh 53
$ sbatch map_reads.sh 68
$ sbatch map_reads.sh 69
$ sbatch map_reads.sh 70
```

Create and edit script for the samtools steps:  
```
$ vim run_samtools.sh
```

Create directory for output files:  
```
$ mkdir Output_samtools_view
$ mkdir Output_samtools
```

Submit Jobs:  
```
$ sbatch run_samtools.sh 18
$ sbatch run_samtools.sh 19
$ sbatch run_samtools.sh 20
$ sbatch run_samtools.sh 21
$ sbatch run_samtools.sh 22
$ sbatch run_samtools.sh 37
$ sbatch run_samtools.sh 38
$ sbatch run_samtools.sh 39
$ sbatch run_samtools.sh 49
$ sbatch run_samtools.sh 50
$ sbatch run_samtools.sh 51
$ sbatch run_samtools.sh 52
$ sbatch run_samtools.sh 53
$ sbatch run_samtools.sh 68
$ sbatch run_samtools.sh 69
$ sbatch run_samtools.sh 70
```

# 4. Count the number of reads per gene
**(On the IBU-cluster)**

Go to appropriate working directory:  
```
$ cd /data/courses/rnaseq/toxoplasma_de/skraettli_workspace/4_Number_of_Reads
```

Create and edit script to count reads with featureCounts:  
```
$ vim run_featureCounts.sh
```

Create directories for output files:  
```
$ mkdir Output_Counts
```

Submit Job:  
```
$ sbatch run_featureCounts.sh
```

**(On the local machine)**

Get all the output files from the read count:  
```
scp skraettli@binfservms01.unibe.ch:/data/courses/rnaseq/toxoplasma_de/skraettli_workspace/4_Number_of_Reads/Output_Counts/* .
```

# 5-7 Exploratory data analysis, Differential expression analysis & Overrepresentation analysis
(Everything on the local machine)

Deleted first line from read_count.txt and deleted "../3_Mapping/Output_samtools/" in front of all the samples & ".bam" at the end.  
bash command to cut columns containing Chr, Start, End, Strand and Length:  
```
cut -f 1,7-22 read_count.txt > counts.txt
```

Created "colData.txt" for the DESeqDAtaSet object.

Wrote R script "RNA-seq_DE.R".
