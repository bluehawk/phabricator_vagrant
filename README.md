# Phabricator in Vagrant

This should be a fairly easy way to get a Phabricator install working, and I offer it to anyone that might find it useful.

That said, **This is offered AS-IS and I offer no promise that this will work for you, and am not obligated to help you get it working at all**.

## Instructions

1. Install VirtualBox and Vagrant (must be 1.5+)
1. Make sure that rsync is installed and working on your system.
1. Clone this repository.
1. Add `192.168.33.10 phabricator.local` to your hosts file
1. Run `./clone_phabricator`
1. Run `vagrant up`


