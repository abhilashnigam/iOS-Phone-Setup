#!/bin/bash
CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"
CROSS_MARK="\033[0;31m\xE2\x9C\x98\033[0m"
blu=`tput setaf 63`
bold=`tput bold`
red=`tput setaf 1`
green=`tput setaf 46`
ylw=`tput setaf 11`
reset=`tput sgr0`
echo ${blu}${bold}
echo " _______________________________________"
echo "< iOS Phone Setup                       >"
echo "<                  - Abhilash Nigam >"
echo " ---------------------------------------"
echo " \\"
echo "  \\"
echo "    .::."
echo "    _::_"
echo "  _/____\\_"
echo "  \      /"
echo "   \____/"
echo "   (____)"
echo "    |  |"
echo "    |__|"
echo "   /    \\"
echo "  (______)"
echo " (________)"
echo " /________\\"
echo ${reset}
display()
{
    echo -e "\n\e[4m\e[0m"
    echo -e "\n\r##############################################################\n" 
    echo -e "\n\e[4m$1\e[0m"
    echo -e "##############################################################\n"
}

installStatus() {
    if [ $? = "0" ]; then
        echo -e "${CHECK_MARK} $1 Installed"
    else
        echo -e "${CROSS_MARK} Error installing $1"
    fi
}

installPackage() {
        apt install -y $2 --allow-unauthenticated > /tmp/a 2>/dev/null
        instStat=$(installStatus $1)
        echo $instStat
}

if [ `whoami` != 'root' ]
  then
    echo "You must be root to do this."
    exit 1
fi

read -r -p  "${red}${bold}Do you want to Install Burp Suite Mobile Assistant [Y]es/[n]o: ${green}" ans
if [ $ans == "Y" ] || [ $ans == "y" ];
then
    read -r -p "${red}${bold}Enter the Burp Suite Proxy Server IP: ${green}" serverIP
    read -r -p "${red}${bold}Enter the Burp Suite Proxy Server Port: ${green}" serverPort
    echo ${reset}
    echo "deb http://$serverIP:$serverPort/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
else
    echo ${reset}

fi

dispHeader=$(display "Replacing Cydia Sources")
echo $dispHeader
sleep 3
mv /var/mobile/Library/Caches/com.saurik.Cydia/sources.list /var/mobile/Library/Caches/com.saurik.Cydia/sources.list.bak

echo "deb https://apt.bingner.com/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb http://apt.thebigboss.org/repofiles/cydia/ stable main" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://cydia.akemi.ai/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb http://getdelta.co/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://abhilashnigam.github.io/iDrill/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb http://rpetri.ch/repo/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb http://apt.modmyi.com/ stable main" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://repo.dynastic.co/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://repo.chariz.com/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://ryleyangus.com/repo/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb https://build.frida.re/ ./" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
echo "deb http://cydia.zodttd.com/repo/cydia/ stable main" | tee -a /var/mobile/Library/Caches/com.saurik.Cydia/sources.list

dispHeader=$(display "Updating Repository")
echo $dispHeader
apt update > /tmp/a 2>/dev/null
if [ $? = "0" ]; then
    echo -e "${CHECK_MARK} Repository Updated"
else
    echo -e "${CROSS_MARK} Error Updating Repository"
    exit 1
fi

dispHeader=$(display "Installing Packages")
echo $dispHeader

insPack=$(installPackage "Flame" "com.aditkamath.flame")
echo $insPack

if [ $(uname -p) = "arm64" ]; then
        insPack=$(installPackage "Frida_Server_x64" "re.frida.server64")
        echo $insPack
else
        insPack=$(installPackage "Frida_Server_x32" "re.frida.server32")
        echo $insPack
fi

insPack=$(installPackage "Flex_3_Beta" "com.johncoates.flex3")
echo $insPack

insPack=$(installPackage "ADV_Cmd" "adv-cmds")
echo $insPack

insPack=$(installPackage "IPA_Installer" "com.slugrail.ipainstaller")
echo $insPack

insPack=$(installPackage "IPA_Installer_Command_Line" "com.autopear.installipa")
echo $insPack

insPack=$(installPackage "App_Sync_Unified" "net.angelxwind.appsyncunified")
echo $insPack

insPack=$(installPackage "Filza_File_Manager" "com.tigisoftware.filza")
echo $insPack

insPack=$(installPackage "Plutil" "com.bingner.plutil")
echo $insPack

insPack=$(installPackage "Gawk" "gawk")
echo $insPack

insPack=$(installPackage "Sqlite3 DBMS" "sqlite3")
echo $insPack

insPack=$(installPackage "Darwin_CC_Tools" "org.coolstar.cctools")
echo $insPack

insPack=$(installPackage "WGET" "wget")
echo $insPack

insPack=$(installPackage "iDrill" "idrill")
echo $insPack

insPack=$(installPackage "LibertyLite" "com.ryleyangus.libertylite")
echo $insPack

wget https://github.com/nabla-c0d3/ssl-kill-switch2/releases/download/0.14/com.nablac0d3.sslkillswitch2_0.14.deb -O sslkillswitch.deb -q
dpkg -i sslkillswitch.deb > /tmp/a 2>/dev/null
rm sslkillswitch.deb
instStat=$(installStatus "SSL Kill Switch 2")
echo $instStat

wget https://github.com/iSECPartners/Introspy-iOS/releases/download/ios-tracer-v0.4/com.isecpartners.introspy-v0.4-iOS_7.deb -O introspy.deb -q
dpkg -i introspy.deb > /tmp/a 2>/dev/null
rm introspy.deb
instStat=$(installStatus "Introspy")
echo $instStat


if [ $ans == "Y" ] || [ $ans == "y" ]; 
then
    insPack=$(installPackage "Burp_Suite_Mobile_Assistant" "mobileassistant")
    echo $insPack
else
        echo -e "${CROSS_MARK} Skipped Burp Suite Mobile Assistant Installation"

fi

dispHeader=$(display "Restoring Cydia Sources Back")
echo $dispHeader
sleep 3
mv /var/mobile/Library/Caches/com.saurik.Cydia/sources.list.bak /var/mobile/Library/Caches/com.saurik.Cydia/sources.list
rm /tmp/a

killall SpringBoard
killall -HUP SpringBoard
