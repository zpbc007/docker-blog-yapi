FROM ubuntu:xenial

COPY ./config.json /yapi/
COPY ./yapi/ /yapi/vendors/

RUN apt-get update && \
    apt-get install -y  git mercurial openssh-client bash unzip curl locales build-essential sudo libltdl-dev && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && \
    apt install nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    cd /yapi/vendors && \
    npm install --production --registry https://registry.npm.taobao.org

WORKDIR /yapi/vendors

CMD npm start