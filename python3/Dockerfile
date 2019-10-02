# Ubuntu
#
FROM ubuntu:18.04
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get update && apt-get -y install \
    \
    curl \
    python3 \
    python3-pip \
    \
    cowsay



# Python
#
RUN pip3 install pytest 



# execution
WORKDIR /workdir
ENTRYPOINT ["python3"]

#EOF
