#!/bin/bash
#SBATCH --job-name=Pepsis1_JellyFish_Count
#SBATCH --mail-user=leganaw@arizona.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mem-per-cpu=41gb
#SBATCH --constraint=hi_mem
#SBATCH --partition=standard
#SBATCH --account=cactophilic

cd "/xdisk/lmatzkin/leganaw/LeganAndrew-UA/Pepsis1_HiFi_148pM-Cell3_(all_samples)/6597_import-dataset/hifi_reads"

module load jellyfish/2.2.10

jellyfish count -m 21 -s 35G -t 12 -C --bc Pepsis1.fastq.bc Pepsis1HiFi.fastq

