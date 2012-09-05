# Cloning VirtualBox VMS

Sometimes I want to play around with some server configs or other mad science, and I usually do so with clones of a base image that I've set up (docs on that [here](https://github.com/masterexploder/server-bootstrap/blob/master/docs/12.04%20Setup.md)). Turns out there are some goofy things in newer versions of Ubuntu that make this a bit wonky.

## Creating the Clone

Let's start with the easy stuff. First, in VirtualBox, open the preferences (VirtualBox => Preferences on Mac), then click on the "Network" tab. Create a new network, then select it and click "edit". We'll be setting everything up with static IPs, so we can click on the "DHCP Server" tab, and make sure it's not enabled. Back on the "Adapter" tab, either take note of the IPv4 address, or put your own in. I like to use something like `10.0.30.1`

OK, close those preferences and head back to your list of VMs. Right-click on the VM you want to clone (should be a base image) and click "Clone". Give it a new name, and make sure you've chosen "re-initialize MAC addresses". Continue and choose "Full Clone", then finish.

Before you boot it the new clone up, let's tweak things a bit. We're going to add a new network adapter to the config, so highlight your new VM, click on "Settings", then "Network", then "Adapter 2". Enable it, attatch to host-only, and make sure it chooses the network we set up.

## Fix the Networking

Power up the VM, and wait for it to boot. It will take a while because network configs will be horked… don't worry about this, we'll fix it now. Once you've logged in, switch to root (`sudo su -`), then edit `/etc/udev/rules.d/70-persistent-net.rules`.

What you'll see in here will depend on a few things, but basically what has happened is that the old network device from the original machine will be present as `eth0`. You will also have at least an `eth1`, but possibly an `eth2` as well. Basically, we want to delete the old `eth0`, and rename the other adapters… so after delete `eth1 => eth0`, `eth2 => eth1`, and so on.  Once you've made those changes, reboot the machine. If it comes up quickly, without any complaints about networking, you're good.

## Assign a Static IP

Now that everything is working the way we need it to, let's get a static IP assigned to the new machine. As root, run the following command (adjusting the IP accordingly based on the above settings for the IPv4 address that we set earlier):

    ifconfig eth1 10.0.30.10 netmask 255.255.255.0 up
    
That should just run with no output. You can check that everything worked by running `ifconfig` and looking for your new `eth1` device with the proper IP address. You can also ping this address from the host machine to verify.

If that's working, let's make sure these changes stay permanent. Edit (as root) `/etc/network/interfaces` and add the following to the file (again, adjust appropriately):

    # The host-only network interface
    auto eth1
    iface eth1 inet static
    address 10.0.30.10
    netmask 255.255.255.0
    network 10.0.30.0
    broadcast 10.0.30.255

Reboot the machine, and make the same checks as above to verify that the address stuck.

## Changing the Host Name

You probably don't want this to have the same host name as the VM you cloned it from, so let's tweak a few things. Do all the following as root:

    hostname newhostname
    
    vi /etc/hostname
    # change the value to your new host name
    
    vi /etc/hosts
    # change the values in here as well
    
Reboot the machine one last time, and you're all set.