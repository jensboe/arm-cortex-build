FROM ubuntu:mantic-20240530
ARG TOOLS_PATH=/opt/gcc-arm-none-eabi
ARG ARM_GCC_VERSION=13.2.rel1

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y cmake=4.0.0
RUN apt-get install -y ninja-build
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y gdb
RUN apt-get install -y clang-tidy
RUN apt-get install -y python3
RUN apt-get install -y clang

RUN mkdir ${TOOLS_PATH} \
    && curl -Lo gcc-arm-none-eabi.tar.xz https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_GCC_VERSION}/binrel/arm-gnu-toolchain-${ARM_GCC_VERSION}-x86_64-arm-none-eabi.tar.xz \
    && tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C ${TOOLS_PATH} \
    && rm gcc-arm-none-eabi.tar.xz \
    && rm ${TOOLS_PATH}/*.txt \
    && rm -rf ${TOOLS_PATH}/share/doc

# Add Toolchain to PATH
ENV PATH="$PATH:${TOOLS_PATH}/bin"

ADD entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
