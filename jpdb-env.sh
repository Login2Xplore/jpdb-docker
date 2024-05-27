# check-port_create-folder_download-and-execute_jpdb-setup
# -------------------------------------------------------------------
# $1 is port and create variable $2 will be 'jpdb'+$1
# if $2 exist then error "JsonPowerDB folder exists; seems its already running" and exit
# if $1 is in use then error "$1 port is in occupied; please use different port" and exit

# The folder is created with name 'jpdb' + port i.e. 'jpdb5577'
folderName="jpdb${1}"
echo "${folderName}"

cd ../cgi-bin
mkdir $folderName
cd $folderName

# Downloading jpdb-setup.sh file
if [ -f "jpdb-setup.sh" ]
then
 echo "jpdb-setup.sh file exists"
else
 wget https://raw.githubusercontent.com/Login2Xplore/jpdb-docker/main/jpdb-setup.sh
 chmod 755 jpdb-setup.sh
fi

# login2explore/jpdb032-openjdk8-2gb:1 is the docker-image-name and :1 is the docker-image-version
# The following line executes another script i.e. jpdb-setup.sh

#./jpdb-setup.sh login2explore/jpdb032-openjdk8-1gb:1 data $1 700m 1400m

#./jpdb-setup.sh login2explore/jpdb032-openjdk8-2gb:1 data $1 1600m 2800m

#./jpdb-setup.sh login2explore/jpdb032-openjdk8-4gb:1 data $1 3600m 6400m

#./jpdb-setup.sh login2explore/jpdb032-openjdk8-8gb:1 data $1 7800m 14400m

#./jpdb-setup.sh login2explore/jpdb032-openjdk8-16gb:1 data $1 16000m 30000m

#echo "$2"
#echo "$3"

sizeOfImage=$2
imageName=$3

if [ "$sizeOfImage" -eq 1 ]; then
    minSwap=700m
    maxSwap=1400m
elif [ "$sizeOfImage" -eq 2 ]; then
    minSwap=1600m
    maxSwap=2800m
elif [ "$sizeOfImage" -eq 4 ]; then
    minSwap=3600m
    maxSwap=6400m
elif [ "$sizeOfImage" -eq 8 ]; then
    minSwap=7800m
    maxSwap=14400m
elif [ "$sizeOfImage" -eq 16 ]; then
    minSwap=16000m
    maxSwap=30000m
else
    echo "Error: Unsupported image size. Supported sizes are 1GB, 2GB, 4GB, 8GB, 16GB."
    exit 1
fi

#echo "$minSwap"
#echo "$maxSwap"

# TODO we can remove the "data" folder name as we can make it hard coded.
./jpdb-setup.sh $1 $imageName $minSwap $maxSwap
