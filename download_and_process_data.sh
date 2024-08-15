#!/bin/bash 

# This container will only be used for generating BAM files for testing, not for performance
# so this will work with any Parabricks version 4.0 and later 
PB_CONTAINER=nvcr.io/nvidia/clara/clara-parabricks:4.3.0-1

mkdir -p data/logs
mkdir -p data/output
cd data

# Reference 
wget -O parabricks_sample.tar.gz "https://s3.amazonaws.com/parabricks.sample/parabricks_sample.tar.gz" --no-check-certificate
tar xzf parabricks_sample.tar.gz
mv parabricks_sample/Ref /raid/ref

# Germline 
wget https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R1.fastq.gz --no-check-certificate
wget https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R2.fastq.gz --no-check-certificate

# Somatic 
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7890827/SRR7890827 --output-document=SRR7890827.sra --no-check-certificate
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7890824/SRR7890824 --output-document=SRR7890824.sra --no-check-certificate

# Convert SRA to FASTQ files
fastq-dump --split-files ./SRR7890827.sra --gzip
fastq-dump --split-files ./SRR7890824.sra --gzip

# Generate Tumor BAM SRR7890824
docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v `pwd`/data:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun fq2bamfast \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-fq SRR7890824_1.fastq.gz SRR7890824_2.fastq.gz \
    --out-bam SRR7890824.bam \
    --low-memory |& tee logs/generate_tumor_bams.log

# Generate Normal BAM SRR7890827
docker run --rm --gpus all \
    --env TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=268435456 \
    -v /raid:/raid -v `pwd`/data:/workdir -w /workdir \
    ${PB_CONTAINER} \
    pbrun fq2bamfast \
    --ref /raid/ref/Homo_sapiens_assembly38.fasta \
    --in-fq SRR7890827_1.fastq.gz SRR7890827_2.fastq.gz \
    --out-bam SRR7890827.bam \
    --low-memory |& tee logs/generate_normal_bams.log

cd -