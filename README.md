# ansible-ubuntu-postinstall
playbook to run package updates, adjust terminal/inputrc ...

## Background
This playbook grew out of a desire to both broaden my ansible knowledge as well as streamline certain aspects of my home network and lab, as I have my own ESXi servers.

## Structure
The playbook uses a typical roles-driven approach, but the folders for `defaults`, `host_vars`, or `group_vars` all contain empty `main.yml` files that can be customized as conditions warrant. Three roles are provided:
* `adjust-vimrc` : convenience settings for vim in `/etc/vimrc`
* `adjust-term` : control-arrow support for `xterm` and `linux` type
* `upgrade-os` : typical `apt -y update && apt -y upgrade` behavior

## Usage
A Makefile is used out of convenience, but is provided as one example of how the playbook can be invoked. The `hosts.yml` is mentions is excluded from the repo content, but takes the following form:
```
all:
  hosts:
  children:
    your_alias:
      hosts:
        actual_host:
          ansible_ssh_user: user_with_sudo
    # other group aliases and hosts optional
```
The following tags are present (corresponding to the roles above):
* adjustvim
* adjustterm
* upgradepkgs

Execute the playbook with `make post-install`; adding `TAGS="(tagname,..)" limits what roles are invoked. Aside from a `help` target, `post-install` is the only other option. 
