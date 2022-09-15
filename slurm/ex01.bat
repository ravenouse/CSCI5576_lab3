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

## doing cleaning
rm tmp*
rm *.plt
rm 0 1 2 3
rm 0.sed 1.sed 2.sed 3.sed
rm vg
rm *.out

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

./writePlotCmd.py

rm *.sed
rm 0 1 2 3

grep 'myPE: 0' tmp > 0.sed  ; sed s/'myPE: 0'/''/g 0.sed > 0
grep 'myPE: 1' tmp > 1.sed  ; sed s/'myPE: 1'/''/g 1.sed > 1
grep 'myPE: 2' tmp > 2.sed  ; sed s/'myPE: 2'/''/g 2.sed > 2
grep 'myPE: 3' tmp > 3.sed  ; sed s/'myPE: 3'/''/g 3.sed > 3

echo "=="
echo "||"
echo "|| Execution of fp in slurm batch script complete."
echo "||"
echo "=="