#
# Cookbook Name:: memcached
# Attributes:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default[:memcached][:memory]  = 64
default[:memcached][:port]    = 11211
default[:memcached][:user]    = "memcache"
default[:memcached][:listen]  = "127.0.0.1"
default[:memcached][:maxconn] = 1024