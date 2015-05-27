MEM=20g

LOG_DIR="$HOME/dscr-smash/logs/"
if [ ! -d "${LOG_DIR}" ]; then
    mkdir ${LOG_DIR}
fi

PROCESS_NAME=`echo "run_dsc_smash"`
echo "/data/tools/R-3.1.1/bin/Rscript run_dsc.R" | \
qsub -l h_vmem=${MEM} -v PATH -cwd -N ${PROCESS_NAME} \
        -o ${LOG_DIR}${PROCESS_NAME}"_log.out" -e ${LOG_DIR}${PROCESS_NAME}"_log.err"

