#!/bin/bash 

mkdir -p data/logs
mkdir -p data/output
cd data

# Germline 
wget https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R1.fastq.gz --no-check-certificate
wget https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R2.fastq.gz --no-check-certificate

# Somatic 
https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890824_1.fastq.gz
https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890824_2.fastq.gz
https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890827_1.fastq.gz
https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890827_2.fastq.gz

SRR7890824.bam
SRR7890827.bam

# Reference 
wget -O parabricks_sample.tar.gz "https://s3.amazonaws.com/parabricks.sample/parabricks_sample.tar.gz" --no-check-certificate
tar xzf parabricks_sample.tar.gz
mv parabricks_sample/Ref /raid/ref

cd -