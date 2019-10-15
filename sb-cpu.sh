#! /bin/bash
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
avg=0
echo "Check CPU for calculate prime number for 10 times with set of threads $cores"
echo "sysbench cpu --cpu-max-prime=200000 --num-threads=$cores run"
for i in 1 2 3 4 5 6 7 8 9 10
do
cpu=`sysbench cpu --cpu-max-prime=200000 --num-threads=$cores run | grep second`
echo $i: $cpu
num=`echo $cpu | awk '{print $4}'`
avg=`echo "$avg + $num"` 
done
avg=`echo "scale=2; ($avg)/10" | bc -lq`
echo Average: $avg Ops
