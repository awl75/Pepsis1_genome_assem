#!/bin/bash
#SBATCH --job-name=CountMappedReads_Pepsis1
#SBATCH --mail-user=leganaw@arizona.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --ntasks=14
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --partition=standard
#SBATCH --account=cactophilic

cd "/xdisk/lmatzkin/leganaw/LeganAndrew-UA/Pepsis1_HiFi_148pM-Cell3_(all_samples)/6597_import-dataset/hifi_reads" 

awk '{sum[$1] += $3} END {for (contig in sum) print contig, sum[contig]}' HiFi_p_ctg_align.sorted.bam.coverage.txt > Pepsis1_contig_read_counts.tsv


