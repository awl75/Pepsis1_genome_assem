#!/bin/bash
#SBATCH --job-name=Pepsis1_hifiasm
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

/home/u9/leganaw/hifiasm/hifiasm -o Pepsis1.asm -t16 -l0 Pepsis1HiFi.fastq.gz 2> Pepsis1.asm.log
