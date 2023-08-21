#!/bin/bash
mkdir -p examples/$1/ovs
mkdir -p examples/$1/ipt
for a in `oc get nodes | grep -v NAME | awk '{print $1}'`; do 
	diff ovs/current/$a.out ovs/old/$a.out > examples/$1/ovs/"$a"_ovs_diff.out
	diff ipt/current/$a.out ipt/old/$a.out > examples/$1/ipt/"$a"_ipt_diff.out
done;
