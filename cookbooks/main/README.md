Description
===========

Installs common libraries to "my" server configuration. The idea here is that this should be included on
every managed server.

It installs the following:

* zsh
* git-core
* htop
* python-software-properties
* logrotate

And sets up:

* a `www-data` group
* a `/var/www` folder

Requirements
============

None

Usage
=====

Simply include `main::common` in your node's runlist.