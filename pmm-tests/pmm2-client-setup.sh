#!/bin/bash

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
    echo ${temp##*|}
}

display_usage() { 
	echo "Please make sure to pass atleast pmm_server, mysql_server, mysql_user"
	echo "1) pmm_server    ------------------localhost:80"
	echo "2) mysql_server  ------------------localhost:3036"
	echo "3) mysql_user    ------------------root"
	echo "4) mysql_password------------------secret"
}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $# == "--help") ||  $# == "-h" ]] 
then 
	display_usage
	exit 0
fi
if [ "$#" -lt 3 ]; then
    display_usage
    exit 1;
fi

STR=$1
IFS=’:’ read -ra pmm_serer_with_port <<< "$STR" 
MSTR=$2
IFS=’:’ read -ra mysql_server_with_port <<< "$MSTR"
pmm_server=${pmm_serer_with_port[0]}
pmm_server_port=${pmm_serer_with_port[1]}
mysql_server=${mysql_server_with_port[0]}
mysql_server_port=${mysql_server_with_port[1]}
mysql_user=$3
mysql_password=$4

if [ -z "$mysql_server_port" ]
then
      mysql_server_port='3036'
fi

node_name=node$((1 + RANDOM % 100))
json=`curl -d '{"address": "'$pmm_server:$pmm_server_port'", "custom_labels": {"custom_label": "for_node"}, "node_name": "'$node_name'"}' http://${pmm_server}:${pmm_server_port}/v1/inventory/Nodes/AddGeneric`
prop='node_id'
node_id=`jsonval`

json=`curl -d '{"custom_labels": {"custom_label2": "for_pmm-agent"}, "node_id": "'$node_id'"}' http://${pmm_server}:${pmm_server_port}/v1/inventory/Agents/AddPMMAgent`
prop='agent_id'
agent_id=`jsonval`
echo $agent_id
echo $node_id

./pmm-agent --address=$pmm_server:443 --insecure-tls --id=$agent_id & > /dev/null 2>&1

sleep 10

service_name=mysql-$((1 + RANDOM % 100))
json=`curl -d '{"address": "'${mysql_server}'", "port": '${mysql_server_port}', "custom_labels": {"custom_label3": "for_service"}, "node_id": "'$node_id'", "service_name": "'$service_name'"}' \
 http://${pmm_server}:${pmm_server_port}/v1/inventory/Services/AddMySQL`
prop='service_id'
service_id=`jsonval`
echo $service_id

json=`curl -d '{"custom_labels": {"custom_label4": "for_exporter"}, "runs_on_node_id": "'$node_id'", "service_id": "'$service_id'", "username": "root", "'$mysql_user'": "'$mysql_password'"}' \
http://${pmm_server}:${pmm_server_port}/v1/inventory/Agents/AddMySQLdExporter`
prop='runs_on_node_id'
runs_on_node_id=`jsonval`
echo $runs_on_node_id