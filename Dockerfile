# base image ruby
FROM ruby:2.1

LABEL Name="docker-document-local Version=0.0.1"
LABEL maintainer="Donny Seo <jams7777@gmail.com>"

# Install wget and install/updates node  python-pygments
RUN apt-get clean \
  && mv /var/lib/apt/lists /var/lib/apt/lists.broke \
  && mkdir -p /var/lib/apt/lists/partial

RUN apt-get update

RUN apt-get install -y \
    node \
    python-pygments \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# work dir tmp bundle install
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# WORKDIR src
WORKDIR /src

# exec shell setting
COPY ./start.sh /root/start.sh
RUN chmod 777 /root/start.sh

# alais setting
RUN  echo "alias app='cd /src'" >> /root/.bashrc
RUN  echo "alias start='/root/start.sh'" >> /root/.bashrc

RUN  echo "echo " >> /root/.bashrc
RUN  echo "echo " >> /root/.bashrc
RUN  echo "echo ' ************  Danbee.Ai Documnet Local [ local ]     ************* ' " >> /root/.bashrc
RUN  echo "echo ' *****                                                            ******* ' " >> /root/.bashrc
RUN  echo "echo ' ***** << Alias >>                                                ******* ' " >> /root/.bashrc
RUN  echo "echo ' *****       app : Document app                                   ******* ' " >> /root/.bashrc
RUN  echo "echo ' *****     start : start jekyll server                            ******* ' " >> /root/.bashrc
RUN  echo "echo ' ************************************************************************ ' " >> /root/.bashrc

# Volume setting
VOLUME ["/src"]

# Port setting
EXPOSE 4000

CMD ["/bin/bash"]
