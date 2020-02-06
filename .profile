gitpoints(){
python3 /home/krossom/tools/github-search/github-endpoints.py -d $1 -s -r -t 91114fa0b409de2cb24719a929c582e7b01d239d
}

gitsubs(){
python3 /home/krossom/tools/github-subdomains.py -d $1 -s  -t 91114fa0b409de2cb24719a929c582e7b01d239d
}

pathbrute(){
/home/krossom/tools/pathbrute/pathBrute -s default -u $1 -i -v -n 4
}

pathbruteU(){
/home/krossom/tools/pathbrute/pathBrute -s default -U $1 -i -v -n 4
}

lazy(){
bash /home/krossom/tools/LazyRecon/LazyRecon.sh $1
}
massdnsAAAA(){
massdns -r /home/krossom/tools/massdns/lists/resolvers.txt -t AAAA $1 -o $2
}
corscanner(){
python /home/krossom/tools/CORScanner/cors_scan.py $1 $2
}
domtakeover(){
subjack -w $1 -t 100 -timeout 30 -o final-takeover-$1.txt -ssl
}
phpinfogetall(){
$var=$1
if [ -z "$1" ]; then
        echo "Ingresa rangos de ip en regex: ejemplo 98.13{6..9}.{0..255}.{0..255}"
else
        for ipa in $var; do
        wget -t 1 -T 3 http://$ipa/phpinfo.php; done
fi
}


#historysite(){
#if [ -z "$1" ]; then
#       echo "domain/subdomain required. (historysite domain.tdl)"
#else
#        curl --silent https://securitytrails.com/domain/$1/history/a | pup -i 4 'tr[class=data-row] div text{}' |grep  -v -E "(173.245.48.[0-9]{1,3}|103.[0-9]{1,2}.[0-9]{1,3}.[0-9]{1,3}|141.101.64.[0-9]{1,3}|108.162.192.[0-9]{1,3}|190.93.240.[0-9]{1,3}|188.114.96.[0-9]{1,3}|197.234.240.[0-9]{1,3}|198.41.128.[0-9]{1,3}|162.158.[0-9]{1,3}.[0-9]{1,3}|172.64.[0-9]{1,3}.[0-9]{1,3}|131.0.[0-9]{1,3}.[0-9]{1,3}|104.[0-9]{1,2}.[0-9]{1,3}.[0-9]{1,3}|37.48.[0-9]{1,3}.[0-9]{1,3})"
#fi
#}

historysite(){
        curl --silent https://securitytrails.com/domain/$1/history/a |  pup -i 4 'tr[class=data-row] div text{}' | grep '\S'
}


deadpage(){

if [ -z "$1" ]; then
        echo "+-----------------INFO----------------------+"
        echo "Require subdomain."
        echo "Only default/under construction or dead page."
        echo "Error json = 404 bad request. (no hay nada)"
        echo "+-------------------------------------------+"
else
        echo $1 | gau -subs | concurl -c 20 -- -s -L -o /dev/null -k -w '%{http_code},%{size_download}'
fi
}

sudomain(){
am $1 && findomain -t $1 -u $1-findomain.txt && altdns -i $1-domains.txt -o data_output -w ~/wordlists/subdomain/subdomains-100.txt -r -s results_output.txt
}

scanaws(){
go run /home/krossom/tools/AWS-Scanner/main.go $1
}

takeover(){
bash /home/krossom/tools/TakeOver-v1/takeover.sh
}
turbolist3r(){
python3 ~/tools/Turbolist3r/turbolist3r.py  -d $1 -a --saverdns analisis-$1.txt
}

#esencialess
actualizar(){
$1 apt-get -y update && sudo apt-get -y upgrade
}

lfd(){
sudo python3 ~/tools/LinkFinder/linkfinder.py -i $1 -d
}

lfdo(){
sudo python3 ~/tools/LinkFinder/linkfinder.py -i $1  -o cli
}

profile(){
$1 nano ~/.profile
}

sprofile(){
source ~/.profile
}

githubsubdomain(){
sudo python3 ~/tools/github-subdomains.py -t  35ea7f04bd271c2f8323864640ce69218a8bc979 -d $1
}

#simple http server
simpleserver(){
python -m SimpleHTTPServer 8080
}
#----- AWS -------

s3ls(){
aws s3 ls s3://$1
}

s3cp(){
aws s3 cp $2 s3://$1
}

#---- Content discovery ---- cambiar esto!
thewadl(){ #this grabs endpoints from a application.wadl and puts them in yahooapi.txt
curl  $1 | grep path | sed -n "s/.*resource path=\"\(.*\)\".*/\1/p" | tee -a ~/tools/dirsearch/db/$1-wadl.txt
}

#----- recon -----
crtndstry(){
~/tools/crtndstry/crtndstry.sh $1
}

am(){ #-- runs amass passively and saves to json
amass enum --passive -d $1 -json $1.json
jq .name $1.json | sed "s/\"//g"| httprobe -c 60 | tee -a $1-domains.txt
}

certprobe(){ #runs httprobe on all the hosts from certspotter
curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe | tee -a ./all.txt
}

mscan(){ #runs masscan
sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,744 $1
}

crtp(){
 curl "https://api.certspotter.com/v1/issuances?domain="$1"&include_subdomains=true&expand=dns_names&expand=issuer&expand=cert" | grep $1

}

certspotter(){
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1
} #h/t Michiel Prins

crtsh(){
#curl -s https://crt.sh/?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}

certnmap(){
curl https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1  | nmap -T5 -Pn -sS -i -

} #h/t Jobert Abma

ipinfo(){
curl http://ipinfo.io/$1
}


#------ Tools ------
dirsearch(){ #runs dirsearch and takes host and extension as arguments
python3 ~/tools/dirsearch/dirsearch.py -u $1 -e $2 -w $3 -x 502 -t 50 -b
}

sqlmap(){
python ~/tools/sqlmap*/sqlmap.py -u $1
}

ncx(){
nc -l -n -vv -p $1 -k
}

crtshdirsearch(){ #gets all domains from crtsh, runs httprobe and then dir bruteforcers
curl -s https://crt.sh/?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe -c 50 | grep https | xargs -n1 -I{} python3 ~/tools/dirsearch/dirsearch.py -u {} -e $2 -t 50 -b
}
