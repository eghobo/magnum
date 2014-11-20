#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

############################################################
# Dockerfile to build Python WSGI Application Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Davanum Srinivas

# Add the application resources URL
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications and Python tools
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential python python-dev python-distribute python-pip

# Copy the application folder inside the container
ADD . /magnum

# Get pip to download and install requirements:
RUN pip install -r /magnum/requirements.txt

# Expose ports
EXPOSE 5911

# Set the default directory where CMD will execute
WORKDIR /magnum

# Install magnum from source
RUN python setup.py install

# Set the default command to execute
# when creating a new container
CMD magnum-api --debug