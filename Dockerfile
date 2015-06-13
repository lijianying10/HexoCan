FROM scratch
MAINTAINER Jianying Li <lijianying12@gmail.com>

ADD ./rootfs.tar / 
RUN mkdir -p /app
WORKDIR /app
COPY ./static /app/
COPY ./public /public
RUN git clone git://gitcafe.com/lijianying12/lijianying12.git
EXPOSE 8080

CMD ["/app/static"]
