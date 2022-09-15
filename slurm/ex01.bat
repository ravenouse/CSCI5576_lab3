#!/bin/bash

# -
# |
# | This is a batch script for running a MPI parallel job on Summit
# |
# | (o) To submit this job, enter:  sbatch --export=CODE='/projects/zhwa3087/CSCI5576/lab3/src'ex_01.bat 
# |
# | (o) To check the status of this job, enter: squeue -u <username>
# |
# -

# -
# |
# | Part 1: Directives
# |
# -

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=00:01:00
#SBATCH --partition=shas-testing
#SBATCH --output=ex01-%j.out

# -
# |
# | Part 2: Loading software
# |
# -

module purge
module load intel
module load impi


# -
# |
# | Part 3: User scripting
# |
# -

echo "=="
echo "||"
echo "|| Begin Execution of fp in slurm batch script."
echo "||"
echo "=="

mpirun -n 4 /projects/zhwa3087/CSCI5576/lab3/src/fp -nPEx 2 -nPEy 2 -nCellx 5  -nCelly 5 -flux 10 -tEnd 2 -dt .1 > tty.out

echo "=="
echo "||"
echo "|| Execution of fp in slurm batch script complete."
echo "||"
echo "=="