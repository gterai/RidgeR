FROM ubuntu:20.04
RUN apt-get update -y; apt-get install -y libfindbin-libs-perl
WORKDIR /qrna
RUN apt-get install -y locales-all
RUN apt-get install -y python3.8
RUN apt-get install -y pip
RUN pip install pandas==1.3.4
RUN pip install scikit-learn==1.0.1
RUN pip install seaborn==0.11.2
ADD workdir.tar.gz /
