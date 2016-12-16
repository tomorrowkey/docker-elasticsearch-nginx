FROM ubuntu:16.04
MAINTAINER Tomoki Yamashita <tomorrowkey@gmail.com>

USER root
WORKDIR /

# Install essential command
RUN apt-get update
RUN apt-get install -y curl

# Prepare repository
## td-agent
RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/ubuntu/xenial/ xenial contrib" > /etc/apt/sources.list.d/treasure-data.list
## elasticsearch
ENV ES_SKIP_SET_KERNEL_PARAMETERS true
RUN curl -L https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get install apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

# Upgrade software
RUN apt-get update && apt-get -y upgrade

# Install software
ENV TD_AGENT_VERSION 2.3.3-0
ENV JAVA_VERSION 8u111-b14-2ubuntu0.16.04.2
ENV ELASTICSEARCH_VERSION 5.1.1
ENV KIBANA_VERSION 5.1.1
ENV NGINX_VERSION 1.10.0-0ubuntu0.16.04.4
RUN apt-get install -y \
  td-agent=${TD_AGENT_VERSION} \
  openjdk-8-jdk=${JAVA_VERSION} \
  elasticsearch=${ELASTICSEARCH_VERSION} \
  kibana=${KIBANA_VERSION} \
  nginx=${NGINX_VERSION}

# Install fluent plugins for td-agent
RUN td-agent-gem install fluent-plugin-elasticsearch -v 1.9.1
RUN td-agent-gem install fluent-plugin-record-modifier -v 0.5.0

# Configure td-agent
COPY ./etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf
RUN cp /etc/init.d/td-agent /etc/init.d/td-agent.original
RUN sed -i -E "s/TD_AGENT_(USER|GROUP)=td-agent/TD_AGENT_\1=root/g" /etc/init.d/td-agent

# Configure elasticsearch
COPY ./etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
EXPOSE 9200

# Configure kibana
COPY ./etc/kibana/kibana.yml /etc/kibana/kibana.yml
EXPOSE 5601

# Configure nginx
COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./var/www/html /var/www/html
EXPOSE 80

# Copy entry script
COPY ./usr/local/etc/entry.sh /usr/local/etc
RUN chmod +x /usr/local/etc/entry.sh

ENTRYPOINT /usr/local/etc/entry.sh
