FROM i386/centos:7
RUN set -ex; \
curl https://download.oracle.com/berkeley-db/db-4.2.52.tar.gz | tar xz; \
yum install -y gcc gcc-c++ make
WORKDIR db-4.2.52/build_unix
RUN set -ex; \
CC=gcc CXX=g++ ../dist/configure --enable-cxx --with-pic --prefix=/opt/bdb; \
make -j$(nproc); \
make install

FROM i386/busybox:glibc
COPY --from=0 /opt/bdb /opt/bdb
ENV PATH="/opt/bdb/bin:${PATH}"
