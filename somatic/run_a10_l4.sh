#!/bin/bash 

PB_CONTAINER="nvcr.io/nvidia/clara/clara-parabricks:4.3.0-1"
DATA_DIR="full/path/to/data"

docker run --rm --gpus all --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v ${DATA_DIR}:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun somatic \
    --ref /raid/Ref/Homo_sapiens_assembly38.fasta \
    --in-tumor-fq SRR7890824_1.fastq.gz SRR7890824_2.fastq.gz \
    --in-normal-fq SRR7890827_1.fastq.gz SRR7890827_2.fastq.gz \
    --out-vcf output_vcf.vcf \
    --out-tumor-bam output_bam.bam \
    --fq2bamfast \
    --gpusort \
    --gpuwrite \
    --run-partition \
    --low-memory