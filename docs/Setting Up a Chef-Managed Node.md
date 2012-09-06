# Setting Up a Chef Managed Node

This document covers the steps needed to get a server registered with a chef server. It assumes you've followed the standard 12.04 setup guide, and have a chef server set up per that guide as well.

## Use Knife to Create a Client Config

You only need to run this once, in a directory of your choice (as this creates files). Assuming you've got knife configured and all that good stuff, run the following (on your laptop):

    knife configure client ./
    
Of course, you can adjust the path however you want, but that command will create a `client.rb` and copy the `validation.pem` file to your working directory. If you get an error about the `validation.pem` not being found, make sure you've copied it locally, and then check your `~/.chef/knife.rb` file to validate the validation path is correct.

## Upload the Client Config to the New Server

The chef docs refer to a knife bootstrap that you can run, but since we've set up our base image to have chef installed by default, and because what this script does is somewhat black-box (unless you dig through their source), it's my preference to do this manually.

First, let's copy up our files to the server. From wherever you ran the `knife configure client` command above, run the following:

    scp client.rb validation.pem user@host:./

Next, log on to the server, and run:

    sudo mkdir -p /etc/chef
    sudo cp client.rb validation.pem /etc/chef
    sudo chef-client
    
That should run without issue. Then, if you pull up your chef server web UI, you should see this new server in the node list. If it showed up, all we need to do is install an upstart script to take care of running `chef-client` as a daemon on this machine.

So, grab my template (as root):

    wget https://raw.github.com/masterexploder/server-bootstrap/master/configs/chef/chef-client.conf -O /etc/init/chef-client.conf
    
Then start up the client with `start chef-client`. You can then tail the log (`/var/log/chef-client.log`) and make sure everything's running as it should be. You can edit the properties in `/etc/init/chef-client.conf` to suit your needs (intervals, splay, etc.)

You can also manually execute a chef run at any time by running `chef-client` as the root user (or `sudo chef-client` I suppose).

Disco.


    