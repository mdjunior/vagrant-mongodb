#!/usr/bin/env bash
# -------------------------------------------------------------------
# Copyright (c) 2015 Manoel Domingues.  All Rights Reserved.
#
# This file is provided to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file
# except in compliance with the License.  You may obtain
# a copy of the License at
#
#   http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# -------------------------------------------------------------------

# Add MongoDB key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Add MongoDB repository
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list > /dev/null

# Only update added repository (to save time)
apt-get update -o Dir::Etc::sourcelist="sources.list.d/mongodb.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"

# Install MongoDB
apt-get install -y mongodb-org

# Comment out bind_ip to also allow connection from vagrant host
sed -i'' '/^bind_ip/ s/^/#/' /etc/mongod.conf

# Restart MongoDB
service mongod restart