FROM node:12.18.4-buster

ARG REVEALJS_VERSION="4.0.2"
ARG PORT="8000"

RUN apt-get update && apt-get install -y \
    apt-utils \ 
    git \
    tree \
    tmux \
    wget

RUN curl -o reveal.js.tgz -sSL https://github.com/hakimel/reveal.js/archive/${REVEALJS_VERSION}.tar.gz && \
    ls -l  &&\
    mkdir -p "/home/node/reveal.js" && \
    tar -C "/home/node/reveal.js" --strip-components=1 -xzvf reveal.js.tgz && \
    rm -rvf reveal.js.tgz && \
    cd  "/home/node/reveal.js" && ls -l &&\
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

    