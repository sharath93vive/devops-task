#!/bin/bash
docker ps -a -q --filter="name=devops-task" | wc -l 
if [ $? -eq 0 ]; then
	echo "Stoppping and deleting previous container " $(docker ps -a -q --filter="name=devops-task") \
	docker rm $(docker stop $(docker ps -a -q --filter="name=devops-task")) \
else
	echo "No previous container running" \
    fi