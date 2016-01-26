FROM francescu/swift-webserver-epoch

WORKDIR /root/golb
ADD . /root/golb

RUN rm -rf .build && rm -rf Packages/ && swift build

ENTRYPOINT [".build/debug/Server"]
