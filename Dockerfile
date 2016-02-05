FROM francescu/swift-webserver-epoch

RUN apt-get install postgresql-9.4 -y

WORKDIR /root/golb
ADD . /root/golb

RUN rm -rf .build && rm -rf Packages/ && swift build -c ${GOLB_CONFIGURATION:-debug}

EXPOSE 8000

CMD ["sh", "-c", ".build/${GOLB_CONFIGURATION:-debug}/Server"]
