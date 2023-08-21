#!/bin/bash

rm -rf ipt/old
mv ipt/current ipt/old
mkdir ipt/current

for a in `oc get nodes | awk '{print $1}' | grep -v NAME`; do
        ansible $a -m shell -a "iptables-save | grep -v Completed" > ipt/current/$a.out
done;
	

