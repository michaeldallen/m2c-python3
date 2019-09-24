# Ubuntu

FROM ubuntu:xenial
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get update && apt-get -y install \
    \
    curl \
    \
    cowsay



# Python

RUN apt-get update && apt-get install -y python3 
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py
RUN pip install pytest 



# execution

WORKDIR /workdir

#EOF
