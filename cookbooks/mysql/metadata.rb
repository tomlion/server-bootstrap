maintainer       "Ian Selby"
maintainer_email "ian@gxdlabs.com"
license          "MIT"
description      "Installs/Configures mysql"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends          "openssl", "~> 1.0.0"

recipe           "mysql::server", "Installs the MySQL server"
recipe           "mysql::client", "Installs the libmysqlclient-dev package"
recipe           "mysql::service", ""