#
# Cookbook Name:: main
# Recipe:: common
#
# Copyright 2012, Ian Selby
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

package "zsh"                        # used by some users, good to have around
package "git-core"                   # we need git... always
package "htop"                       # because its so much cooler than plain ol' top
package "python-software-properties" # used to add ppas

include_recipe "logrotate"           # we should rotate our logs

gem_package "ruby-shadow" do
  action :install
  options("--no-ri --no-rdoc")
end

# make sure we've got a www-data group
group "www-data" do
  action :create
end

# make sure we've got a /src folder, because that's where we'll compile things
directory "/src" do
  owner "root"
  mode  "0775"
  action :create
  recursive true
end

# make sure we've got a /var/www folder, and make sure the www-data group
# can write to it
directory "/var/www" do
  owner     "root"
  group     "www-data"
  mode      "0775"
  action    :create
  recursive true
end