# Installing Chef Server

Chef, as many people will tell you, is awesome. What isn't awesome is their documentation. Now that they have a hosted solution out there, it seems like they're also a little less interested in giving all the answers away in the docs, but maybe I'm just reading too far into things ;)

At any rate, here are the steps I followed to get chef server up and running on one of my Ubu 12.04 machines.

## Pre-Requisites

Most of this is pretty straight-forward. I'm also assuming you've followed my Ubuntu 12.04 setup guide, so you'll have ruby and the chef gems installed.

So, run the following as root:

    curl -L https://raw.github.com/masterexploder/server-bootstrap/master/scripts/install-chef-server.sh | sh
    
This takes care of grabbing all the pre-requisites, creating upstart scripts, as well as a sample config file. Take a look at the script if you're interested in what it does, but its essentially just a consolodated version of the chef server manual install steps from their site.

## Configure the Server

The above script grabs a boilerplate config file and drops it in `/etc/chef/server.rb`. Go ahead and open that up, and make any changes that you feel are necessary, but most likely you'll only need to tweak the `chef_server_url`. When I'm doing this with VMs set up with host-only networking, I use the machine's IP address.

Next, we'll open up some ports in the iptables config, so (as root), add the following lines to `/etc/iptables.up.rules` (I put them below the port 80 and 443 lines):

    # Chef Server Ports
    -A INPUT -p tcp --dport 4000 -j ACCEPT
    -A INPUT -p tcp --dport 4040 -j ACCEPT
    
then run:
    
    iptables -F
    iptables-restore < /etc/iptables.up.rules
    
## Start Everything Up

Since the script created a bunch of upstart scripts, starting things is just a matter of running a few commands:

    start chef-expander
    start chef-solr
    start chef-server
    start chef-server-web
    
Once those have done their thing (which should be quick), you can open up a browser and hit the web UI at whatever URL you used for `chef_server_url` in the `server.rb` config. You should also take note of the admin credentials in there, which are `admin` and `p@ssw0rd1`. You'll be prompted to change that password on first login.

If you can hit the web UI and log in, you're ready to move on.

## Configure Knife Client

We'll want to run this as our normal user (in my examples, "vagrant"):

    mkdir -p ~/.chef
    sudo cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
    sudo chown -R $USER ~/.chef
    knife configure -i
    
Then answer the questions as follows:

    here should I put the config file? [/home/vagrant/.chef/knife.rb] 
    Please enter the chef server URL: [http://yourserver:4000] http://yourserver:4000
    Please enter a clientname for the new client: [vagrant] 
    Please enter the existing admin clientname: [chef-webui] 
    Please enter the location of the existing admin client's private key: [/etc/chef/webui.pem] .chef/webui.pem
    Please enter the validation clientname: [chef-validator] 
    Please enter the location of the validation key: [/etc/chef/validation.pem] .chef/validation.pem
    Please enter the path to a chef repository (or leave blank):
    
That's it. Let's make sure we've done everything right. Run `knife client list` and `knife cookbook list`. If you get output for the first, and nothing for the second, everything's good.

Next, we'll set up a client account to use on your laptop/desktop/whatever. So, again, on the server as the user you just set up knife with, run the following:

    knife client create my-username -d -a -f /tmp/my-username.pem
    knife client show my-username
    
That should yield some output to the nature of:

    _rev:        1-06766130209d9049babbd3b96488f4db
    admin:       true
    chef_type:   client
    json_class:  Chef::ApiClient
    name:        ian
    public_key:  -----BEGIN PUBLIC KEY-----
                 MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0yJQit7JiIVHx+kQYVhp
                 (...)
                 ZwIDAQAB
                 -----END PUBLIC KEY-----
                 
If we're good so far, it's time to set things up on your laptop. If you've made it this far, I'm going to assume you've got ruby installed locally, and you've installed the `chef` gem as well. If you haven't, do that.

OK, again, on your laptop, run the following:

    mkdir ~/.chef
    scp user@your-chef-server:/tmp/my-username.pem ~/.chef/my-username.pem
    scp user@your-chef-server:./.chef/validation.pem ~/.chef/validation.pem
    knife configure
    
And answer the questions accordingly (pay attention to the location of the validation.pem). Once more, to validate everything worked, run `knife client list` and `knife client show chef-validator`. You get output? Yeah? You rock, and your chef server is set up.