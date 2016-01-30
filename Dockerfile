FROM francescu/swift-webserver-epoch

RUN apt-get install postgresql-9.4 -y

WORKDIR /root/golb
ADD . /root/golb

RUN make database &&\
    rm -rf .build && rm -rf Packages/ && swift build

ENTRYPOINT [".build/debug/Server"]
