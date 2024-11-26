#!/bin/bash
#SBATCH --job-name=SamDepth_Pepsis1
#SBATCH --mail-user=leganaw@arizona.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --ntasks=14
#SBATCH --mem-per-cpu=41gb
#SBATCH --constraint=hi_mem
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --partition=standard
#SBATCH --account=cactophilic

cd "/xdisk/lmatzkin/leganaw/LeganAndrew-UA/Pepsis1_HiFi_148pM-Cell3_(all_samples)/6597_import-dataset/hifi_reads" 
module load samtools/1.19.2
samtools depth HiFi_p_ctg_align.sorted.bam > HiFi_p_ctg_align.sorted.bam.coverage.txt

