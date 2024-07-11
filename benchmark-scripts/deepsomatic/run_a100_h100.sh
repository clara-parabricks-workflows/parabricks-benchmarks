#!/bin/bash 

BENCHMARK_NAME="deepsomatic_a100_h100"

# Files needed for this benchmark 
TUMOR_BAM="SRR7890824.bam"
NORMAL_BAM="SRR7890827.bam"

docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun deepsomatic \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-tumor-bam ${TUMOR_BAM} \
    --in-normal-bam ${TUMOR_BAM} \
    --out-variants output/${BENCHMARK_NAME}.vcf \
    --num-streams-per-gpu 4 |& tee logs/${BENCHMARK_NAME}.log