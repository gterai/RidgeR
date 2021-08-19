FROM ubuntu:20.04
RUN apt-get update -y; apt-get install -y libfindbin-libs-perl
WORKDIR /wdir
RUN apt-get install -y locales-all
RUN apt-get install -y python3
RUN apt-get install -y pip
RUN pip install pandas
RUN pip install sklearn
ADD workdir.tar.gz /
