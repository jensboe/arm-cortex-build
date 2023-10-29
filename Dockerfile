FROM ubuntu:mantic-20231011
ARG TOOLS_PATH=/opt/gcc-arm-none-eabi

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y cmake=3.27.4-1
RUN apt-get install -y ninja-build
RUN apt-get install -y git
RUN apt-get install -y curl
RUN mkdir ${TOOLS_PATH} \
    && curl -Lo gcc-arm-none-eabi.tar.xz https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C ${TOOLS_PATH} \
    && rm gcc-arm-none-eabi.tar.xz \
    && rm ${TOOLS_PATH}/*.txt \
    && rm -rf ${TOOLS_PATH}/share/doc

# Add Toolchain to PATH
ENV PATH="$PATH:${TOOLS_PATH}/bin"

ADD entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]