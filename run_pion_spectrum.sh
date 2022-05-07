#!/bin/bash
#SBATCH -c 1                # Number of cores (-c)
#SBATCH -t 0-12:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared           # Partition to submit to
#SBATCH --mem=16000          # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o /n/home09/kbenkendorfer/lattice_qcd/sbatch_logs/job_output_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e /n/home09/kbenkendorfer/lattice_qcd/sbatch_logs/job_errors_%j.err  # File to which STDERR will be written, %j inserts jobid

module load Julia/1.7.1-linux-x86_64

julia pion_spectrum.jl
