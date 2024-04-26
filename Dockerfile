FROM ubuntu:24.04 AS texlive

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Tokyo

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    wget \
    curl \
    perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ref: https://texwiki.texjp.org/?Linux#texliveinstall
WORKDIR /tmp
RUN wget http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz --no-check-certificate \
    && tar xvf install-tl-unx.tar.gz \
    && cd install-tl* \
    && printf "%s\n" \
    "selected_scheme scheme-full" \
    "option_doc 0" \
    "option_src 0" \
    > ./texlive.profile \
    && ./install-tl -no-gui --profile=./texlive.profile -repository http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/
RUN /usr/local/texlive/????/bin/*/tlmgr path add
