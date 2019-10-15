#! /bin/bash
bs="64K"
for op in "read" "write"
do
avg1=0
avg2=0
echo "Check memory for the $op operations with block size $bs"
echo "sysbench memory --memory-oper=$op --memory-access-mode=rnd --memory-block-size=$bs run"
for i in 1 2 3 4 5 6 7 8 9 10
do
out=`sysbench memory --memory-oper=$op --memory-access-mode=rnd --memory-block-size=$bs run | grep -E 'Total|transf'`
echo $i: $out 
num=`echo $out | grep -Eio '([0-9]+\.[0-9]+)'`
ops=`echo $num | awk '{print $1}'`
avg1=`echo "$avg1 + $ops"`
speed=`echo $num | awk '{print $3}'`
avg2=`echo "$avg2 + $speed"`
done
avg1=`echo "scale=2; ($avg1)/10" | bc -lq`
avg2=`echo "scale=2; ($avg2)/10" | bc -lq`
echo "Avg $op: $avg1 Ops $avg2 MiBps"
done
