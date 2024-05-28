#!/bin/bash

# $1 - port
# $2 - image-ram-size
# $3 - ssl file 'ssl.jks' location with file-name

# Check if port number and image size are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <port_number> <image_size_in_gb> [<ssl_file_location>]"
    exit 1
fi

# Check if port is available or not.
PORT_CHECK=$(sudo lsof -i -P -n | grep :$1)
n=${#PORT_CHECK}

#PORT CHECK, whether a particular port is open or not for use
if [ $n -ne 0 ]
then
 echo "Port is already in use, please use different port."
 exit
else
 echo "Port is available for Use"
fi

port_number="$1"
image_size_gb="$2"

home_dir="$HOME"
jpdb_dir="$home_dir/jpdb"
cgi_bin_dir="$home_dir/cgi-bin"

# Check if jpdb directory exists, if not, create it
if [ ! -d "$jpdb_dir" ]; then
    echo "Creating jpdb directory..."
    mkdir "$jpdb_dir"
    echo "jpdb directory created."
else
    echo "jpdb directory already exists."
fi

# Check if cgi-bin directory exists, if not, create it
if [ ! -d "$cgi_bin_dir" ]; then
    echo "Creating cgi-bin directory..."
    mkdir "$cgi_bin_dir"
    echo "cgi-bin directory created."
else
    echo "cgi-bin directory already exists."
fi

# Displaying provided parameters
echo "Port number: $port_number"
echo "Image size in GB: $image_size_gb"

# Concatenate the image name based on the size provided
image_name="login2explore/jpdb032-openjdk8-${image_size_gb}gb"

echo "Image name: $image_name"

# Checking if SSL file location is provided
if [ "$#" -eq 3 ]; then
    ssl_file_location="$3"
    echo "SSL file location: $ssl_file_location"

    # Check if SSL file exists at the provided location
    if [ -f "$ssl_file_location" ]; then
        echo "SSL file found at $ssl_file_location."

        # Copy SSL file to jpdb folder
        echo "Copying SSL file to jpdb folder..."
        cp "$ssl_file_location" "$jpdb_dir/ssl.jks"
        echo "SSL file copied to jpdb folder."
    else
        echo "SSL file not found at $ssl_file_location."
    fi
else
    echo "SSL file location not provided."
fi

# Download the shell script from GitHub using wget
wget -O "$jpdb_dir/jpdb-env.sh" https://raw.githubusercontent.com/Login2Xplore/jpdb-docker/main/jpdb-env.sh

# Change the permissions of the downloaded shell script to make it executable
chmod +x "$jpdb_dir/jpdb-env.sh"

cd "$jpdb_dir"

# Run the shell script with the provided port number and image name as parameters
"./jpdb-env.sh" "$port_number" "$image_size_gb" "$image_name" 

# Delete the downloaded shell script
rm "jpdb-env.sh"