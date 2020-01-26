#!/bin/bash/
historysite(){
        curl --silent https://securitytrails.com/domain/$1/history/a |  pup -i 4 'tr[class=data-row] div text{}' | grep '\S'
}
