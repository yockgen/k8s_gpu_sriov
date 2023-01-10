#!/bin/bash


for ((i=1; i <=6 ; i++)); do
        helm uninstall yockgen0$i
done
