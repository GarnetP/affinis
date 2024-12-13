#!/bin/bash

## Specify the job name
#SBATCH --job-name=earlgrey_affinis

## account to charge
#SBATCH -A grylee_lab

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=earlgrey_affinis.err
#SBATCH --output=earlgrey_affinis.out

## Pass the current environment variables
#SBATCH --export=ALL

## Go to current working directory
#SBATCH --chdir=.

## Memory
#SBATCH --mem-per-cpu=3G

# Time
#SBATCH --time=4-00:00:00


## LOAD MODULES or ENVIRONMENTS  ##
source /pub/gphinney/miniforge3/etc/profile.d/conda.sh
source /pub/gphinney/miniforge3/etc/profile.d/mamba.sh
mamba activate earlgrey_env

## run earl grey


earlGrey -g /pub/gphinney/myrepos/affinis/data/raw/affinisassembly/GCA_037356375.1/GCA_037356375.1_KU_Daffinis_5.1_genomic.fasta -s drosophilaAffinis -o /pub/gphinney/myrepos/affinis/output/earlgrey_output -t 32 -r 7215
