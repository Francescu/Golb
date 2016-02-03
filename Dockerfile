FROM francescu/swift-webserver-epoch

RUN apt-get install postgresql-9.4 -y

ENV configuration=${GOLB_CONFIGURATION:-debug} 
WORKDIR /root/golb
ADD . /root/golb

RUN rm -rf .build && rm -rf Packages/ && swift build -c ${configuration}

ENTRYPOINT [".build/${configuration}/Server"]
