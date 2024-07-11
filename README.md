# Parabricks Benchmarking Guide

This purpose of this guide is to allow third parties to benchmark Parabricks using the most optimal hardware and software configurations. There is an emphasis on running in the cloud as this guide provides suggsted cloud instances on the major clouds. 

## Requirements

### Hardware

Two configurations are supported in this guide. The first configuration provides the lowest cost while still meeting the [minimum system requirements for Parabricks](https://docs.nvidia.com/clara/parabricks/latest/gettingstarted.html#installation-requirements) and uses the L4/A10 GPUs, while the second configuration yields the highest performance and uses A100/H100 GPUs. 

#### Lowest Cost

| CSP | Instance Type | GPU | vCPU | Memory (GB) | On Demand Price/hr |
| -------- | ------- | ------- | -------- | ------- | ------- |
| AWS | g5.24xlarge | 4 A10 | 96 | 384 | $8.144 |
| GCP |  |  |  |  |  |
| Azure |  |  |  |  |  |

#### Highest Performance

| CSP | Instance Type | GPU | vCPU | Memory (GB) | On Demand Price/hr |
| -------- | ------- | ------- | -------- | ------- | ------- |
| AWS |  |  |  |  |  |
| GCP |  |  |  |  |  |
| Azure |  |  |  |  |  |

### Software 

| Requirement | Version |
| -------- | ------- |
| NVIDIA Driver | 535 |
| Operating System | Ubuntu 22.04.2 LTS |
| Docker | >19.03 |

## Dataset 

We provide publicly available datasets for all workflows to standardize these benchmarks. It is recommended to download the data to the `data` folder in this repo, as that's where the provided benchmark scripts will assume the data is. 

### Germline

This is a 30x human genome from HG002 from the brain genomics dataset. 

| Sample | Size |
| -------- | ------- |
| [HG002.novaseq.pcr-free.30x.R1.fastq.gz](https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R1.fastq.gz ) | X GB | 
| [HG002.novaseq.pcr-free.30x.R2.fastq.gz](https://storage.googleapis.com/brain-genomics-public/research/sequencing/fastq/novaseq/wgs_pcr_free/30x/HG002.novaseq.pcr-free.30x.R2.fastq.gz) | X GB | 

### Somatic

This is SEQC-II data for tumor and normal from XYZ dataset. 

| Sample | Size |
| -------- | ------- |
| [SRR7890824_1.fastq.gz](https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890824_1.fastq.gz) | X GB |
| [SRR7890824_2.fastq.gz](https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890824_2.fastq.gz) | X GB |
| [SRR7890827_1.fastq.gz](https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890827_1.fastq.gz) | X GB |
| [SRR7890827_2.fastq.gz](https://s3.console.aws.amazon.com/s3/object/parabricks.benchmark.datasets?region=us-east-1&bucketType=general&prefix=SEQC-II_T46_N49_WGS/SRR7890827_2.fastq.gz) | X GB |
| [SRR7890824.bam]() | X GB |
| [SRR7890827.bam]() | X GB |
### Reference 

This is the GRCh38 reference from XYZ. 

| Sample | Size |
| -------- | ------- |
| [GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz](https://ftp.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz ) | X GB |

## Running Benchmarks 

This guide provides benchmarks for six Parabricks workflows: fq2bam, bwameth, deepvariant, haplotypecaller, somatic (mutect2), and deepsomatic. Bash scripts for these benchmarks can be found in the corresponding folders within this repository. 

## Cost per Genome

Calculating cost per genome is as simple as taking the total runtime for the pipeline and multiplying it by the cost of the compute instance for that time. For example if the pipeline took 30 minutes to run and the instance cost $10 per hour, then the total cost per genome for that pipeline would be $5. 

It is best practice to run the benchmark multiple times and take the average. 