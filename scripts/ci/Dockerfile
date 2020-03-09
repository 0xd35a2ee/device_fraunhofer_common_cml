FROM debian:stretch


# Essentials
RUN apt-get update && apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping libsdl1.2-dev xterm lsb-release

# CI
#
# clang-9 toolchain for debian stretch
RUN echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-9 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-9 main" >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y clang-9 clang-tools-9 clang-9-doc libclang-common-9-dev libclang-9-dev libclang1-9 clang-format-9 python-clang-9 clangd-9 lld-9 lldb-9 libfuzzer-9-dev
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-9 100
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-9 100

# Image signing
RUN apt-get update && apt-get install -y python-protobuf python3-protobuf

# Qemu
RUN apt-get update && apt-get install -y qemu-kvm ovmf

# Bootable medium
RUN apt-get update && apt-get install -y util-linux btrfs-progs gdisk parted

RUN apt-get update && apt-get install -y screen locales ca-certificates gosu locales
RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

RUN apt-get update && apt-get install -y kmod procps curl

# trusted-connector build dependencies
# for new yarn based build of trusted-connector core compartment
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
	&& apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt-get update \
	&& apt-get install -y vim openjdk-8-jdk-headless openjdk-8-jre-headless yarn

# optee python dependings
RUN apt-get update && apt-get install -y python-crypto python3-crypto

WORKDIR "/opt/ws-yocto/"

#COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

