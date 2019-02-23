FROM centos:7 as unrar-builder
RUN yum clean all && yum install -y git make gcc-c++
RUN git clone https://github.com/pmachapman/unrar.git
WORKDIR unrar
RUN make -j$(nproc) && make install

FROM alpine
VOLUME /out
COPY --from=unrar-builder /usr/bin/unrar /unrar
CMD ["cp", "-v", "/unrar", "/out/unrar"]
