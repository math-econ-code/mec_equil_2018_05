#!/bin/bash
#
#SBATCH --job-name=CDescent
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --time=00:10:00
#SBATCH --mem=10GB

module purge
module load gcc/6.3.0

cd /scratch/$USER/mec_class/cpp

export OMP_NUM_THREADS=20
export OPENBLAS_NUM_THREADS=20

export ARMA_INCLUDE_PATH=$SCRATCH/libs/arma/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SCRATCH/usr/lib
export OPENBLAS_LINK_PATH="-L$SCRATCH/usr/lib"

make

./coord_jacobi.out &> job_output.txt
