#!/bin/bash

echo 20 | tee -a /sys/class/drm/card0/iov/vf7/gt/exec_quantum_ms
echo 50 | tee -a /sys/class/drm/card0/iov/vf7/gt/preempt_timeout_us

vfschedexecq=200000
vfschedtimeout=1000000
for ((i=1; i <=6 ; i++)); do

	echo $vfschedexecq | tee -a /sys/class/drm/card0/iov/vf$i/gt/exec_quantum_ms
	echo $vfschedtimeout | tee -a /sys/class/drm/card0/iov/vf$i/gt/preempt_timeout_us
        kubectl apply -f ./0$i.yaml

done
