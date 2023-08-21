#!/bin/bash

rm -rf ovs/old
mv ovs/current ovs/old
mkdir ovs/current

for a in `oc get nodes | awk '{print $1}' | grep -v NAME`; do
	container_id=`ansible $a -m shell -a 'docker ps | grep ovs | grep bash | cut -d " " -f 1' 2> /dev/null| grep -v SUCCESS`
        ansible $a -m shell -a "docker exec -i $container_id ovs-ofctl -O OpenFlow13 dump-flows br0 | sed -E 's/ duration\=\w+\.\w+,//g' | sed -E 's/ n_packets\=\w+\,//g' | sed -E 's/ n_bytes\=\w+\,//g' | sed 's/^ //g'" > ovs/current/$a.out
done;
	

