#!/bin/bash

count=$(jq length /tmp/gpu_sriov_config.json)
for ((i=1; i <=$count ; i++)); do

  echo 0 | tee -a /sys/class/drm/card0/iov/vf$i/gt/exec_quantum_ms
  echo 0 | tee -a /sys/class/drm/card0/iov/vf$i/gt/preempt_timeout_us

  vfschedexecq=$(jq .[$i-1].exec /tmp/gpu_sriov_config.json)
  vfschedtimeout=$(jq .[$i-1].timeout /tmp/gpu_sriov_config.json)

  echo $vfschedexecq | tee -a /sys/class/drm/card0/iov/vf$i/gt/exec_quantum_ms
  echo $vfschedtimeout | tee -a /sys/class/drm/card0/iov/vf$i/gt/preempt_timeout_us
done
