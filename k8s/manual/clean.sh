#!/bin/bash

vfschedexecq=0
vfschedtimeout=0
for ((i=1; i <=6 ; i++)); do

        kubectl delete -f ./0$i.yaml
	#echo $vfschedexecq | tee -a /sys/class/drm/card0/iov/vf$i/gt/exec_quantum_ms
	#echo $vfschedtimeout | tee -a /sys/class/drm/card0/iov/vf$i/gt/preempt_timeout_us
done
