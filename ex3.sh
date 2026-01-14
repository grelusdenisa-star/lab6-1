#!/bin/bash

check_id() {
	local host=$1
	local ip=$2
	local dns=$3
	if [[ $ip == '#' ]] ; then
		exit 0
	fi
	[[ -z $host ]] && return 1
	nsip=$(nslookup $host $dns | awk '/^Address: / {print $2}' | head -1)
	
	if [[ $ip != $nsip && $host != "localhost" && $host != "ubuntu" ]] ; then
		echo "Bogus IP for $host in /etc/hosts!"
	fi
}

dns_server="1.1.1.1"

cat /etc/hosts | while read ip nume r; do
	check_id "$nume" "$ip" "$dns_server"
	
done
echo "ceva"
