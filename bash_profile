nmap(){
nmap -sV -T3 -Pn -p2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,7447,7080,8880,8983,5673,7443,19000,19080 $1
}

fd(){
findomain -t $1
}

fuf(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/dicc.txt -mc 200,301,302 -t 50
}

fufapi(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/apiwords.txt -mc 200 -t 50
}

arjun(){
cd ~/tools/Arjun
python3 arjun.py -u $1
cd -
}

am(){
amass enum --passive -d $1 -json $1.json
jq .name $1.json | sed "s/\"//g"| httprobe -c 60 | tee -a $1-domains.txt
}

sqlmap(){
sqlmap -u $1 
}

ipinfo(){
curl ipinfo.io/$1
}

s3ls(){
aws s3 ls s3://$1
}

s3cp(){
aws s3 cp $2 s3://$1 
}

crtsh(){
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}

certprobe(){
curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe | tee -a ./all.txt
}

certspotter(){ 
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1
}

certnmap(){
curl https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1  | nmap -T5 -Pn -sS -i - -$
}

mscan(){
sudo masscan -p80,443,8020,50070,50470,19890,19888,8088,8090,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,10000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080 --rate=100000 --open -iL $1 --banners -oG famous_ports.txt
}

mscanall(){
sudo masscan -p0-65535 --rate=100000 --open -iL $1 --banners -oG all_ports.txt
}

crtshdirsearch(){
curl -s https://crt.sh/?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe -c 50 | grep https | xargs -n1 -I{} python3 ~/tools/dirsearch/dirsearch.py -u {} -e $2 -t 50 -b 
}

crawl(){
echo $1 | hakrawler -depth 3 -plain
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,404,400,429 -t 200
cd -
}

crtndstry(){
./tools/crtndstry/crtndstry $1
}

thewadl(){
curl -s $1 | grep path | sed -n "s/.*resource path=\"\(.*\)\".*/\1/p" | tee -a ~/tools/dirsearch/db/yahooapi.txt
}

dirapi(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,429,404,400 -t 200 -w db/apiwords.txt
cd -
}

fuffiles(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-files.txt -mc 200,301,302 -t 50
}

fufdir(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-directories.txt -mc 200,301,302,403 -t 70
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,502,404,400,429 -t 200
cd -
}

ncx(){
nc -l -n -vv -p $1 -k
}

digit(){
dig @8.8.8.8 $1 CNAME
}

wordlist(){
cd ~/tools/dirsearch/db
}

fufextension(){
ffuf -u $1/FUZZ -mc 200,301,302,403,401 -t 150 -w ~/tools/dirsearch/db/ffuf_extension.txt -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,sql,json,xml,log
}

fufthis(){
ffuf -u $1/FUZZ -mc 200,301,302,403,401 -t 150 -w $(pwd)/wordlist.txt -e php,asp,aspx,jsp,txt,conf,config,bak,backup,old,db,sql,json,xml,log
}
