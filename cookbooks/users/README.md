Description
===========
Creates users on your system based on what's in your data bags. Currently, you can create three types of users:

* Super Users - These users will be added to the `wheel` group, which has password-less sudo privileges
* Admins - These users will be added to the `admin` group, which has sudo privileges
* Deployers - These users are typically used for deployments (usually capistrano or the like)

Keep in mind this is for my typical server setup and configuration, and this may not work for you.

Requirements
============

Requires Chef 0.8+, and use of the `main::common` recipe, as well as, of course, data bags for your users. Make sure
you include these recipes in your run list after the `main::common` recipe.

Usage
=====

You'll need to create data bags for your various user types. Here's what a typical data bag for users looks like:

    {
      "id":       "ian",  # Unique ID for the data bag
      "name":     "ian",  # Username
      "password": "...",  # Password - See below
      "shell":    "zsh"   # What shell to use (valid values are "zsh" or "bash")
    }

To get the value for your password, run the following command on your machine (laptop, whatever):

    openssl passwd -1 "yourdesiredpassword"

That will spit out the password shadow to put in the data bag item.

In your chef server, head over to the "Databags" section, and create the following three databags:

* `super_users`
* `deploy_users`
* `admins`

Then add items to them accordingly :)