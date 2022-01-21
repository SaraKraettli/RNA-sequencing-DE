#!/bin/bash

#SBATCH --job-name="Samtools"
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=30GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=sara.kraettli@students.unibe.ch
#SBATCH --output=output_samtools_%j.o
#SBATCH --error=error_samtools_%j.e

sample=SRR78219$1

# Load module
module add UHTS/Analysis/samtools/1.10

# Convert sam files to bam
samtools view -hbS ./Output_hisat2/${sample}.sam > ./Output_samtools_view/${sample}.bam

# Sort the bam file
samtools sort -m 25G -@ 4 -o ./Output_samtools/${sample}.bam -T temp ./Output_samtools_view/${sample}.bam

# Indexing
samtools index ./Output_samtools/${sample}.bam
