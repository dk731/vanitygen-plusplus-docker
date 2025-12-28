FROM nvidia/opencl:devel-ubuntu18.04 AS builder

RUN apt-get update && \
    apt-get install -y \
    build-essential libssl-dev libpcre3-dev \
    libcurl4-openssl-dev git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/10gic/vanitygen-plusplus.git /vanitygen-plusplus

WORKDIR /vanitygen-plusplus

RUN make all


FROM nvidia/opencl:runtime-ubuntu18.04

RUN apt-get update && \
    apt-get install -y \
    libssl-dev libpcre3-dev \
    libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/vanitygen

COPY --from=builder /vanitygen-plusplus/vanitygen++ ./vanitygen++
COPY --from=builder /vanitygen-plusplus/oclvanitygen++ ./oclvanitygen++
COPY --from=builder /vanitygen-plusplus/base58prefix.txt ./base58prefix.txt


ENTRYPOINT ["./oclvanitygen++"]