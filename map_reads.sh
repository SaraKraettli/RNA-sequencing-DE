#!/bin/bash

#SBATCH --job-name="Mapping"
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --mem=8GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=sara.kraettli@students.unibe.ch
#SBATCH --output=output_Mapping_%j.o
#SBATCH --error=error_Mapping_%j.e

# Load hisat2 module
module add UHTS/Aligner/hisat/2.2.1

# Get mate1 and mate2 for each sample nr. given as input
mate1=./Input_hisat2/SRR78219$1\_1.fastq.gz
mate2=./Input_hisat2/SRR78219$1\_2.fastq.gz

# Create Index from Reference sequence
hisat2 -x ./Index/Mus_musculus -1 ${mate1} -2 ${mate2} -S ./Output_hisat2/SRR78219$1\.sam -p 4 --rna-strandness RF
