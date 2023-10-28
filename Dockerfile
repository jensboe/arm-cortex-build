FROM ubuntu:23.10
ARG TOOLS_PATH=/opt/gcc-arm-none-eabi

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y ninja-build
RUN apt-get install -y git
RUN apt-get install -y curl
RUN mkdir ${TOOLS_PATH} \
    && curl -Lo gcc-arm-none-eabi.tar.xz https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C ${TOOLS_PATH} \
    && rm gcc-arm-none-eabi.tar.xz \
	&& rm ${TOOLS_PATH}/*.txt \
	&& rm -rf ${TOOLS_PATH}/share/doc

RUN echo cmake --version
RUN echo ninja-build --version
RUN echo arm-none-eabi-gcc --version


# Add Toolchain to PATH
ENV PATH="$PATH:${TOOLS_PATH}/bin"