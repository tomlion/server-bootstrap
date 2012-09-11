directory "/etc/ssl/" do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

template "/etc/ssl/server.crt" do
  source   "server.crt"
  owner    "root"
  group    "root"
  mode     "0644"
end

template "/etc/ssl/server.key" do
  source   "server.key"
  owner    "root"
  group    "root"
  mode     "0644"
end
