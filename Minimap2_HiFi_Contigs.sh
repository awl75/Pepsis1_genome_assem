#!/bin/bash
#SBATCH --job-name=Minimap2_Hifi_PrimaryContig_Pepsis1
#SBATCH --mail-user=leganaw@arizona.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --mem-per-cpu=41gb
#SBATCH --constraint=hi_mem
#SBATCH --partition=standard
#SBATCH --account=cactophilic


cd "/xdisk/lmatzkin/leganaw/LeganAndrew-UA/Pepsis1_HiFi_148pM-Cell3_(all_samples)/6597_import-dataset/hifi_reads"
module load minimap2/2.24
module load samtools/1.19.2
minimap2 -ax map-hifi Pepsis1.asm.bp.p_ctg.fa Pepsis1HiFi.fastq.gz > HiFi_p_ctg_align.sam
#samtools view -bS HiFi_p_ctg_align.sam > HiFi_p_ctg_align.bam
samtools sort HiFi_p_ctg_align.sam -o HiFi_p_ctg_align.sorted.bam
samtools index HiFi_p_ctg_align.bam
