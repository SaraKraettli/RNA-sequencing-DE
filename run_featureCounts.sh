#!/bin/bash

#SBATCH --job-name="Counts"
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --mem=2GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=sara.kraettli@students.unibe.ch
#SBATCH --output=output_Counts_%j.o
#SBATCH --error=error_Counts_%j.e

#sample=SRR78219$1

# Load module
module add UHTS/Analysis/subread/2.0.1

# Count number of reads per gene
featureCounts -s 2 -p -a ../3_Mapping/Reference/Mus_musculus.GRCm39.104.gtf -o ./Output_Counts/read_count.txt  ../3_Mapping/Output_samtools/*.bam

