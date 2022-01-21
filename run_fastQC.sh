#!/bin/bash

#SBATCH --job-name="QC"
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=2GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=sara.kraettli@students.unibe.ch

# Load fastqc module
module add UHTS/Quality_control/fastqc/0.11.9;

# Create links to the read-files
ln -s /data/courses/rnaseq/toxoplasma_de/reads/*.fastq.gz .

# Run fastqc for all the linked reads in the current directory
fastqc -t 4 *.fastq.gz
