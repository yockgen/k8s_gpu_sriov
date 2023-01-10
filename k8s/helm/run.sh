#!/bin/bash


for ((i=1; i <=6 ; i++)); do
        helm uninstall yockgen0$i
        helm install yockgen0$i ./gpu-sriov --set gpu=/dev/dri/card$i --set id=test0$i-synbench --set idPod=synbench0$i
done
