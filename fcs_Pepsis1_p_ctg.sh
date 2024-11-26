#!/bin/bash
#SBATCH --job-name=fcs_Pepsis1
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

module load python/3.9/3.9.10
LOCAL_DB="/xdisk/lmatzkin/cwallan/FCS/gxdb/latest/"
export FCS_DEFAULT_IMAGE=fcs-gx.sif

python3 /xdisk/lmatzkin/cwallan/FCS/fcs.py screen genome --fasta Pepsis1.asm.bp.p_ctg.fa --out-dir ./gx_Pepsis1_p_ctg/ --gx-db /xdisk/lmatzkin/cwallan/FCS/gxdb/latest/ --tax-id 173815
