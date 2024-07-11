#!/bin/bash 

BENCHMARK_NAME="mutect2_a100_h100"

# Files needed for this benchmark 
TUMOR_READ1="SRR7890824_1.fastq.gz"
TUMOR_READ2="SRR7890824_2.fastq.gz"
NORMAL_READ1="SRR7890827_1.fastq.gz"
NORMAL_READ2="SRR7890827_2.fastq.gz"

# For A100 and H100 we can optimize clock frequency
sudo ./../viking-cpu-freq.sh

docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER}  \
    pbrun somatic \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-tumor-fq ${TUMOR_READ1} ${TUMOR_READ2} \
    --in-normal-fq ${NORMAL_READ1} ${NORMAL_READ2} \
    --out-vcf output/${BENCHMARK_NAME}.vcf \
    --out-tumor-bam output/${BENCHMARK_NAME}.bam \
    --num-cpu-threads-per-stage 16 \
    --bwa-cpu-thread-pool 16 \
    --gpusort \
    --gpuwrite \
    --run-partition \
    --read-from-tmp-dir \
    --fq2bamfast \
    --keep-tmp |& tee logs/${BENCHMARK_NAME}.log 