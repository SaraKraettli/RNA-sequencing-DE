#!/bin/bash

#SBATCH --job-name="Indexing"
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --mem=8GB
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=sara.kraettli@students.unibe.ch
#SBATCH --output=output_%j.o
#SBATCH --error=error_%j.e

# Load hisat2 module
module add UHTS/Aligner/hisat/2.2.1

# Create directory for index
mkdir Index

#Create Index from Reference sequence
hisat2-build ./Reference/Mus_musculus.GRCm39.dna.primary_assembly.fa ./Index/Mus_musculus
