# check-port_create-folder_download-and-execute_jpdb-setup
# -------------------------------------------------------------------
# $1 is port and create variable $2 will be 'jpdb'+$1
# if $2 exist then error "JsonPowerDB folder exists; seems its already running" and exit
# if $1 is in use then error "$1 port is in occupied; please use different port" and exit

PORT_CHECK=$(sudo lsof -i -P -n | grep :$1)
n=${#PORT_CHECK}

#PORT CHECK, whether a particular port is open or not for use
if [ $n -ne 0 ]
then
 echo "Port is already in Use. Seems its already running."
 exit
else
 echo "Port is Open for Use"
fi

folderName="jpdb${1}"
echo "${folderName}"

cd /opt
sudo mkdir $folderName
cd $folderName

if [ -f "jpdb-setup.sh" ]
then
echo "jpdb-setup.sh file exists"
else
sudo wget https://raw.githubusercontent.com/Login2Xplore/jpdb-docker/main/jpdb-setup.sh
sudo chmod 755 jpdb-setup.sh
fi

# login2explore/jpdb032-openjdk8-2gb:1 is the docker-image-name and :1 is the docker-image-version
# The following line executes another script i.e. jpdb-setup.sh
./jpdb-setup.sh login2explore/jpdb032-openjdk8-2gb:1 data $1
