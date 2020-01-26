#!/bin/bash/

if [ -z "$1" ]; then   
        echo "Require subdomain."
        echo "Only default/under construction or dead page."
        echo "Error json = 404 bad request."
else
        echo $1 | gau -subs | concurl -c 20 -- -s -L -o /dev/null -k -w '%{http_code},%{size_download}'
fi
#credits jadix
