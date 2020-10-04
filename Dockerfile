FROM node:12.18.4-buster

ARG REVEALJS_VERSION="4.0.2"
ARG PORT="8000"

RUN apt-get update && apt-get install -y \
    apt-utils \ 
    git \
    tree \
    tmux \
    wget \
    unzip

RUN curl -o reveal.js.tgz -sSL https://github.com/hakimel/reveal.js/archive/${REVEALJS_VERSION}.tar.gz && \
    ls -l  &&\
    mkdir -p "/home/node/reveal.js" && \
    tar -C "/home/node/reveal.js" --strip-components=1 -xzvf reveal.js.tgz && \
    rm -rvf reveal.js.tgz && \
     tree -L 2 "/home/node/reveal.js"

RUN curl -o reveal-plugin.js.zip -sSL https://github.com/rajgoel/reveal.js-plugins/archive/8127033db8a223497d66ebddea08d4e829c7d297.zip && \
    curl -o reveal-menu.js.zip -sSL https://github.com/denehyg/reveal.js-menu/archive/a630970d81ed1242c31821a43a91645af74e56aa.zip && \
    ls -l  &&\
    unzip reveal-plugin.js.zip &&\
    unzip reveal-menu.js.zip &&\
    cd $(find ./ -type d -name "reveal.js-plugins-*" | head -n 1) &&\
    cp -avf ./* "/home/node/reveal.js/plugin/" && \
    cd $(find ../ -type d -name "reveal.js-menu-*" | head -n 1) &&\
    cp -avf ./* "/home/node/reveal.js/plugin/menu/" && \
    cd .. &&\
    rm -rvf "reveal-*" && \
    tree -L 2 "/home/node/reveal.js/plugin/"


RUN cd "/home/node/reveal.js" && \
    npm install && \
    pwd &&\
    ls -l

COPY "src" "/data"
RUN pwd && ls -l "/home/node/reveal.js"

EXPOSE ${PORT}
WORKDIR "/home/node/reveal.js/"
VOLUME "/data/"

CMD ["bash","-c", "pwd && cp -avf /data/*  /home/node/reveal.js && ls && npm start -- --port=${PORT}"]
# docker build -t slides .
# docker run -it  -v "$(pwd)"/src:"/data"  -p 8000:8000 --rm  slides:latest 

    