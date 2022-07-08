
version="1.0"								## Version Year.Day
updatedate="July 8,2022"					## The date of the last update
example_domain="nyakko.me" 				## Example domain
sleeptime=6									## Delay between queries, in seconds
domain=$1 									## Get the domain
browser='Mozilla'	## Browser information for curl
gsite="site:$domain" 						## Google Site

## Login pages
lpadmin="inurl:admin"
lplogin="inurl:login"
lpadminlogin="inurl:adminlogin"
lpcplogin="inurl:cplogin"
lpweblogin="inurl:weblogin"
lpquicklogin="inurl:quicklogin"
lpwp1="inurl:wp-admin"
lpwp2="inurl:wp-login"
lpportal="inurl:portal"
lpuserportal="inurl:userportal"
lploginpanel="inurl:loginpanel"
lpmemberlogin="inurl:memberlogin"
lpremote="inurl:remote"
lpdashboard="inurl:dashboard"
lpauth="inurl:auth"
lpexc="inurl:exchange"
lpfp="inurl:ForgotPassword"
lptest="inurl:test"
loginpagearray=($lpadmin $lplogin $lpadminlogin $lpcplogin $lpweblogin $lpquicklogin $lpwp1 $lpwp2 $lpportal $lpuserportal $lploginpanel $memberlogin $lpremote $lpdashboard $lpauth $lpexc $lpfp $lptest)

## Filetypes
ftdoc="filetype:doc"						## Filetype DOC (MsWord 97-2003)
ftdocx="filetype:docx"						## Filetype DOCX (MsWord 2007+)
ftxls="filetype:xls"						## Filetype XLS (MsExcel 97-2003)
ftxlsx="filetype:xlsx"						## Filetype XLSX (MsExcel 2007+)
ftppt="filetype:ppt"						## Filetype PPT (MsPowerPoint 97-2003)
ftpptx="filetype:pptx"						## Filetype PPTX (MsPowerPoint 2007+)
ftmdb="filetype:mdb"						## Filetype MDB (Ms Access)
ftpdf="filetype:pdf"						## Filetype PDF
ftsql="filetype:sql"						## Filetype SQL
fttxt="filetype:txt"						## Filetype TXT
ftrtf="filetype:rtf"						## Filetype RTF
ftcsv="filetype:csv"						## Filetype CSV
ftxml="filetype:xml"						## Filetype XML
ftconf="filetype:conf"						## Filetype CONF
ftdat="filetype:dat"						## Filetype DAT
ftini="filetype:ini"						## Filetype INI
ftlog="filetype:log"						## Filetype LOG
ftidrsa="index%20of:id_rsa%20id_rsa.pub"	## File ID_RSA
filetypesarray=($ftdoc $ftdocx $ftxls $ftxlsx $ftppt $ftpptx $ftmdb $ftpdf $ftsql $fttxt $ftrtf $ftcsv $ftxml $ftconf $ftdat $ftini $ftlog $ftidrsa)

## Directory traversal
dtparent='intitle:%22index%20of%22%20%22parent%20directory%22' 	## Common traversal
dtdcim='intitle:%22index%20of%22%20%22DCIM%22' 					## Photo
dtftp='intitle:%22index%20of%22%20%22ftp%22' 					## FTP
dtbackup='intitle:%22index%20of%22%20%22backup%22'				## BackUp
dtmail='intitle:%22index%20of%22%20%22mail%22'					## Mail
dtpassword='intitle:%22index%20of%22%20%22password%22'			## Password
dtpub='intitle:%22index%20of%22%20%22pub%22'					## Pub
dirtravarray=($dtparent $dtdcim $dtftp $dtbackup $dtmail $dtpassword $dtpub)

# Header
echo -e "\n\e[00;33m#########################################################\e[00m"
echo -e "\e[00;33m#                                                       #\e[00m" 
echo -e "\e[00;33m#\e[00m" "\e[01;32m               Fast Google Dorks Scan                \e[00m" "\e[00;33m#\e[00m"
echo -e "\e[00;33m#                                                       #\e[00m" 
echo -e "\e[00;33m#########################################################\e[00m"
echo -e ""
echo -e "\e[00;33m# https://www.facebook.com/nyakko.neko/ | @NyakkoNeko\e[00m"
echo -e "\e[00;33m# Version:                 \e[00m" "\e[01;31m$version\e[00m"

# Check domain
	if [ -z "$domain" ] 
	then
		echo -e "\e[00;33m# Domain Ví Dụ:\e[00m" "\e[01;31m$0 $example_domain \e[00m\n"
		exit
	else
			echo -e "\e[00;33m# Nhận thông tin của:   \e[00m" "\e[01;31m$domain\e[00m"
			echo -e "\e[00;33m# Độ trễ giữa các yêu cầu:   \e[00m" "\e[01;31m$sleeptime\e[00m" "\e[00;33msec\e[00m\n"
	fi


function Query {
		result="";
		for start in `seq 0 10 40`; 
			do
				query=$(echo; curl -sS -b "CONSENT=YES+srp.gws-20211028-0-RC2.es+FX+330" -A $browser "https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e")

				checkban=$(echo $query | grep -io "https://www.google.com/sorry/index")
				if [ "$checkban" == "https://www.google.com/sorry/index" ]
				then 
					echo -e "Google đã chặn vì gửi quá nhiều yêu cầu. Bạn có thể khắc phục việc này bằng cách sử dụng proxy hoặc fake IP nhé."; 
					exit;
				fi
				
				checkdata=$(echo $query | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*$domain/[a-zA-Z0-9./?=_~-]*")
				if [ -z "$checkdata" ]
					then
						sleep $sleeptime; 
						break; 
					else
						result+="$checkdata ";
						sleep $sleeptime; 
				fi
			done


		if [ -z "$result" ] 
			then
				echo -e "\e[00;33m[\e[00m\e[01;31m-\e[00m\e[00;33m]\e[00m Ko có kết quả"
			else
				IFS=$'\n' sorted=($(sort -u <<<"${result[@]}" | tr " " "\n")) 
				echo -e " "
				for each in "${sorted[@]}"; do echo -e "     \e[00;33m[\e[00m\e[01;32m+\e[00m\e[00;33m]\e[00m $each"; done
		fi


		unset Truy vấn kiểm tra dữ liệu kiểm tra dữ liệu kiểm tra kết quả được IFS sắp xếp
}

function PrintTheResults {
	for dirtrav in $@; 
		do echo -en "\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Đang Check $(echo $dirtrav | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]' | sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b") "\t" 
		Query $dirtrav 
	done
echo " "
}

echo -e "\e[01;32mChecking Login Page:\e[00m"; PrintTheResults "${loginpagearray[@]}";
echo -e "\e[01;32mChecking specific files:\e[00m"; PrintTheResults "${filetypesarray[@]}";
echo -e "\e[01;32mChecking path traversal:\e[00m"; PrintTheResults "${dirtravarray[@]}";
