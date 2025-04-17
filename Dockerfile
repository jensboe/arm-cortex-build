FROM ubuntu:22.04
ARG TOOLS_PATH=/opt/gcc-arm-none-eabi
ARG ARM_GCC_VERSION=13.2.rel1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      ninja-build \
      git \
      curl \
      gdb \
      clang-tidy \
      python3 \
      python3-pip \
      clang \
      ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# CMake (offizielles Install-Skript, da 4.0.0 nicht im Repo)
RUN curl -LO https://github.com/Kitware/CMake/releases/download/v3.29.3/cmake-3.29.3-linux-x86_64.sh && \
    sh cmake-3.29.3-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-3.29.3-linux-x86_64.sh
    
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
