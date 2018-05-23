#
# Requirements

The Armadillo library is required. You can set the include directory for Armadillo using:

export ARMA_INCLUDE_PATH=/path/to/armadillo

If you don't have Armadillo, use

git clone https://github.com/conradsnicta/armadillo-code.git
cp -rf ./armadillo-code/include/* ./include
rm -rf armadillo-code

Linux users need OpenBLAS (compiled with the option USE_OPENMP=1).

#
# Building locally

In a terminal environment, type

make

and run the program using

./coord_jacobi.out

Mac users will need to obtain an OpenMP-compatible compiler. This can be done via MacPorts or Homebrew; e.g.,

sudo port install clang-6.0
export CXX=clang++-mp-6.0

#
# NYU HPC
#

# on your computer 

export MY_NYU_USERNAME=bob100
export MYDIR=/path/to/this/file

cd $MYDIR
tar -zcvf mec_cpp.tar.gz coord_jacobi.cpp include Makefile run_cpp.s

# for the next command, make sure you are logged into the HPC from a different terminal window

scp $MYDIR/mec_cpp.tar.gz prince:/scratch/$MY_NYU_USERNAME/mec_class/cpp/mec_cpp.tar.gz

# Then switch to the HPC

cd $SCRATCH/mec_class/cpp
tar -zxvf mec_cpp.tar.gz

# send job
sbatch run_cpp.s

# check status of your jobs
squeue -u $USER

