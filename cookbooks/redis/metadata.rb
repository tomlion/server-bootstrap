maintainer       "Ian Selby"
maintainer_email "ian@gxdlabs.com"
license          "MIT"
description      "Installs/Configures redis"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

recipe           "redis::server", "Installs the redis server"
recipe           "redis::configure", ""
recipe           "redis::service", ""