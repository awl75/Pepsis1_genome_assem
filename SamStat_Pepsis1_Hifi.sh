#!/bin/bash
#SBATCH --job-name=Pepsis1_SamStat
#SBATCH --mail-user=leganaw@arizona.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --ntasks-per-node=10
#SBATCH --nodes=1
#SBATCH --time=30:00:00
#SBATCH --partition=standard
#SBATCH --account=cactophilic

cd "/xdisk/lmatzkin/leganaw/LeganAndrew-UA/Pepsis1_HiFi_148pM-Cell3_(all_samples)/6597_import-dataset/hifi_reads" 
module load samtools/1.19.2
samtools stats -@ 8  m84082_241003_150529_s3.hifi_reads.bc2060.bam > m84082_241003_150529_s3.hifi_reads.bc2060.bam.samtools.stats.txt

