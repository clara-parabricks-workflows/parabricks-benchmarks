# Parabricks Benchmarking Guide

This purpose of this guide is to allow third parties to benchmark Parabricks using the most optimal hardware and software configurations. There is an emphasis on running in the cloud as this guide provides suggsted cloud instances on the major clouds. 

## Requirements

### Hardware

Two configurations are supported in this guide. The first configuration provides the lowest cost while still meeting the [minimum system requirements for Parabricks](https://docs.nvidia.com/clara/parabricks/latest/gettingstarted.html#installation-requirements) and uses the A10/L4 GPUs, while the second configuration yields the highest performance and uses A100/H100 GPUs. 

#### Lowest Cost

| CSP | Instance Type | GPU | vCPU | Memory (GB) | On Demand Price/hr |
| -------- | ------- | ------- | -------- | ------- | ------- |
| AWS | g5.24xlarge | 4 A10 | 96 | 384 | $8.144 |
| GCP | g2-standard-96 | 8 L4 | 96 | 384 |  |
| Azure |  |  |  |  |  |

#### Highest Performance

| CSP | Instance Type | GPU | vCPU | Memory (GB) | On Demand Price/hr |
| -------- | ------- | ------- | -------- | ------- | ------- |
| AWS | p5.48xlarge	 | 8 H100 | 192 | 2048 |  |
| GCP | a3-highgpu-8g | 8 H100 | 208 | 1872 |  |
| Azure | NC80adis H100 v5 | 2 H100 | 80 | 640 |  |

### Software 

| Requirement | Version |
| -------- | ------- |
| NVIDIA Driver | 535 |
| Operating System | Ubuntu 22.04.2 LTS |
| Docker | >19.03 |

## Dataset 

We provide publicly available datasets for all workflows to standardize these benchmarks. To download the data, run `download_data.sh`. This script will create a folder in the root directory of this repository called `data` which will contain all the data needed to run all of the benchmarks. Once downloaded the directory should look like this: 

```
$ tree data 
[ insert data tree here]
```

The total size of the dataset is X GB. 

## Running Benchmarks 

This guide provides benchmarks for six Parabricks workflows: [`fq2bam`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_fq2bamfast.html), [`bwa-meth`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_fq2bam_meth.html), [`deepvariant`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_deepvariant_germline.html), [`haplotypecaller`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_germline.html), [`mutect2`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_somatic.html), and [`deepsomatic`](https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_deepsomatic.html). Each workflow has its own folder in this repo and contains two run scripts, one for running on A10/L4 GPUs, the most cost efficient hardware, and one for running on A100/H100 GPUs, the hardware with the best performance. 

The benchmarks scripts can be run individually or all together. All the output data will go to `data/output` and all the logs will go to `data/logs`. 

Before running any scripts, two environment variables must be exported. 

The first environment variable is `DATA_FOLDER` and it should point to the `data` folder generated by `download_data.sh`. It must be the full path, which will be different for every user. 

```
export DATA_FOLDER=/path/to/repo/data
```

The second environment variable will tell the scripts which version of Parabricks to use, be specifying a Docker container from [NGC](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/clara/containers/clara-parabricks). 

```
export PB_CONTAINER=nvcr.io/nvidia/clara/clara-parabricks:4.3.0-1
```

### Run One Benchmark

For example, to run the fq2bam benchmark for a100_h100 from the root of this repository, the commmand would be: 

```
benchmark-scripts/fq2bam/run_a100_h100.sh 
```

### Run All Benchmarks 

For example, to run all the benchmarks for a100_h100 from the root of this repository, the command would be: 

```
find benchmark-scripts -type f -name "*_a100_h100.sh" | sh 
```

## Cost per Genome

Calculating cost per genome is as simple as taking the total runtime for the pipeline and multiplying it by the cost of the compute instance for that time. For example if the pipeline took 30 minutes to run and the instance cost $10 per hour, then the total cost per genome for that pipeline would be $5. 

It is best practice to run the benchmark multiple times and take the average. 
