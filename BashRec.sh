#!/bin/bash

##############################################################################
# This is just a basic recon script 
# Find domains using Findomain
# Probe using Httprobe to find working http and https of any domain list
# Take screenshots of the list of domains using Aquatone
# Nuclei to find low hanging fruits 
# Waybackurls to get the old urls of the domains
# Finally Dalfox to find Xss and other Related vulnerabilities
##############################################################################


red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

#Includes the templates options to choose for while running Nuclei in Basic Reconnaisance mode 

Nuclei(){


if [ -f "$HOME/$domain/http_$domain.txt" ]; then

echo "${yellow}Enter the template choice: ${reset}"
options=("All Templates" "Cves" "Default-Credentials" "Dns" "Files" "Fuzzing" "Generic-Detections" "Panels" "Security-Misconfiguration" "Subdomain-Takeover" "Technologies" "Tokens" "Vulnerabilities" "Workflows" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "All Templates")            
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/ -o $HOME/$domain/Nuclei_$domain.txt 
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Cves")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/cves -o $HOME/$domain/NucleiCVES_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Default-Credentials")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/default-credentials -o $HOME/$domain/NucleiDefCred_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Dns")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/dns -o $HOME/$domain/NucleiDNS_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Files")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/files -o $HOME/$domain/NucleiFiles_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Fuzzing")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/fuzzing -o $HOME/$domain/NucleiFuzzing_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Generic-Detections")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/generic-detections -o $HOME/$domain/NucleiGeneric_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Panels")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/panels -o $HOME/$domain/NucleiPanels_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Security-Misconfiguration")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/security-misconfiguration -o $HOME/$domain/NucleiSecMis_$domain.txt 
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Subdomain-Takeover")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/subdomain-takeover -o $HOME/$domain/NucleiSubdomainTakeover_$domain.txt  
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Technologies")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/technologies -o $HOME/$domain/NucleiTechnologies_$domain.txt  
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Tokens")
           nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/tokens -o $HOME/$domain/NucleiTokens_$domain.txt
           echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Vulnerabilities")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/vulnerabilities -o $HOME/$domain/NucleiVulnerabilities_$domain.txt
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Workflows")
            nuclei -l $HOME/$domain/http_$domain.txt -t $HOME/nuclei-templates/workflows -o $HOME/$domain/NucleiWorkflows_$domain.txt 
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Quit")
            break
            ;;            
        *) echo "${red}Invalid option $REPLY ${reset}"
        echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}";;
    esac
done

   else 
    nucleiSingle 
    break
   fi
}

#Includes the installation of findomain,runs if the tool is not installed
findomainInstall(){
  git clone https://github.com/Edu4rdSHL/findomain.git
  sudo apt-get install cargo
  cd findomain
  cargo build --release
  sudo cp target/release/findomain /usr/bin/
}

#Includes the installation of httprobe,runs if the tool is not installed
httprobeInstall(){
  sudo apt-get install golang
  clear
  go get -u github.com/tomnomnom/httprobe
  go install github.com/tomnomnom/httprobe
  sudo mv $HOME/go/bin/httprobe /usr/bin/
  clear
}

#Includes the installation of nuclei,runs if the tool is not installed
nucleiInstall(){
  git clone https://github.com/projectdiscovery/nuclei.git
  cd nuclei/v2/cmd/nuclei/
  go build
  sudo mv nuclei /usr/bin/
}

#Includes the installation of waybackurls,runs if the tool is not installed
waybackUrlInstall(){
  go get github.com/tomnomnom/waybackurls
  go install github.com/tomnomnom/waybackurls
  sudo mv $HOME/go/bin/waybackurls /usr/bin/
}

#Includes the installation of dalfox,runs if the tool is not installed
dalfoxInstall(){
        go get github.com/Emoe/kxss
        go install github.com/Emoe/kxss
        sudo mv $HOME/go/bin/kxss /usr/bin/
        go get -u github.com/hahwul/dalfox
        go install -u github.com/hahwul/dalfox
        sudo mv $HOME/go/bin/dalfox /usr/bin/
}


findomainRun(){

if which findomain >/dev/null; then
 
echo
echo -e " ---------------------------- "
echo
echo -e " \033[34;7;5;107m     Running Findomain      \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
   findomainSingle
else
    echo "${green}Findomain not installed ${reset}"
    read -p "${blue}Do you want to install Findomain (y/Y/n)? ${reset}" CONT
    CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m     Installing Findomain      \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
  findomainInstall
echo
echo -e " ---------------------------- "
echo
echo -e " \033[34;7;5;107m      Running Findomain       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
findomainSingle
else
  break;
fi
fi
echo
echo
}

#Checks whether there is a directory is present for that particular domain
findomainSingle(){
if [ -d "~/$domain" ]; then
  findomain -t $domain $f | tee $HOME/$domain/$domain.txt
  else
    mkdir -p ~/$domain
   findomain -t $domain $f | tee $HOME/$domain/$domain.txt
fi
}

findomainFlag(){
read -p "${green} Enter additional flags along with the options: ${reset}" f
  if [[ "$f" = *"-t"* ]];then
  echo "${magenta}Target flag is provided by default ${reset}"
  findomainFlag
  else
  findomainSingle
  fi
}
httprobeRun(){


if which httprobe >/dev/null; then
 
echo
echo -e " ---------------------------- "
echo
echo -e " \033[32;7;5;107m     Running Httprobe       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
   if [ -f "$HOME/$domain/$domain.txt" ]; then
    cat $HOME/$domain/$domain.txt | httprobe | tee $HOME/$domain/http_$domain.txt
   else 
    httprobeSingle
   fi
else
    echo "${green}Httprobe not installed ${reset}"
    read -p "${blue}Do you want to install Httprobe (y/n)? ${reset}" CONT
    CONT=${CONT,,}
if [ "$CONT" = "y" ]; then

echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m     Installing Httprobe       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
  httprobeInstall
echo
echo -e " ---------------------------- "
echo
echo -e " \033[32;7;5;107m       Running Httprobe       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
 cat $HOME/$domain/$domain.txt | httprobe | tee $HOME/$domain/http_$domain.txt
else
  break;
fi
fi       

echo
echo
}

#Runs when the user need to enter the location of the domain to be checked
httprobeSingle(){

read -e -p "${green}Enter the correct path of the file to be executed: ${reset}" loc
    while true; do
    if [ -d "$loc" ]; then
    echo "${magenta} $loc is a directory... ${reset}"
    read -e -p "${green}Please enter the correct path of the file to be executed: ${reset}" loc
    sleep 1
    elif [ -f "$loc" ]; then
        cat "$loc" | httprobe $ht | tee "$loc"_http.txt
        echo " "
        echo " "
        break
        else
        echo "${red} $loc Doesn't Exist ${reset}"
        httprobeSingle  
    fi
done    
}
httprobeFlag(){
read -p "${green}Enter the additional flags with the options: ${reset}" ht
  httprobeSingle
}
aquatoneRun(){
echo
echo -e " ---------------------------- "
echo
echo -e " \033[35;7;5;107m     Running Aquatone       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
   if [ -f "$HOME/$domain/http_$domain.txt" ]; then
   mkdir -p $HOME/$domain/Aquatone_$domain
    cat $HOME/$domain/http_$domain.txt | aquatone -out $HOME/$domain/Aquatone_$domain
   else 
    aquatoneSingle
   fi

echo
echo
}

#Runs when the user need to enter the location of the domain to be checked
aquatoneSingle(){
read -e -p "${green}Enter the correct path of the file to be executed: ${reset}" loc
    while true; do
    if [ -d "$loc" ]; then
    echo "${magenta} $loc is a directory... ${reset}"
    read -e -p "${green}Please enter the correct path of the file to be executed: ${reset}" loc
    sleep 1
    elif [ -f "$loc" ]; then
        cat "$loc" | aquatone -out "$loc"_Aquatone $aq
        echo " "
        echo " "
        break
        else
        echo "${red} $loc Doesn't Exist ${reset}"
        aquatoneSingle
    fi
done    
}
aquatoneFlag(){

read -p "${green}Enter additional flags along with the options: ${reset}" aq
  if [[ "$aq" = *"-out"* ]];then
  echo "${magenta}Output flag is provided by default ${reset}"
  aquatoneFlag
  else
  aquatoneSingle
  fi
  }
nucleiRun(){
if which nuclei >/dev/null; then
 
echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m      Running Nuclei       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
 nuclei -update-templates
 Nuclei
else
    echo "${green}Nuclei not installed ${reset}"
    read -p "${blue}Do you want to install Nuclei (y/n)? ${reset}" CONT
    CONT=${CONT,,}
if [ "$CONT" = "y" ]; then

echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m      Installing Nuclei      \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
  nucleiInstall
echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m     Running Nuclei         \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
 Nuclei
else
  break;
fi
fi       

echo
echo
}

#Runs when the user need to enter the location of the domain to be checked 
#Includes the templates options to choose for while running Nuclei 
nucleiSingle(){
 read -e -p "${blue}Enter the correct path of the file to be tested: ${reset}"  loc
    while true; do
    if [ -d "$loc" ]; then
    echo "${magenta} $loc is a directory... ${reset}"
    read -e -p "${blue}Please enter the correct path of the file to be tested:${reset}" loc
    sleep 1
   elif [ -f "$loc" ]; then
    echo " "
    echo "${yellow}Enter the template choice: ${reset}"
options=("All Templates" "Cves" "Default-Credentials" "Dns" "Files" "Fuzzing" "Generic-Detections" "Panels" "Security-Misconfiguration" "Subdomain-Takeover" "Technologies" "Tokens" "Vulnerabilities" "Workflows" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "All Templates")            
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/ -o "$loc"_Nuclei.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Cves")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/cves/ -o "$loc"_NucleiCVES.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Default-Credentials")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/default-credentials/ -o "$loc"_NucleiDefCred.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Dns")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/dns/ -o "$loc"_NucleiDNS.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Files")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/files/ -o "$loc"_NucleiFiles.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Fuzzing")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/fuzzing/ -o "$loc"_NucleiFuzzing.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Generic-Detections")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/generic-detections/ -o "$loc"_NucleiGeneric.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Panels")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/panels/ -o "$loc"_NucleiPanels.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Security-Misconfiguration")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/security-misconfiguration/ -o "$loc"_NucleiSecMis.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Subdomain-Takeover")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/subdomain-takeover/ -o "$loc"_NucleiSubdomainTakeover.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Technologies")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/technologies/ -o "$loc"_NucleiTechnologies.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
             "Tokens")
           nuclei -l "$loc" -t "$HOME"/nuclei-templates/tokens/ -o "$loc"_NucleiTokens.txt $nu
           echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Vulnerabilities")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/vulnerabilities/ -o "$loc"_NucleiVulnerabilities.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
            "Workflows")
            nuclei -l "$loc" -t "$HOME"/nuclei-templates/workflows/ -o "$loc"_NucleiWorkflows.txt $nu
            echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}"
            ;;
        "Quit")
            break
            ;;            
        *) echo "${red}Invalid option $REPLY ${reset}"
        echo "${yellow}Do you want to use another template? Press Enter to view templates or Enter 15 to Quit${reset}";;
    esac
done
else
echo "${red} $loc Doesn't Exist ${reset}"
nucleiSingle
fi
break
done 
}

nucleiFlag(){
read -p "${green}Enter additional flags along with the options: ${reset}" nu
  if [[ "$nu" = *"-l"* ]] || [[ "$nu" = *"-t"* ]] || [[ "$nu" = *"-o"* ]];then
  echo "${magenta}The flag is provided by default ${reset}"
  nucleiFlag
  else
  nucleiSingle
  fi
}
waybakurlRun(){
   
   if which waybackurls >/dev/null; then
waybackSingle
else
    echo "${yellow}Waybackurls not installed ${reset}"
    read -p "${blue}Do you want to install Waybackurls (y/n)? ${reset}" CONT
    CONT=${CONT,,}
  if [ "$CONT" = "y" ]; then
 
echo
echo -e " ---------------------------- "
echo
echo -e " \033[36;7;5;107m      Installing Waybackurls       \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
  waybackUrlInstall
 waybackSingle
else
  break;
  fi
   fi
echo
echo
}

#Checks whether there is a directory is present for that particular domain 
#Greps the output of wayback to avoid all unwanted url list
waybackSingle(){
echo
echo -e " ---------------------------- "
echo
echo -e " \033[93;7;5;107m      Running Waybackurls        \033[0m"
echo
echo -e " ---------------------------- "
tput ed
tput sgr0
echo
if [ -d "~/$domain" ]; then
 waybackurls $domain | tee $HOME/$domain/wayback_$domain.txt
 cat $HOME/$domain/wayback_$domain.txt | grep "=" |egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | tee $HOME/$domain/final_$domain.txt 
   else 
    mkdir -p ~/$domain
    waybackurls $domain | tee $HOME/$domain/wayback_$domain.txt
    cat $HOME/$domain/wayback_$domain.txt | grep "=" |egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | tee $HOME/$domain/final_$domain.txt 
fi

}
dalfoxRun(){

  if which kxss dalfox >/dev/null; then
   
   echo
   echo -e " ---------------------------- "
   echo
   echo -e " \033[94;7;5;107m      Running Dalfox       \033[0m"
   echo
   echo -e " ---------------------------- "
   tput ed
   tput sgr0
   echo
   if [ -f "$HOME/$domain/final_$domain.txt" ]; then
    cat $HOME/$domain/final_$domain.txt | kxss | sed 's/=.*/=/' | sed 's/URL: //' | dalfox pipe
   else         
    dalfoxSingle
   fi
    
  else
    echo "${yellow}Kxss or Dalfox not installed ${reset}"
    read -p "${blue}Do you want to install them (y/n)? ${reset}" CONT
    CONT=${CONT,,}
     if [ "$CONT" = "y" ]; then
     
     echo
     echo -e " ---------------------------- "
     echo
     echo -e " \033[36;7;5;107m     Installing Dalfox and kxss       \033[0m"
     echo
     echo -e " ---------------------------- "
     tput ed
     tput sgr0
     echo
         dalfoxInstall
        
        echo
        echo -e " ---------------------------- "
        echo
        echo -e " \033[94;7;5;107m Running Dalfox         \033[0m"
        echo
        echo -e " ---------------------------- "
        tput ed
        tput sgr0
        echo
        cat $HOME/$domain/final_$domain.txt | kxss | sed 's/=.*/=/' | sed 's/URL: //' | dalfox pipe 
     else
     break; 
     fi
  fi
echo
}

#Runs when the user need to enter the location of the domain to be checked
dalfoxSingle(){
read -e -p "${green}Enter the correct path of the file to be tested: ${reset}"  loc
    while true; do
    if [ -d "$loc" ]; then
    echo "${magenta} $loc is a directory... ${reset}"
    read -e -p "${red}Please enter the correct path of the file to be tested: ${reset}" loc
    sleep 1
    elif [ -f "$loc" ]; then
        cat "$loc" | kxss | sed 's/=.*/=/' | sed 's/URL: //' | dalfox pipe $df
        echo " "
        break
        else
        echo "${red} $loc Doesn't Exist ${reset}"
        dalfoxSingle
    fi
done    
}
dalfoxFlag(){
read -p "${green}Enter additional flags along with the options: ${reset}" df
  if [[ "$df" = *"pipe"* ]];then
  echo "${magenta} Pipe flag is provided by default ${reset}"
  dalfoxFlag
  else
  dalfoxSingle
  fi
}
basicRecon(){

echo "${red}Enter domain (Eg: example.com): ${reset}"
read domain
mkdir -p $HOME/$domain
findomainRun
read -p "${blue}Do you want to run Httprobe (y/n)?${reset}" CONT
CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
httprobeRun
fi
read -p "${blue}Do you want to run Aquatone (y/n)?${reset}" CONT
CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
aquatoneRun
fi
read -p "${blue}Do you want to run Nuclei (y/n)?${reset}" CONT
CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
nucleiRun
fi
read -p "${blue}Do you want to run Waybackurls (y/n)?${reset}" CONT
CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
waybakurlRun
fi
read -p "${blue}Do you want to run Dalfox(XSSFinder) (y/n)?${reset}" CONT
CONT=${CONT,,}
if [ "$CONT" = "y" ]; then
dalfoxRun
fi
echo "${green} Files successfully saved to $HOME/$domain ${reset}"
}

Reclogo(){
echo "${blue}


██████╗░░█████╗░░██████╗██╗░░██╗██████╗░███████╗░█████╗░
██╔══██╗██╔══██╗██╔════╝██║░░██║██╔══██╗██╔════╝██╔══██╗
██████╦╝███████║╚█████╗░███████║██████╔╝█████╗░░██║░░╚═╝
██╔══██╗██╔══██║░╚═══██╗██╔══██║██╔══██╗██╔══╝░░██║░░██╗
██████╦╝██║░░██║██████╔╝██║░░██║██║░░██║███████╗╚█████╔╝
╚═════╝░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░╚════╝░

${reset}"
} 
Reclogo
PS3="${yellow}Please enter your choice: ${reset}"
options=("Basic Reconnaisance" "Findomain" "Httprobe" "Aquatone" "Nuclei" "WaybackUrls" "Dalfox" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Basic Reconnaisance")
            basicRecon
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
        "Findomain")
            echo "${blue} Enter domain (Eg: example.com) ${reset}":
            read domain
            echo "${magenta}Press Enter to run with Default flag (-t) or type any additional flags below${reset}" 
            findomainFlag
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
        "Httprobe")
            echo "${magenta}Press Enter to run in default mode or type any additional flags below${reset}" 
            httprobeFlag
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
            "Aquatone")
            echo "${magenta}Press Enter to run with Output flag(-out) by default or type any additional flags below${reset}"
            aquatoneFlag
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
            "Nuclei")
            echo "${magenta}Press Enter to run with Flags(-n,-l,-o) by default or type any additional flags below${reset}" 
            nucleiFlag
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
             "WaybackUrls")
              echo "${blue}Enter domain (Eg: example.com)${reset}":
              read domain
            waybakurlRun
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
              "Dalfox")
               echo "${magenta}Press Enter to run with Pipe flag by default or type any additional flags below${reset}"
            dalfoxFlag
            echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
            echo " "
            ;;
        "Quit")
            break
            ;;
        *) echo "${red}Invalid option $REPLY${reset}"
        echo "${yellow}Press Enter to view options or Press 8 to quit:${reset}"
        echo " "
        ;;
    esac
done



