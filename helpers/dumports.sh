#!/bin/bash

rm -rf ports/old
mv ports/current ports/old
mkdir ports/current

for a in `oc get nodes | awk '{print $1}' | grep -v NAME`; do
	container_id=`ansible $a -m shell -a 'docker ps | grep ovs | grep bash | cut -d " " -f 1' 2> /dev/null| grep -v SUCCESS`
        ansible $a -m shell -a "docker exec -i $container_id ovs-ofctl -O OpenFlow13 dump-ports-desc br0" > ports/current/$a.out
done;
	

