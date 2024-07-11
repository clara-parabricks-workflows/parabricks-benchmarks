#!/bin/bash
# This script is meant to be run on H100 and A100 instances to maximize performance
# Please run with sudo
# Relevant docs: https://wiki.archlinux.org/title/CPU_frequency_scaling

CPUFREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies | tr ' ' '\n' | sort -n | tail -1)
for NODE in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
do
echo $CPUFREQ > $NODE
done

# cpupower help set
# Currently was set at 6 which is not biased towards performance all the way
# The range of valid numbers is 0-15, where 0 is maximum performance and 15 is maximum energy efficiency
# $ sudo cpupower info
# analyzing CPU 0:
# perf-bias: 6
sudo cpupower set -b 0

# Set to performance mode on the governor
sudo cpupower frequency-set -g performance
echo "Previous value of transparent huge pages: (PROBABLY A GOOD IDEA TO SET IT BACK AFTER YOU'RE DONE)"

# Old value
cat /sys/kernel/mm/transparent_hugepage/enabled

# Use transpare hugepages
echo always | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo "Current value for transparent huge pages"
cat /sys/kernel/mm/transparent_hugepage/enabled
