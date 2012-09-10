maintainer       "Ian Selby"
maintainer_email "ian@gxdlabs.com"
license          "MIT"
description      "Installs/Configures main"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends          "logrotate", "~> 0.8.2"

recipe           "main::common", "Common Packages For All Servers"