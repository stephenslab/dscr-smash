MEM=10g

PROCESS_NAME=`echo "dsc_smash"`
echo "/data/tools/R-3.1.1/bin/Rscript run_dsc.R" | \
qsub -l h_vmem=${MEM} -v PATH -cwd -N ${PROCESS_NAME} \
