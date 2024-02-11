FROM openjdk:8

RUN mkdir -p home/jpdb
RUN mkdir -p home/jpdb/bin
RUN mkdir -p home/jpdb/data
RUN mkdir -p home/jpdb/bin/public_html

COPY public_html home/jpdb/bin/public_html
COPY jpdb.jar home/jpdb/bin

RUN update-ca-certificates

WORKDIR "/home/jpdb"
RUN chmod -R a+rwx data


WORKDIR "/home/jpdb/data"

RUN apt-get -y update

# CMD ["java", "-jar", "../bin/jpdb.jar"]

# For VPS of 1GB RAM - VPS Swap should 2 GB - Docker memory 700 and swap 1400 
#CMD ["nohup", "java", "-Xms256m", "-Xmx512m", "-XX:+UseG1GC", "-jar", "../bin/jpdb.jar"]

# For VPS of 2GB RAM - VPS Swap should 4 GB - Docker memory 1400 and swap 2800 
CMD ["nohup", "java", "-Xms640m", "-Xmx1408m", "-XX:+UseG1GC", "-jar", "../bin/jpdb.jar"]

# For VPS of 4GB RAM - VPS Swap should 8 GB - Docker memory 3200 and swap 6400 
# CMD ["nohup", "java", "-Xms1408m", "-Xmx3g", "-XX:+UseG1GC", "-jar", "../bin/jpdb.jar"]

# For VPS of 8GB RAM - VPS Swap should 16 GB - Docker memory 7200 and swap 14400 
# CMD ["nohup", "java", "-Xms3g", "-Xmx7g", "-XX:+UseG1GC", "-jar", "../bin/jpdb.jar"]

EXPOSE 5577