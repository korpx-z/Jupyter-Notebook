#!/bin/bash
IP=`ifconfig eth0 | grep "inet " | awk '{print $2}'`

if [ -z "$NBDIR" ];
then 
	NBDIR=/home/notebooks
fi

mkdir -p "$NBDIR"

jupyter notebook --ip="$IP" --notebook-dir="$NBDIR" "$@"
