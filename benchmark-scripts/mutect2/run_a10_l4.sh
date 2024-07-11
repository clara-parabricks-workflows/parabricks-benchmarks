#!/bin/bash 

BENCHMARK_NAME="mutect2_a10_l4"

# Files needed for this benchmark 
TUMOR_READ1="SRR7890824_1.fastq.gz"
TUMOR_READ2="SRR7890824_2.fastq.gz"
NORMAL_READ1="SRR7890827_1.fastq.gz"
NORMAL_READ2="SRR7890827_2.fastq.gz"

docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun somatic \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-tumor-fq ${TUMOR_READ1} ${TUMOR_READ2} \
    --in-normal-fq ${NORMAL_READ1} ${NORMAL_READ2} \
    --out-vcf output/${BENCHMARK_NAME}.vcf \
    --out-tumor-bam output/${BENCHMARK_NAME}.bam \
    --fq2bamfast \
    --gpusort \
    --gpuwrite \
    --run-partition \
    --low-memory |& tee logs/${BENCHMARK_NAME}.log