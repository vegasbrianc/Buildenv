#
# BuildEnv Dockerfile
#
# Author: Brian Christner
#

# Pull base image.
##
# NodeJS MongoDB Redis
#
# This creates an image which contains an environment for NodeJS app ecosystem
# - Node.js 0.10.23
# - MongoDB 2.4.8
# - Redis 2.4.15
# - RabbitMQ 
##

FROM dockerfile/nodejs-bower-grunt

MAINTAINER Brian Christner

Run apt-get update

# Configure Package Management System (APT) & install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 \
 && echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list \
 && apt-get install -y mongodb

# Redis server
RUN apt-get install -y redis-server

# RabbitMQ 
Run apt-get install -y rabbitmq-server

# Start MongoDB
CMD mongod --fork -f /etc/mongodb.conf \
 && redis-server /etc/redis/redis.conf \
 && rabbitmq-start \
 && bash
