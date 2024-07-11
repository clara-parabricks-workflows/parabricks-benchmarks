#!/bin/bash 

BENCHMARK_NAME="fq2bam_a100_h100"

# Files needed for this benchmark 
FASTQ_READ1="HG002.novaseq.pcr-free.30x.R1.fastq.gz"
FASTQ_READ2="HG002.novaseq.pcr-free.30x.R2.fastq.gz"

# For A100 and H100 we can optimize clock frequency
sudo ./../viking-cpu-freq.sh

docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun fq2bamfast \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-fq ${FASTQ_READ1} ${FASTQ_READ2} \
    --out-bam output/${BENCHMARK_NAME}.bam \
    --bwa-cpu-thread-pool 16 \
    --gpusort \
    --gpuwrite \
    --keep-tmp |& tee logs/${BENCHMARK_NAME}.log