maintainer       "Ian Selby"
maintainer_email "ian@gxdlabs.com"
license          "MIT"
description      "Installs/Configures nginx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

recipe           "nginx::custom", "Installs custom nginx"
recipe           "nginx::configure", ""
recipe           "nginx::service", ""