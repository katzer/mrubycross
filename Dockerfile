# MIT License
#
# Copyright (c) 2024 Sebastián Katzer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation tasks (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM ubuntu:24.04

LABEL maintainer="katzer.sebastian@googlemail.com"

# libs
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        bison \
        clang \
        curl \
        git \
        mingw-w64 \
        musl \
        musl-tools \
        openssh-server \
        ruby \
        tar && \
    apt clean && apt autoremove -y

# rake
RUN echo "gem: --no-document" > ~/.gemrc && \
    gem install rake --force

# osx cross compiling tools
RUN git clone -q --depth=1 https://github.com/katzer/osxcross.git /opt/osxcross && rm -rf /opt/osxcross/.git && \
    DEBIAN_FRONTEND="noninteractive" TZ="Europe/Berlin" \
    apt install -y --no-install-recommends \
        cmake \
        libc++-18-dev \
        libssl-dev \
        libxml2-dev \
        lzma-dev \
        make \
        patch \
        python3 \
        tzdata \
        wget \
        xz-utils && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    cd /opt/osxcross/tarballs && \
    curl -L -o MacOSX11.3.sdk.tar.xz https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.3.sdk.tar.xz && \
    tar -xvf MacOSX11.3.sdk.tar.xz -C . && \
    cp -rf /usr/lib/llvm-18/include/c++ MacOSX11.3.sdk/usr/include/c++ && \
    cp -rf /usr/include/x86_64-linux-gnu/c++/13/bits/ MacOSX11.3.sdk/usr/include/c++/v1/bits && \
    tar -cJf MacOSX11.3.sdk.tar.xz MacOSX11.3.sdk && \
    cd /opt/osxcross && \
    UNATTENDED=1 SDK_VERSION=11.3 OSX_VERSION_MIN=10.15 USE_CLANG_AS=1 ./build.sh && \
    rm -rf *~ build tarballs/* && \
    apt remove -y --auto-remove \
        cmake \
        libc++-18-dev \
        libssl-dev \
        libxml2-dev \
        lzma-dev \
        make \
        patch \
        python3 \
        tzdata \
        wget \
        xz-utils
ENV PATH=/opt/osxcross/target/bin:$PATH
ENV MACOSX_DEPLOYMENT_TARGET=10.15
ENV OSXCROSS_MP_INC=1

# sshd
RUN mkdir -p $HOME/.ssh && \
    /etc/init.d/ssh start && \
    ssh-keygen -m PEM -t ecdsa -q -f $HOME/.ssh/dev.key -N "" && \
    echo `cat $HOME/.ssh/dev.key.pub` >> $HOME/.ssh/authorized_keys && \
    ssh-keygen -m PEM -t ecdsa -q -f $HOME/.ssh/devp.key -N "phrase" && \
    echo `cat $HOME/.ssh/devp.key.pub` >> $HOME/.ssh/authorized_keys && \
    ssh-keyscan -t ecdsa-sha2-nistp256 localhost >> $HOME/.ssh/known_hosts && \
    echo '/etc/init.d/ssh start' > $HOME/.sshdrc && \
    echo '/etc/init.d/ssh start\nssh-add $HOME/.ssh/dev.key' > $HOME/.sshrc

# mruby utils
RUN gem install mruby_utils:3.2.1
