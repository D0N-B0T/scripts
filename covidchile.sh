 #!/bin/bash
 
 while :
  do
    printf "Numero de infectados segun MINSAL: "
    curl -s https://www.minsal.cl/nuevo-coronavirus-2019-ncov/casos-confirmados-en-chile-covid-19/ | pup strong | tail -10 | grep -Eo '[0-9]{1,4}' && echo ""
  done
