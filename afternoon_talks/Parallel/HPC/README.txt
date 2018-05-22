
# on your compter

export MY_NYU_USERNAME=koh215
export MYDIR=$BB/trame_talks/alfred_class/2018/code/problem_1/HPC/cpp

cd $MYDIR
tar -zcvf mec_cpp.tar.gz coord_jacobi.cpp include Makefile run_cpp.s

# for the next command, make sure you are logged into the HPC from a different terminal window

scp $MYDIR/mec_cpp.tar.gz prince:/scratch/$MY_NYU_USERNAME/mec_class/cpp/mec_cpp.tar.gz

# when on the HPC

cd $SCRATCH/mec_class/cpp
tar -zxvf mec_cpp.tar.gz

sbatch run_cpp.s

squeue -u $USER

