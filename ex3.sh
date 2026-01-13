#!/bin/bash

cat /etc/hosts | while read ip nume r; do
	if [[ $ip == '#' ]] ; then
		exit 0
	fi
	[[ -z $nume ]] && continue
	nsip=$(nslookup $nume 1.1.1.1 | awk '/^Address: / {print $2}' | head -1)
	
	if [[ $ip != $nsip && $nume != "localhost" && $nume != "ubuntu" ]] ; then
		echo "Bogus IP for $nume in /etc/hosts!"
	fi
	
done
