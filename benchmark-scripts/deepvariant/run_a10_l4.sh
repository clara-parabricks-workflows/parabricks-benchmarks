#!/bin/bash 

BENCHMARK_NAME="deepvariant_a10_l4"

# Files needed for this benchmark 
FASTQ_READ1="HG002.novaseq.pcr-free.30x.R1.fastq.gz"
FASTQ_READ2="HG002.novaseq.pcr-free.30x.R2.fastq.gz"

docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun deepvariant_germline \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-fq ${FASTQ_READ1} ${FASTQ_READ2} \
    --out-bam output/${BENCHMARK_NAME}.bam \
    --out-variants output/${BENCHMARK_NAME}.vcf \
    --fq2bamfast \
    --gpusort \
    --gpuwrite \
    --run-partition \
    --num-streams-per-gpu 4 \
    --low-memory |& tee logs/${BENCHMARK_NAME}.log 