#!/bin/sh
tcpdump -l --immediate-mode -ni any 'ip and port not 22 and host not localhost' 2>&1 | gawk '
/[0-9]+\./ {
        source_ip = $3
        source_ip = gensub("^([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+).*", "\\1", "g", source_ip)
        dest_ip = $5
        dest_ip = gensub(":", "", "g", dest_ip)
        dest_ip = gensub("^([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+).*", "\\1", "g", dest_ip)
        printf("%s %s 1\n", source_ip, dest_ip)
}'

